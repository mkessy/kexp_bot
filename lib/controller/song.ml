module Song = struct
  open Model

  type t = Song.t [@@deriving yojson]

  let insert_play (play : t) conn = Model.Song.Queries.insert play conn
end
