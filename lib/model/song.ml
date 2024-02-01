(*
   song_id	VARCHAR	NO	NULL
   song	VARCHAR	NO	NULL
   recording_id	VARCHAR	YES	NULL
   artist	VARCHAR	NO	NULL
   album	VARCHAR	YES	NULL
   release_id	VARCHAR	YES	NULL
   release_group_id	VARCHAR	YES	NULL
   release_date	DATETIME	YES	NULL
   rotation_status	VARCHAR	YES	NULL
   is_local	BOOLEAN	NO	NULL
   is_request	BOOLEAN	NO	NULL
   labels	VARCHAR	YES	NULL
   thumbnail_uri	VARCHAR	YES	NULL
*)
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
[@@deriving yojson]

module Queries = struct
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
end
