module Date = struct
  type t = string

  exception InvalidDate of string

  let parse_and_format_to_utcz (s : t) =
    let open Option in
    let dt =
      match Ptime.of_rfc3339 s with
      | Ok parsed_date -> Some parsed_date
      | Error _ -> None
    in
    bind dt (fun (time, _, _) -> Some (Ptime.to_rfc3339 ~tz_offset_s:0 time))
  ;;

  let compare (date1 : t) (date2 : t) =
    let date1_utcz = parse_and_format_to_utcz date1 in
    let date2_utcz = parse_and_format_to_utcz date2 in
    match date1_utcz, date2_utcz with
    | Some d1, Some d2 ->
      (match Ptime.of_rfc3339 d1, Ptime.of_rfc3339 d2 with
       | Ok (t1, _, _), Ok (t2, _, _) -> Ptime.compare t1 t2
       | Error _, _ -> raise (InvalidDate "Invalid format for the first date")
       | _, Error _ -> raise (InvalidDate "Invalid format for the second date"))
    | None, _ -> raise (InvalidDate "Failed to parse the first date")
    | _, None -> raise (InvalidDate "Failed to parse the second date")
  ;;

  let ( = ) (date1 : t) (date2 : t) = compare date1 date2 = 0
  let ( > ) (date1 : t) (date2 : t) = compare date1 date2 > 0
  let ( < ) (date1 : t) (date2 : t) = compare date1 date2 < 0
  let ( >= ) (date1 : t) (date2 : t) = compare date1 date2 >= 0
  let ( <= ) (date1 : t) (date2 : t) = compare date1 date2 <= 0
end

module StringSet = Set.Make (String)

let rec intersperse sep ls =
  match ls with
  | [] | [ _ ] -> ls
  | hd :: tl -> hd :: sep :: intersperse sep tl
;;
