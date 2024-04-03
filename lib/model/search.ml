type t =
  { kind : string
  ; song_id : string
  ; release_group_id : string option
  ; value : string
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Caqti_request.Infix

  let search_song_artist_album ?(limit = 25) ~query_string =
    let sql =
      {|
      SELECT * FROM (
        SELECT 'song' AS kind, song_id, release_group_id, song AS value
        FROM songs
        WHERE song LIKE ? 

        UNION

        SELECT 'album' AS kind, song_id, release_group_id, album AS value
        FROM songs
        WHERE album LIKE ? 

        UNION

        SELECT 'artist' AS kind, song_id, NULL as release_group_id, artist AS value
        FROM song_artist
        WHERE artist LIKE ? 
      ) 
      ORDER BY value
      LIMIT ?
    |}
    in
    let query =
      Caqti_type.(
        tup4 string string string int ->* tup4 string string (option string) string)
        sql
    in
    let query_string = "%" ^ query_string ^ "%" in
    fun (module DB : Caqti_lwt.CONNECTION) ->
      let open Lwt_result.Syntax in
      let* results =
        DB.collect_list query (query_string, query_string, query_string, limit)
      in
      List.map
        (fun (kind, song_id, release_group_id, value) ->
          make ~kind ~song_id ?release_group_id ~value ())
        results
      |> Lwt_result.return
  ;;
end
