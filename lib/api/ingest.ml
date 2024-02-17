(* ingest a song from a plays response*)
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
  let open Util in
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

let ingest_programs (program_response : Api_t.program_response) conn =
  let open Model in
  let programs =
    List.map
      (fun (p : Api_t.program) ->
        let program =
          Program.make
            ~id:p.id
            ~uri:p.uri
            ~name:p.name
            ~is_active:p.is_active
            ~description:p.description
            ()
        in
        program)
      program_response.results
  in
  Controller.Program.Program.insert_many ~programs conn
;;

let ingest_shows (show_response : Api_t.shows_response) conn =
  let open Model in
  let shows =
    List.map
      (fun (s : Api_t.show) ->
        let show =
          Show.make
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
      show_response.results
  in
  Controller.Show.Show.insert_many ~shows conn
;;

let ingest_play (plays : Api_t.plays_response) conn =
  let open Model in
  let trackplays =
    List.fold_left
      (fun acc (play : Api_t.play) ->
        match
          play.play_type, song_id_of_play play, parse_and_format_to_utcz play.airdate
        with
        | "trackplay", Some song_id, Some airdate ->
          Play.make
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
      plays.results
  in
  Controller.Play.Play.insert_many ~plays:(List.rev trackplays) conn
;;

let ingest_artist (artist_ids : string list) conn =
  Controller.Artist.Artist.insert_many ~artists:artist_ids conn
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
