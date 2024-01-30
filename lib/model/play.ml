type t =
  { id : int
  ; song_id : string
  ; airdate : string
  ; comment : string option
  ; show : int
  ; uri : string option
  ; show_uri : string option
  }
[@@deriving yojson]

module Queries = struct
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

  let get_by_unique =
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
end
