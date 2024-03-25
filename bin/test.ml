open Db

let run_test () =
  let open Lwt_result.Syntax in
  let* conn = Db.connect () in
  (*print current working directory*)
  print_endline Printf.(sprintf "Current working directory: %s" (Sys.getcwd ()));
  (*print top songs of the past 7 days with at least 4 plays*)
  (*print top songs of the past 30 days with at least 4 plays*)
  Controller.Playlist.Playlist.get_by_id ~id:1 conn
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

match Lwt_main.run (run_test ()) with
| Ok (Some playlist) ->
  print_endline (Format.sprintf "%d" (List.length playlist.songs));
  Lwt.return_unit
| Ok None -> Lwt_io.printl "No playlist found"
| Error err -> handle_error err
