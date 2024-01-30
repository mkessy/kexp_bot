open Ptime

(*
   songs_df['airdate'] = songs_df['airdate'].dt.strftime("%Y-%m-%dT%H:%M:%SZ")
*)

open Ptime

(* A single function that parses an ISO8601 date-time string and formats it as an ISO8601 UTC date-time string *)
let parse_and_format_iso8601_to_utc s =
  let open Option in
  let dt =
    match Ptime.of_rfc3339 s with
    | Ok parsed_date -> Some parsed_date
    | Error _ -> None
  in
  bind dt (fun (ptime, _, _) -> Ptime.to_rfc3339 ~tz_offset_s:0 ptime |> return)
;;

(* Example usage *)
let airdate = "2023-12-28T16:29:38-08:00"
let converted_airdate = parse_and_format_iso8601_to_utc airdate
