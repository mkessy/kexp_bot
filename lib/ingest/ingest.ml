(* ingest a song from a plays response*)
open Api
open Util

let song_id_of_play (play : Api_t.play) =
  let artist = play.artist in
  let song = play.song in
  match artist, song with
  | Some artist, Some song ->
    Some
      ([ artist; song ]
       |> List.map (fun s -> s |> String.trim |> String.lowercase_ascii)
       |> String.concat "-")
  | _ -> None
;;

let song_of_play (play : Api_t.play) =
  let open Model in
  let song_id = song_id_of_play play in
  match song_id, play.song, play.artist, play.is_local, play.is_request with
  | Some song_id, Some song, Some artist, Some is_local, Some is_request ->
    Some
      (Song.make
         ~song_id
         ~song
         ~artist
         ~is_local
         ~is_request
         ?recording_id:play.recording_id
         ?album:play.album
         ?thumbnail_uri:play.thumbnail_uri
         ?release_group_id:play.release_group_id
         ?release_id:play.released_id
         ?rotation_status:play.rotation_status
         ())
  | _ -> None
;;

let artist_ids_set_of_plays (plays : Api_t.play list) =
  List.fold_left
    (fun acc (play : Api_t.play) ->
      match play.artist_ids with
      | Some artist_ids -> StringSet.of_list artist_ids |> StringSet.union acc
      | None -> acc)
    StringSet.empty
    plays
  |> StringSet.to_seq
  |> List.of_seq
;;

let ingest_programs (program_response : Api.Api_t.program list) conn =
  let open Controller in
  let programs =
    List.map
      (fun (p : Api_t.program) ->
        let program =
          Model.Program.make
            ~id:p.id
            ~uri:p.uri
            ~name:p.name
            ~is_active:p.is_active
            ~description:p.description
            ()
        in
        program)
      program_response
  in
  Program.Program.insert_many ~programs conn
;;

let ingest_shows (shows : Api_t.show list) conn =
  let open Controller in
  let shows =
    List.map
      (fun (s : Api_t.show) ->
        let show =
          Model.Show.make
            ~id:s.id
            ~uri:s.uri
            ~start_time:s.start_time
            ~program:s.program
            ~program_uri:s.program_uri
            ~program_name:s.program_name
            ~program_tags:s.program_tags
            ~tagline:s.tagline
            ()
        in
        show)
      shows
  in
  Show.Show.insert_many ~shows conn
;;

let ingest_play (plays : Api_t.play list) conn =
  let open Controller in
  let trackplays =
    List.fold_left
      (fun acc (play : Api_t.play) ->
        match
          play.play_type, song_id_of_play play, Date.parse_and_format_to_utcz play.airdate
        with
        | "trackplay", Some song_id, Some airdate ->
          Model.Play.make
            ~id:play.id
            ~song_id
            ~airdate
            ~show:play.show
            ~uri:play.uri
            ~comment:(Option.value play.comment ~default:"")
            ~show_uri:play.show_uri
            ()
          :: acc
        | _ -> acc)
      []
      plays
  in
  Play.Play.insert_many ~plays:(List.rev trackplays) conn
;;

let ingest_artist (artist_ids : string list) conn =
  let open Controller in
  Artist.Artist.insert_many ~artists:artist_ids conn
;;

let ingest_songs (songs : Model.Song.t list) conn =
  let open Controller in
  Song.Song.insert_many ~songs conn
;;

let song_artists_of_plays (plays : Api_t.play list) =
  let open Model in
  List.fold_left
    (fun acc (play : Api_t.play) ->
      match song_id_of_play play, artist_ids_set_of_plays [ play ] with
      | Some song_id, artist_ids ->
        List.map (fun artist_id -> Song_artist.make ~song_id ~artist_id) artist_ids
      | _ -> acc)
    []
    plays
;;

let ingest_song_artist (song_artists : Model.Song_artist.t list) conn =
  let open Controller in
  Artist.Artist.insert_many_song_artist ~song_artists conn
