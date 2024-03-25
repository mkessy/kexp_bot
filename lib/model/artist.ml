type t = string

module Queries = struct
  open Caqti_request.Infix

  let insert =
    [%rapper
      execute
        {sql|
          INSERT OR INGORE INTO artists (id)
          VALUES (%string{id})
          |sql}
        syntax_off]
  ;;

  let insert_many =
    [%rapper
      execute
        {sql|
          INSERT OR IGNORE INTO artists (id)
          VALUES %list{( %string{ids} )}
          |sql}
        syntax_off]
  ;;

  let top_played_artists ~days ~limit =
    let sql =
      {|
        SELECT s.artist, COUNT(*) AS play_count
        FROM plays p
        JOIN songs s ON p.song_id = s.song_id
        WHERE p.airdate >= datetime('now', ?)
        GROUP BY s.artist
        ORDER BY play_count DESC
        LIMIT ?
      |}
    in
    let query = Caqti_type.(tup2 string int ->* tup2 string int32) sql in
    let days_expr = Util.sql_days_of_int days in
    fun (module DB : Caqti_lwt.CONNECTION) -> DB.collect_list query (days_expr, limit)
  ;;
end
