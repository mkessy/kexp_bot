(* let run_test () =
   let open Lwt_result.Syntax in
   let* conn = Db.connect () in
   print_endline Printf.(sprintf "Current working directory: %s" (Sys.getcwd ()));
   Controller.Playlist.Playlist.get_by_id ~id:1 conn
   ;; *)

let _run_test_cover_art () =
  let open Lwt_result.Syntax in
  let* res =
    Api.Endpoints.get_cover_art_by_release_group
      ~release_group_id:"5c61b138-6ffa-4f14-a156-25e6d6e70120"
  in
  let res_string = Api.Api_j.string_of_release_group_response res in
  print_string res_string;
  Lwt_result.return ()
;;

let run_test_search () =
  let open Db in
  let open Lwt_result.Syntax in
  let* conn = Db.connect () in
  Controller.Search.Search.search ~limit:25 ~query_string:"The Beat" conn
;;

let _pp_option ppf = function
  | None -> Format.fprintf ppf "None"
  | Some v -> Format.fprintf ppf "Some (%s)" v
;;

let _pp_tuple ppf (i, (s1, (opt_s2, (s3, s4)))) =
  Format.fprintf ppf "(%d, (%s, (%a, (%s, %s))))" i s1 _pp_option opt_s2 s3 s4
;;

let handle_error = function
  | `Curl_error (code, msg) -> Lwt_io.eprintf "Curl error (%d): %s\n" code msg
  | `Http_error (code, msg) -> Lwt_io.eprintf "HTTP error (%d): %s\n" code msg
  | #Caqti_error.t as e -> Lwt_io.eprintf "Error: %s\n" (Caqti_error.show e)
;;

(* match Lwt_main.run (run_test ()) with
   | Ok (Some playlist) ->
   print_endline (Format.sprintf "%d" (List.length playlist.songs));
   Lwt.return_unit
   | Ok None -> Lwt_io.printl "No playlist found"
   | Error err -> handle_error err *)

let _ =
  match Lwt_main.run (run_test_search ()) with
  | Ok res ->
    let () = print_string (List.length res |> string_of_int) in
    Lwt.return ()
  | Error err -> handle_error err
;;
