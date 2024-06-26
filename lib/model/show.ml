type t =
  { id : int
  ; program : int
  ; program_uri : string
  ; program_name : string
  ; program_tags : string
  ; tagline : string
  ; start_time : string
  ; uri : string option
  ; image_uri : string option
  ; show_uri : string option
  ; hosts : string option
  ; host_names : string option
  ; host_uris : string option
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Util

  let get_latest =
    [%rapper
      get_opt
        {sql|
          SELECT @int{id}
          FROM shows
          ORDER BY id DESC
          LIMIT 1
        |sql}
        syntax_off]
  ;;

  let insert =
    [%rapper
      execute
        {sql|
          INSERT INTO shows
            (program, program_uri, program_name, program_tags, tagline, start_time, uri, image_uri, show_uri, hosts, host_names, host_uris)
          VALUES
            (%int{program}, %string{program_uri}, %string{program_name}, %string{program_tags}, %string{tagline}, %string{start_time}, %string?{uri}, %string?{image_uri}, %string?{show_uri}, %string?{hosts}, %string?{host_names}, %string?{host_uris})
        |sql}
        syntax_off]
  ;;

  let get_by_id =
    [%rapper
      get_opt
        {sql|
          SELECT @int{id}
               , @int{program}
               , @string{program_uri}
               , @string{program_name}
               , @string{program_tags}
               , @string{tagline}
               , @string{start_time}
               , @string?{uri}
               , @string?{image_uri}
               , @string?{show_uri}
               , @string?{hosts}
               , @string?{host_names}
               , @string?{host_uris}
          FROM shows WHERE id = %int{id}
        |sql}
        syntax_off
        record_out]
  ;;

  let get_all =
    [%rapper
      get_many
        {sql|
          SELECT @int{id}
               , @int{program}
               , @string{program_uri}
               , @string{program_name}
               , @string{program_tags}
               , @string{tagline}
               , @string{start_time}
               , @string?{uri}
               , @string?{image_uri}
               , @string?{show_uri}
               , @string?{hosts}
               , @string?{host_names}
               , @string?{host_uris}
          FROM shows
        |sql}
        syntax_off
        record_out]
  ;;

  let insert_many (module DB : Caqti_lwt.CONNECTION) shows =
    let placeholders =
      List.map (fun _ -> "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)") shows
      |> String.concat ", "
    in
    let (Dynparam.Pack (typ, values)) =
      List.fold_left
        (fun pack p ->
          Dynparam.add
            Caqti_type.(
              tup2
                int
                (tup2
                   int
                   (tup2
                      string
                      (tup2
                         string
                         (tup2
                            string
                            (tup2
                               string
                               (tup2
                                  string
                                  (tup2
                                     (option string)
                                     (tup2
                                        (option string)
                                        (tup2
                                           (option string)
                                           (tup2
                                              (option string)
                                              (tup2 (option string) (option string)))))))))))))
            ( p.id
            , ( p.program
              , ( p.program_uri
                , ( p.program_name
                  , ( p.program_tags
                    , ( p.tagline
                      , ( p.start_time
                        , ( p.uri
                          , ( p.image_uri
                            , (p.show_uri, (p.hosts, (p.host_names, p.host_uris))) ) ) )
                      ) ) ) ) ) )
            pack)
        Dynparam.empty
        shows
    in
    let sql =
      Printf.sprintf
        "INSERT OR IGNORE INTO shows (id, program, program_uri, program_name, \
         program_tags, tagline, start_time, uri, image_uri, show_uri, hosts, host_names, \
         host_uris) VALUES %s"
        placeholders
    in
    let open Caqti_request.Infix in
    let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
    DB.exec query values
  ;;
end
