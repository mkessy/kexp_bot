(*
   example row of playlist
   playlist_id	song_unique	ord	song_id	song	recording_id	artist	album	release_id	release_group_id	release_date	rotation_status	is_local	is_request	labels	thumbnail_uri
   192	u.s. girls-rage of plastics	1	u.s. girls-rage of plastics	Rage of Plastics	450312ba-59e6-4218-826a-388ee6b8de42	U.S. Girls	In a Poem Unlimited	c4f39274-020a-4e6c-adec-627772ee44f0	5c61b138-6ffa-4f14-a156-25e6d6e70120	2018-02-16	Library	0	0		https://ia601004.us.archive.org/25/items/mbid-c4f39274-020a-4e6c-adec-627772ee44f0/mbid-c4f39274-020a-4e6c-adec-627772ee44f0-19170079880_thumb250.jpg
*)

module Playlist_song = struct
  open Util

  type t =
    { playlist_id : int
    ; song_id : string
    ; ord : int
    }
  [@@deriving yojson, show]

  type playlist_song =
    { ord : int
    ; song_id : string
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
  [@@deriving yojson, show]

  module Queries = struct
    let get_all_by_playlist_id =
      [%rapper
        get_many
          {sql|
        SELECT @int{ps.playlist_id}, @string{ps.song_id}, @int{ps.ord} FROM playlist_song as ps
        WHERE ps.playlist_id = %int{id}
      |sql}
          record_out]
    ;;

    let get_all_playlist_song_by_playlist_id =
      [%rapper
        get_many
          {sql|
        SELECT
          ps.ord as @int{ord},
          ps.song_id as @string{song_id},
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
          s.thumbnail_uri as @string?{thumbnail_uri}
        FROM playlist_song as ps
        JOIN songs as s ON ps.song_id = s.song_id
        WHERE ps.playlist_id = %int{id}
        ORDER BY ps.ord
      |sql}
          record_out]
    ;;

    let insert =
      [%rapper
        execute
          {sql|
      INSERT INTO playlist_song (playlist_id, song_id, ord)
      VALUES (%int{playlist_id}, %string{song_id}, %int{ord})
    |sql}
          syntax_off]
    ;;

    let insert_many ~records =
      let placeholders = List.map (fun _ -> "(?, ?, ?)") records |> String.concat ", " in
      let (Dynparam.Pack (typ, values)) =
        List.fold_left
          (fun pack s ->
            Dynparam.add
              Caqti_type.(tup3 int string int)
              (s.playlist_id, s.song_id, s.ord)
              pack)
          Dynparam.empty
          records
      in
      let sql =
        Printf.sprintf
          "INSERT OR IGNORE INTO playlist_song (playlist_id, song_id, ord) VALUES %s"
          placeholders
      in
      let open Caqti_request.Infix in
      let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
      fun (module DB : Caqti_lwt.CONNECTION) -> DB.exec query values
    ;;
  end
end
