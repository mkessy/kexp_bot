module Search = struct
  open Model

  type t = Search.t [@@deriving yojson]

  let search ~limit ~(query_string : string) conn =
    Search.Queries.search_song_artist_album ~limit ~query_string conn
  ;;
end
