module Api = struct
  type endpoint =
    [ `Plays
    | `Shows
    | `Programs
    ]

  let base_url = "https://api.kexp.org"

  type http_error =
    [ `Http_error of int * string
    | `Curl_error of int * string
    ]

  let endpoint_to_uri ~endpoint ?(limit = 20) ?(offset = 20) () =
    let base_uri = Uri.of_string base_url in
    let ep =
      match endpoint with
      | `Plays -> "/v2/plays/"
      | `Shows -> "/v2/shows/"
      | `Programs -> "/v2/programs/"
    in
    let query_params =
      [ "limit", [ string_of_int limit ]
      ; "offset", [ string_of_int offset ]
      ; "format", [ "json" ]
      ]
    in
    (Uri.with_path base_uri ep |> Uri.add_query_params) @@ query_params
  ;;

  let get ~endpoint ?limit ?offset () =
    let headers =
      [ "Content-Type", "application/json; charset=utf-8"
      ; "Accept", "application/json"
      ; "User-Agent", "YourApp/1.0"
      ; "Cache-Control", "no-cache"
      ; "Pragma", "no-cache"
      ; "Expires", "0"
      ]
    in
    let client = Ezcurl_lwt.make () in
    let url = endpoint_to_uri ~endpoint ?limit ?offset () |> Uri.to_string in
    let open Lwt.Infix in
    Ezcurl_lwt.get ~headers ~client ~url ()
    >>= fun res ->
    match res with
    | Ok res when res.code >= 200 && res.code < 300 -> Lwt_result.return res.body
    | Ok res -> Lwt_result.fail (`Http_error (res.code, res.body))
    | Error (code, mes) -> Lwt_result.fail (`Curl_error (Curl.errno code, mes))
  ;;

  let get_plays ?limit ?offset () =
    let open Lwt_result.Syntax in
    let* res = get ~endpoint:`Plays ?limit ?offset () in
    let () = print_string res in
    let plays_response = Api_j.plays_response_of_string res in
    Lwt_result.return plays_response
  ;;

  let get_shows ?limit ?offset () =
    let open Lwt_result.Syntax in
    let* res = get ~endpoint:`Shows ?limit ?offset () in
    let shows_response = Api_j.shows_response_of_string res in
    Lwt_result.return shows_response
  ;;

  let get_programs ?limit ?offset () =
    let open Lwt_result.Syntax in
    let* res = get ~endpoint:`Programs ?limit ?offset () in
    let programs_response = Api_j.program_response_of_string res in
    Lwt_result.return programs_response
  ;;
end
