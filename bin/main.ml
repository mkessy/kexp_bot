(* let db_path = "sqlite3:kexp.sqlite";; *)

match Lwt_main.run (Api.Endpoints.Api.get_programs ~limit:100 ()) with
| Ok shows_response -> print_string (Api.Api_j.string_of_program_response shows_response)
| Error e ->
  (match e with
   | `Curl_error (_, str) -> print_string ("Curl error: " ^ str)
   | `Http_error (_, str) -> print_string ("Unknown error: " ^ str))
