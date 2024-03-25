module Song = struct
  open Model

  type t = Song.t [@@deriving show]

  let insert_song ~(song : t) conn = Model.Song.Queries.insert song conn
  let insert_many ~(songs : t list) conn = Model.Song.Queries.insert_many conn songs

  let top_played_songs ~days ~limit conn =
    Model.Song.Queries.top_played_songs ~days ~limit conn
  ;;
end
