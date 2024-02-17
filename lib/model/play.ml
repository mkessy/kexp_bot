type t =
  { id : int
  ; song_id : string
  ; airdate : string
  ; comment : string option
  ; show : int
  ; uri : string option
  ; show_uri : string option
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Util

  let insert =
    [%rapper
      execute
        {sql|
  INSERT INTO plays (song_id, airdate, comment, show, uri, show_uri)
  VALUES (%string{song_id}, %string{airdate}, %string?{comment}, %int{show}, %string?{uri}, %string?{show_uri})
  |sql}
        syntax_off]
  ;;

  let get_by_id =
    [%rapper
      get_opt
        {sql|
  SELECT @int{t.id}, @string{t.song_id}, @string{t.airdate}, @string?{t.comment}, @int{t.show}, @string?{t.uri}, @string?{t.show_uri}
  FROM plays
  WHERE t.id = %int{id}
  |sql}
        syntax_off
        record_out]
  ;;

  let get_by_song_id =
    [%rapper
      get_opt
        {sql|
  SELECT @int{t.id}, @string{t.song_id}, @string{t.airdate}, @string?{t.comment}, @int{t.show}, @string?{t.uri}, @string?{t.show_uri}
  FROM plays
  WHERE t.song_id = %string{song_id}
  |sql}
        syntax_off
        record_out]
  ;;

  let get_by_airdate_range =
    [%rapper
      get_many
        {sql|
  SELECT @int{t.id}, @string{t.song_id}, @string{t.airdate}, @string?{t.comment}, @int{t.show}, @string?{t.uri}, @string?{t.show_uri}
  FROM plays
  WHERE t.airdate >= %string{start_date}
  AND t.airdate <= %string{end_date}
  |sql}
        syntax_off
        record_out]
  ;;

  let insert_many (module DB : Caqti_lwt.CONNECTION) plays =
    let placeholders =
      List.map (fun _ -> "(?, ?, ?, ?, ?, ?)") plays |> String.concat ", "
    in
    let (Dynparam.Pack (typ, values)) =
      List.fold_left
        (fun pack p ->
          Dynparam.add
            Caqti_type.(
              tup2
                string
                (tup2
                   string
                   (tup2
                      (option string)
                      (tup2 int (tup2 (option string) (option string))))))
            (p.song_id, (p.airdate, (p.comment, (p.show, (p.uri, p.show_uri)))))
            pack)
        Dynparam.empty
        plays
    in
    let sql =
      Printf.sprintf
        "INSERT OR IGNORE INTO plays (song_id, airdate, comment, show, uri, show_uri) \
         VALUES %s"
        placeholders
    in
    let open Caqti_request.Infix in
    let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
    DB.exec query values
  ;;
end
