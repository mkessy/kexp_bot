type t =
  { artist : string option
  ; album : string option
  ; song_id : string
  ; artist_id : string
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Util

  let insert =
    [%rapper
      execute
        {sql|
          INSERT INTO song_artist (song_id, artist_id, artist, album)
          VALUES (%string{song_id}, %string{artist_id}, %string?{artist}, %string?{album})
        |sql}
        syntax_off]
  ;;

  let get_all_by_song_id =
    [%rapper
      get_many
        {sql|
          SELECT @string{song_id}, @string{artist_id}, @string?{artist}, @string?{album} FROM song_artist
          WHERE song_id = %string{song_id}           
        |sql}
        syntax_off
        record_out]
  ;;

  let insert_many (module DB : Caqti_lwt.CONNECTION) song_artists =
    let placeholders =
      List.map (fun _ -> "(?, ?, ?, ?)") song_artists |> String.concat ", "
    in
    let (Dynparam.Pack (typ, values)) =
      List.fold_left
        (fun pack sa ->
          Dynparam.add
            Caqti_type.(tup4 string string (option string) (option string))
            (sa.song_id, sa.artist_id, sa.artist, sa.album)
            pack)
        Dynparam.empty
        song_artists
    in
    let sql =
      Printf.sprintf
        "INSERT OR IGNORE INTO song_artist (song_id, artist_id, artist, album) VALUES %s"
        placeholders
    in
    let open Caqti_request.Infix in
    let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
    DB.exec query values
  ;;
end
