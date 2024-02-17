type t =
  { song_id : string
  ; song : string
  ; recording_id : string option
  ; artist : string
  ; album : string option
  ; release_id : string option
  ; release_group_id : string option
  ; release_date : string option
  ; rotation_status : string option
  ; is_local : bool
  ; is_request : bool
  ; labels : string option
  ; thumbnail_uri : string option
  }
[@@deriving yojson, show, make]

module Queries = struct
  open Util

  let insert =
    [%rapper
      execute
        {sql|
  INSERT INTO songs (song_id, song, recording_id, artist, album, release_id, release_group_id, release_date, rotation_status, is_local, is_request, labels, thumbnail_uri)
  VALUES (%string{song_id}, %string{song}, %string?{recording_id}, %string{artist}, %string?{album}, %string?{release_id}, %string?{release_group_id}, %string?{release_date}, %string?{rotation_status}, %bool{is_local}, %bool{is_request}, %string?{labels}, %string?{thumbnail_uri}) 
  |sql}
        record_in
        syntax_off]
  ;;

  let get_by_song_id =
    [%rapper
      get_opt
        {sql|
  SELECT @string{t.song_id}, @string{t.song}, @string?{t.recording_id}, @string{t.artist}, @string?{t.album}, @string?(t.album), @string?{t.release_id}, @string?{t.release_group_id}, @string?{t.release_date}, @string?{t.rotation_status}, @bool{t.is_local}, @bool{t.is_request}, @string?{t.labels}, @string?{t.thumbnail_uri} 
  FROM songs
  WHERE song_id = %string{song_id}
  |sql}
        record_out
        syntax_off]
  ;;

  let insert_many (module DB : Caqti_lwt.CONNECTION) songs =
    let placeholders =
      List.map (fun _ -> "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)") songs
      |> String.concat ", "
    in
    let (Dynparam.Pack (typ, values)) =
      List.fold_left
        (fun pack s ->
          Dynparam.add
            Caqti_type.(
              tup2
                string
                (tup2
                   string
                   (tup2
                      (option string)
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
                                     (tup2
                                        (option string)
                                        (tup2
                                           bool
                                           (tup2
                                              bool
                                              (tup2 (option string) (option string)))))))))))))
            ( s.song_id
            , ( s.song
              , ( s.recording_id
                , ( s.artist
                  , ( s.album
                    , ( s.release_id
                      , ( s.release_group_id
                        , ( s.release_date
                          , ( s.rotation_status
                            , (s.is_local, (s.is_request, (s.labels, s.thumbnail_uri))) )
                          ) ) ) ) ) ) ) )
            pack)
        Dynparam.empty
        songs
    in
    let sql =
      Printf.sprintf
        "INSERT OR IGNORE INTO songs (song_id, song, recording_id, artist, album, \
         release_id, release_group_id, release_date, rotation_status, is_local, \
         is_request, labels, thumbnail_uri) \n\
        \         VALUES %s"
        placeholders
    in
    let open Caqti_request.Infix in
    let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
    DB.exec query values
  ;;
end
