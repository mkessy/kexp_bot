type t =
  { song_id : string
  ; artist_id : string
  }
[@@deriving yojson, show]

module Queries = struct
  open Util

  let insert =
    [%rapper
      execute
        {sql|
          INSERT INTO song_artist (song_id, artist_id)
          VALUES (%string{song_id}, %string{artist_id})
        |sql}
        syntax_off]
  ;;

  let get_all_by_song_id =
    [%rapper
      get_many
        {sql|
          SELECT @string{song_id}, @string{artist_id} FROM song_artist
          WHERE song_id = %string{song_id}           
        |sql}
        syntax_off
        record_out]
  ;;

  let insert_many (module DB : Caqti_lwt.CONNECTION) song_artists =
    let placeholders = List.map (fun _ -> "(?, ?)") song_artists |> String.concat ", " in
    let (Dynparam.Pack (typ, values)) =
      List.fold_left
        (fun pack sa ->
          Dynparam.add Caqti_type.(tup2 string string) (sa.song_id, sa.artist_id) pack)
        Dynparam.empty
        song_artists
    in
    let sql =
      Printf.sprintf
        "INSERT OR IGNORE INTO song_artist (song_id, artist_id) VALUES %s"
        placeholders
    in
    let open Caqti_request.Infix in
    let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
    DB.exec query values
  ;;
end
