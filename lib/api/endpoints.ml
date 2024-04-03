type endpoint =
  [ `Plays
  | `Shows
  | `Programs
  | `Next_plays of string
  | `Next_shows of string
  | `Next_programs of string
  | `Cover_art_by_release of string
  | `Cover_art_by_release_group of string
  ]

let base_url = "https://api.kexp.org"
let base_cover_art_url = "http://coverartarchive.org"

let string_of_endpoint (endpoint : endpoint) =
  match endpoint with
  | `Plays -> "/v2/plays/"
  | `Shows -> "/v2/shows/"
  | `Programs -> "/v2/programs/"
  | `Next_plays next | `Next_shows next | `Next_programs next -> next
  | `Cover_art_by_release release_id -> "/release/" ^ release_id
  | `Cover_art_by_release_group release_group_id -> "/release-group/" ^ release_group_id
;;

type http_error =
  [ `Http_error of int * string
  | `Curl_error of int * string
  ]

let endpoint_to_uri ~(endpoint : endpoint) ?(limit = 20) ?(offset = 0) () =
  let base_uri = Uri.of_string base_url in
  let base_cover_art_uri = Uri.of_string base_cover_art_url in
  match endpoint with
  | `Next_plays next | `Next_shows next | `Next_programs next -> Uri.of_string next
  | `Plays | `Shows | `Programs ->
    let ep = string_of_endpoint endpoint in
    let query_params =
      [ "limit", [ string_of_int limit ]
      ; "offset", [ string_of_int offset ]
      ; "format", [ "json" ]
      ]
    in
    Uri.with_path base_uri ep |> fun uri -> Uri.add_query_params uri query_params
  | `Cover_art_by_release release_id ->
    let ep = string_of_endpoint (`Cover_art_by_release release_id) in
    Uri.with_path base_cover_art_uri ep
  | `Cover_art_by_release_group release_group_id ->
    let ep = string_of_endpoint (`Cover_art_by_release_group release_group_id) in
    Uri.with_path base_cover_art_uri ep
;;

let get ~endpoint ?limit ?offset () =
  let headers =
    [ "Content-Type", "application/json; charset=utf-8"
    ; "Accept", "application/json"
    ; "User-Agent", "Kexp/1.0"
    ; "Cache-Control", "no-cache"
    ; "Pragma", "no-cache"
    ; "Expires", "0"
    ]
  in
  let client = Ezcurl_lwt.make () in
  let url = endpoint_to_uri ~endpoint ?limit ?offset () |> Uri.to_string in
  print_endline url;
  let open Lwt.Infix in
  Ezcurl_lwt.get ~headers ~client ~url ()
  >>= fun res ->
  match res with
  | Ok res when res.code >= 200 && res.code < 300 -> Lwt_result.return res.body
  | Ok res -> Lwt_result.fail (`Http_error (res.code, res.body))
  | Error (code, mes) -> Lwt_result.fail (`Curl_error (Curl.errno code, mes))
;;

let get_cover_art_by_release ~release_id =
  let open Lwt_result.Syntax in
  let* res = get ~endpoint:(`Cover_art_by_release release_id) () in
  print_string res;
  try
    let cover_art_response = Api_j.release_group_response_of_string res in
    Lwt_result.return cover_art_response
  with
  | Yojson.Json_error e ->
    print_string e;
    Lwt_result.fail (`Json_error e)
;;

let get_cover_art_by_release_group ~release_group_id =
  let open Lwt_result.Syntax in
  let* res = get ~endpoint:(`Cover_art_by_release_group release_group_id) () in
  print_string res;
  try
    let cover_art_response = Api_j.release_group_response_of_string res in
    Lwt_result.return cover_art_response
  with
  | Yojson.Json_error e ->
    print_string e;
    Lwt_result.fail (`Json_error e)
;;

let get_plays ?limit ?offset ?next () =
  let open Lwt_result.Syntax in
  let* res =
    match next with
    | Some next -> get ~endpoint:(`Next_plays next) ()
    | None -> get ~endpoint:`Plays ?limit ?offset ()
  in
  let plays_response = Api_j.plays_response_of_string res in
  Lwt_result.return plays_response
;;

let get_shows ?limit ?offset ?next () =
  let open Lwt_result.Syntax in
  let* res =
    match next with
    | Some next -> get ~endpoint:(`Next_shows next) ()
    | None -> get ~endpoint:`Shows ?limit ?offset ()
  in
  let shows_response = Api_j.shows_response_of_string res in
  Lwt_result.return shows_response
;;

let get_programs ?limit ?offset ?next () =
  let open Lwt_result.Syntax in
  let* res =
    match next with
    | Some next -> get ~endpoint:(`Next_programs next) ()
    | None -> get ~endpoint:`Programs ?limit ?offset ()
  in
  let programs_response = Api_j.program_response_of_string res in
  Lwt_result.return programs_response
;;
