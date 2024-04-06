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
  ; airdate : string
  ; comment : string option
  ; show : int
  ; uri : string option
  ; show_uri : string option
  }
[@@deriving yojson, show, make]

module Queries = struct
  let get_recently_played =
    [%rapper
      get_many
        {sql|
            SELECT s.song_id as @string{song_id}, 
                   s.song as @string{song}, 
                   s.recording_id as @string?{recording_id}, 
                   s.artist as @string{artist}, 
                   s.album as @string?{album}, 
                   s.release_id as @string?{release_id}, 
                   s.release_group_id as @string?{release_group_id}, 
                   s.release_date as @string?{release_date}, 
                   s.rotation_status as @string?{rotation_status}, 
                   s.is_local as @bool{is_local}, 
                   s.is_request as @bool{is_request}, 
                   s.labels as @string?{labels}, 
                   s.thumbnail_uri as @string?{thumbnail_uri},
                   p.airdate as @string{airdate},
                   p.comment as @string?{comment},
                   p.show as @int{show},
                   p.uri as @string?{uri},
                   p.show_uri as @string?{show_uri}
            FROM songs s
            JOIN plays p ON s.song_id = p.song_id
            ORDER BY p.airdate DESC
            LIMIT %int{limit}
        |sql}
        record_out
        syntax_off]
  ;;
end
