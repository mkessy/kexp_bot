(* Test Function *)

let test_parse_and_format_to_utcz () =
  let open Alcotest in
  let open Api.Util in
  let check_string = check (option string) in
  (* Test 1: Valid ISO8601 date-time *)
  let input_1 = "2024-01-30T12:00:00+01:00" in
  let expected_1 = Some "2024-01-30T11:00:00Z" in
  check_string "Valid date-time" expected_1 (parse_and_format_to_utcz input_1);
  (* Test 2: Another valid ISO8601 date-time *)
  let input_2 = "2023-12-25T00:00:00-05:00" in
  let expected_2 = Some "2023-12-25T05:00:00Z" in
  check_string "Another valid date-time" expected_2 (parse_and_format_to_utcz input_2);
  (* Test 3: Invalid date-time format *)
  let input_3 = "Not a date" in
  let expected_3 = None in
  check_string "Invalid date-time" expected_3 (parse_and_format_to_utcz input_3);
  let input_4 = "2023-12-28T17:20:01-08:00" in
  let expected_4 = Some "2023-12-29T01:20:01Z" in
  check_string "Another valid date-time" expected_4 (parse_and_format_to_utcz input_4)
;;

(* Additional tests can be added as needed *)

(* Run Tests *)
let () =
  let open Alcotest in
  run
    "parse_and_format_to_utcz"
    [ ( "parse_and_format_to_utcz"
      , [ test_case "Test parse_and_format_to_utcz" `Quick test_parse_and_format_to_utcz ]
      )
    ]
;;
