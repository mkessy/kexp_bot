open Ingest
open Db

let run_update () =
  let open Lwt_result.Syntax in
  let* conn = Db.connect () in
  update_shows conn
;;

let handle_error = function
  | `Curl_error (code, msg) -> Lwt_io.eprintf "Curl error (%d): %s\n" code msg
  | `Http_error (code, msg) -> Lwt_io.eprintf "HTTP error (%d): %s\n" code msg
  | #Caqti_error.t as e -> Lwt_io.eprintf "Error: %s\n" (Caqti_error.show e)
;;

match Lwt_main.run (run_update ()) with
| Ok () -> Lwt_io.printf "Show update completed successfully.\n"
| Error err -> handle_error err
