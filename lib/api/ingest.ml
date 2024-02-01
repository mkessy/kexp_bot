(* ingest a song from a plays response*)

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
  let open Controller.Program in
  let open Lwt_result.Infix in
  Program.get_all () conn
  >>= fun current_programs ->
  (* filter out programs already in current_programs by id *)
  let new_programs =
    program_response.results
    |> List.filter (fun (program : Api_t.program) ->
      not (List.exists (fun (p : Model.Program.t) -> p.id = program.id) current_programs))
  in
  Lwt_result.return new_programs
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
