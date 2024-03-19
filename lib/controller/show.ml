module Show = struct
  open Model

  type t = Show.t

  let insert_show ~(show : t) conn =
    Model.Show.Queries.insert
      ~program:show.program
      ~program_uri:show.program_uri
      ~program_name:show.program_name
      ~program_tags:show.program_tags
      ~tagline:show.tagline
      ~start_time:show.start_time
      ~uri:show.uri
      ~image_uri:show.image_uri
      ~show_uri:show.show_uri
      ~hosts:show.hosts
      ~host_names:show.host_names
      ~host_uris:show.host_uris
      conn
  ;;

  let insert_many ~(shows : t list) conn = Model.Show.Queries.insert_many conn shows
  let get_all conn = Model.Show.Queries.get_all conn
  let get_latest conn = Model.Show.Queries.get_latest conn
end
