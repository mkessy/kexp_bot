module Song = struct
  open Model

  type t = Song.t

  let insert_song ~(song : t) conn = Model.Song.Queries.insert song conn
  let insert_many ~(songs : t list) conn = Model.Song.Queries.insert_many conn songs
end
