open Kexp_bot
open Ingest
open Db

let run_update () =
  let open Lwt_result.Syntax in
  let* conn = Db.connect () in
  update_plays ~limit:5 conn
;;

let sleep_n n = Lwt_unix.sleep n

(* error handling function *)

let handle_error = function
  | `Curl_error (code, msg) -> Lwt_io.eprintf "Curl error (%d): %s\n" code msg
  | `Http_error (code, msg) -> Lwt_io.eprintf "HTTP error (%d): %s\n" code msg
  | #Caqti_error.t as e -> Lwt_io.eprintf "Error: %s\n" (Caqti_error.show e)
;;

(* runs the update every 60 seconds wrapped in an lwt.async function*)
let run_update_task ~interval () =
  let open Lwt.Infix in
  let rec loop () =
    match%lwt run_update () with
    | Ok _ -> sleep_n interval >>= loop
    | Error e -> handle_error e >>= fun _ -> sleep_n interval >>= loop
  in
  Lwt.async loop
;;

let server = Dream.logger @@ Dream.sql_pool "sqlite3:kexp.sqlite" @@ Router.router

let _main () =
  run_update_task ~interval:10.0 ();
  Dream.run server
;;

_main ()
