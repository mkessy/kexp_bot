(* let db_path = "sqlite3:kexp.sqlite";; *)

match Lwt_main.run (Api.Endpoints.get_shows ()) with
| Ok shows_response -> print_string (Api.Api_j.string_of_shows_response shows_response)
| Error e ->
  (match e with
   | `Curl_error (_, str) -> print_string ("Curl error: " ^ str)
   | `Http_error (_, str) -> print_string ("Unknown error: " ^ str))
