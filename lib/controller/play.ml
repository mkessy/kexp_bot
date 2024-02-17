module Play = struct
  open Model

  type t = Play.t [@@deriving yojson]

  let insert_play ~(play : t) conn =
    Model.Play.Queries.insert
      ~song_id:play.song_id
      ~airdate:play.airdate
      ~comment:play.comment
      ~show:play.show
      ~uri:play.uri
      ~show_uri:play.show_uri
      conn
  ;;

  let insert_many ~(plays : t list) conn = Model.Play.Queries.insert_many conn plays
end
