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
  if List.length program_response = 0
  then Lwt.return (Ok ())
  else (
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
    Program.Program.insert_many ~programs conn)
;;

let ingest_shows (shows : Api_t.show list) conn =
  let open Controller in
  if List.length shows = 0
  then Lwt.return (Ok ())
  else (
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
    Show.Show.insert_many ~shows conn)
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
  if List.length trackplays = 0
  then (
    print_string "No trackplays to ingest\n";
    Lwt.return (Ok ()))
  else Play.Play.insert_many ~plays:(List.rev trackplays) conn
;;

let ingest_artist (artist_ids : string list) conn =
  let open Controller in
  if List.length artist_ids = 0
  then Lwt.return (Ok ())
  else Artist.Artist.insert_many ~artists:artist_ids conn
;;

let ingest_songs (songs : Model.Song.t list) conn =
  let open Controller in
  if List.length songs = 0 then Lwt.return (Ok ()) else Song.Song.insert_many ~songs conn
;;

let song_artists_of_plays (plays : Api_t.play list) =
  let open Model in
  if List.length plays = 0
  then []
  else
    List.fold_left
      (fun acc (play : Api_t.play) ->
        match
          song_id_of_play play, artist_ids_set_of_plays [ play ], play.artist, play.album
        with
        | Some song_id, artist_ids, Some artist, Some album ->
          List.map
            (fun artist_id -> Song_artist.make ~song_id ~artist_id ~artist ~album ())
            artist_ids
        | Some song_id, artist_ids, Some artist, None ->
          List.map
            (fun artist_id -> Song_artist.make ~song_id ~artist_id ~artist ())
            artist_ids
        | Some song_id, artist_ids, None, Some album ->
          List.map
            (fun artist_id -> Song_artist.make ~song_id ~artist_id ~album ())
            artist_ids
        | Some song_id, artist_ids, None, None ->
          List.map (fun artist_id -> Song_artist.make ~song_id ~artist_id ()) artist_ids
        | _ -> acc)
      []
      plays
;;

let ingest_song_artist (song_artists : Model.Song_artist.t list) conn =
  let open Controller in
  if List.length song_artists = 0
  then Lwt.return (Ok ())
  else Artist.Artist.insert_many_song_artist ~song_artists conn
;;

let ingest_plays (plays : Api_t.play list) conn =
  let open Db in
  let open Lwt_result.Syntax in
  print_endline (Printf.sprintf "Ingesting %d plays" (List.length plays));
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
    if List.length new_programs = 0
    then (
      print_endline "No new programs to ingest";
      Lwt.return (Ok ()))
    else
      let* () = ingest_programs new_programs conn in
      Lwt.return (Ok ())
  | None ->
    let* () = ingest_programs programs.results conn in
    Lwt.return (Ok ())
;;

let update_shows conn =
  let open Lwt_result.Syntax in
  let open Controller.Show in
  let* latest_show_id = Show.get_latest () conn in
  let limit = 200 in
  let rec fetch_and_ingest_shows next =
    print_endline (Printf.sprintf "Fetching shows with limit %d" limit);
    let* shows = Endpoints.get_shows ~limit ~next () in
    match latest_show_id with
    | Some latest ->
      let new_shows = List.filter (fun (s : Api_t.show) -> s.id > latest) shows.results in
      let new_shows_count = List.length new_shows in
      if new_shows_count = 0
      then (
        print_endline "No new shows to ingest";
        Lwt.return (Ok ()))
      else (
        print_endline (Printf.sprintf "Ingesting %d new shows" new_shows_count);
        let* () = ingest_shows new_shows conn in
        match shows.next with
        | Some next -> fetch_and_ingest_shows next
        | None -> Lwt.return (Ok ()))
    | None ->
      let* () = ingest_shows shows.results conn in
      (match shows.next with
       | Some next -> fetch_and_ingest_shows next
       | None -> Lwt.return (Ok ()))
  in
  fetch_and_ingest_shows
    (Uri.to_string (Endpoints.endpoint_to_uri ~endpoint:`Shows ~limit ()))
;;

let update_plays ?(limit = 20) conn =
  let open Lwt_result.Syntax in
  let open Controller.Play in
  let open Controller.Show in
  let* latest_show_id = Show.get_latest () conn in
  let* latest_play_airdate = Play.get_latest_by_airdate () conn in
  let rec fetch_and_ingest_plays next =
    let* plays = Endpoints.get_plays ~limit ~next () in
    print_endline
      (Printf.sprintf
         "Latest show id: %s, latest play airdate: %s"
         (Option.value ~default:"None" (Option.map string_of_int latest_show_id))
         (Option.value ~default:"None" latest_play_airdate));
    match latest_play_airdate, latest_show_id with
    | Some latest_airdate, Some latest_show ->
      let new_plays =
        List.filter
          (fun (p : Api_t.play) -> Date.( > ) p.airdate latest_airdate)
          plays.results
        (* check if we need to update shows if any of the plays have a .show past the latest *)
      in
      let new_plays_count = List.length new_plays in
      print_endline (Printf.sprintf "Found %d new plays" new_plays_count);
      if new_plays_count = 0
      then (
        print_endline "No new plays to ingest";
        Lwt.return (Ok ()))
      else (
        let should_update_shows =
          List.exists (fun (p : Api_t.play) -> p.show > latest_show) new_plays
        in
        match should_update_shows with
        | true ->
          let* () = update_shows conn in
          let* () = ingest_plays new_plays conn in
          (match plays.next with
           | Some next -> fetch_and_ingest_plays next
           | None -> Lwt.return (Ok ()))
        | false ->
          let* () = ingest_plays new_plays conn in
          (match plays.next with
           | Some next -> fetch_and_ingest_plays next
           | None -> Lwt.return (Ok ())))
    | _, _ ->
      let* () = ingest_plays plays.results conn in
      (match plays.next with
       | Some next -> fetch_and_ingest_plays next
       | None -> Lwt.return (Ok ()))
  in
  fetch_and_ingest_plays
    (Uri.to_string (Endpoints.endpoint_to_uri ~endpoint:`Plays ~limit ()))
;;
