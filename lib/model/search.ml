type t =
  { kind : string
  ; song_id : string
  ; value : string
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Caqti_request.Infix

  let search_song_artist_album ?(limit = 25) ~query_string =
    let sql =
      {|
      SELECT * FROM (
        SELECT 'song' AS kind, song_id, song AS value
        FROM songs
        WHERE song LIKE ? 

        UNION

        SELECT 'album' AS kind, song_id, album AS value
        FROM songs
        WHERE album LIKE ? 

        UNION

        SELECT 'artist' AS kind, song_id, artist AS value
        FROM song_artist
        WHERE artist LIKE ? 
      ) 
      ORDER BY value
      LIMIT ?
    |}
    in
    let query =
      Caqti_type.(tup4 string string string int ->* tup3 string string string) sql
    in
    let query_string = "%" ^ query_string ^ "%" in
    fun (module DB : Caqti_lwt.CONNECTION) ->
      DB.collect_list query (query_string, query_string, query_string, limit)
  ;;
end
