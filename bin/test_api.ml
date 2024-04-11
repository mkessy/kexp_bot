let test_create_completion prompt =
  match%lwt Api.Endpoints.create_completion ~prompt with
  | Ok response ->
    (match Api.Endpoints.get_response_text response with
     | Some text -> Lwt_io.printf "Model response: %s\n" text
     | None -> Lwt_io.printf "No response text found\n")
  | Error (`Json_error msg) -> Lwt_io.printf "JSON error: %s\n" msg
  | Error (`Http_error (code, body)) -> Lwt_io.printf "HTTP error: %d - %s\n" code body
  | Error (`Curl_error (code, msg)) -> Lwt_io.printf "cURL error: %d - %s\n" code msg
;;

let run_tests () =
  let prompts =
    [ "Hello, Claude!"; "What is the capital of France?"; "Tell me a joke." ]
  in
  Lwt_list.iter_s test_create_completion prompts
;;

let () = Lwt_main.run (run_tests ())
