type t =
  { song_id : string
  ; artist_id : string
  }
[@@deriving yojson, show]

module Queries = struct
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
end
