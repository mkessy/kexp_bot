(* A single function that parses an ISO8601 date-time string and formats it as an ISO8601 UTC date-time string *)
let parse_and_format_to_utcz s =
  let open Option in
  let dt =
    match Ptime.of_rfc3339 s with
    | Ok parsed_date -> Some parsed_date
    | Error _ -> None
  in
  bind dt (fun (time, _, _) -> Some (Ptime.to_rfc3339 ~tz_offset_s:0 time))
;;

module StringSet = Set.Make (String)