;;

let ingest_plays (plays : Api_t.play list) conn =
  let open Db in
  let open Lwt_result.Syntax in
  let songs =
    List.fold_left
      (fun acc play ->
        match song_of_play play with
        | Some song -> song :: acc
        | None -> acc)
      []
      plays
  in
  let artist_ids = artist_ids_set_of_plays plays in
  let song_artists = song_artists_of_plays plays in
  let queries =
    [ ingest_songs songs
    ; ingest_play plays
    ; ingest_artist artist_ids
    ; ingest_song_artist song_artists
    ]
  in
  let* () = Db.transaction queries conn in
  Lwt.return (Ok ())
;;

(*
   - get latest program id
   - response is unordered but there are only ~40 programs so we can just fetch all of them and filter out
   - any with an id less than the latest program id
*)
let update_programs conn =
  let open Lwt_result.Syntax in
  let open Controller.Program in
  let* latest_program_id = Program.get_latest () conn in
  let* programs = Endpoints.get_programs ~limit:100 () in
  match latest_program_id with
  | Some latest_program_id ->
    let new_programs =
      List.filter (fun (p : Api_t.program) -> p.id > latest_program_id) programs.results
    in
    let* () = ingest_programs new_programs conn in
    Lwt.return (Ok ())
  | None ->
    let* () = ingest_programs programs.results conn in
    Lwt.return (Ok ())
;;

(*
   - shows response is ordered by id
   - get latest show id
   - fetch shows 200 at a time and ingest any shows with an id greater than the latest show id
   - repeate recursively until no more shows are returned (next is None)
*)

let update_shows conn =
  let open Lwt_result.Syntax in
  let open Controller.Show in
  let* latest_show_id = Show.get_latest () conn in
  let rec fetch_and_ingest_shows next =
    let* shows = Endpoints.get_shows ~limit:200 ~next () in
    match latest_show_id with
    | Some latest ->
      let new_shows = List.filter (fun (s : Api_t.show) -> s.id > latest) shows.results in
      if List.length new_shows = 0
      then Lwt.return (Ok ())
      else
        let* () = ingest_shows new_shows conn in
        (match shows.next with
         | Some next -> fetch_and_ingest_shows next
         | None -> Lwt.return (Ok ()))
    | None ->
      let* () = ingest_shows shows.results conn in
      (match shows.next with
       | Some next -> fetch_and_ingest_shows next
       | None -> Lwt.return (Ok ()))
  in
  fetch_and_ingest_shows (Endpoints.string_of_endpoint `Shows)
;;

(* TODO: add logic to check if any plays have not yet ingested shows or programs *)
let update_plays conn =
  let open Lwt_result.Syntax in
  let open Controller.Play in
  let* latest_play_airdate = Play.get_latest_by_airdate () conn in
  let rec fetch_and_ingest_plays next =
    let* plays = Endpoints.get_plays ~limit:200 ~next () in
    match latest_play_airdate with
    | Some latest ->
      let new_plays =
        List.filter (fun (p : Api_t.play) -> Date.( >= ) p.airdate latest) plays.results
      in
      if List.length new_plays = 0
      then Lwt.return (Ok ())
      else
        let* () = ingest_plays new_plays conn in
        (match plays.next with
         | Some next -> fetch_and_ingest_plays next
         | None -> Lwt.return (Ok ()))
    | None ->
      let* () = ingest_plays plays.results conn in
      (match plays.next with
       | Some next -> fetch_and_ingest_plays next
       | None -> Lwt.return (Ok ()))
  in
  fetch_and_ingest_plays (Endpoints.string_of_endpoint `Plays)
;;

(*
   Ingest steps.

   1. Insert song into song table.
   2. ensure program exists if not insert program
   3. ensure show exists if not insert show
   4. insert play into play table
   5. insert artist into artist table
   6. insert song_artist into song_artist table
*)
