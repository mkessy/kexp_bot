(*
   example row of playlist
   playlist_id	song_unique	ord	song_id	song	recording_id	artist	album	release_id	release_group_id	release_date	rotation_status	is_local	is_request	labels	thumbnail_uri
   192	u.s. girls-rage of plastics	1	u.s. girls-rage of plastics	Rage of Plastics	450312ba-59e6-4218-826a-388ee6b8de42	U.S. Girls	In a Poem Unlimited	c4f39274-020a-4e6c-adec-627772ee44f0	5c61b138-6ffa-4f14-a156-25e6d6e70120	2018-02-16	Library	0	0		https://ia601004.us.archive.org/25/items/mbid-c4f39274-020a-4e6c-adec-627772ee44f0/mbid-c4f39274-020a-4e6c-adec-627772ee44f0-19170079880_thumb250.jpg
*)

module Playlist_song = struct
  type t =
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
        SELECT  
        ps.ord as @int{ord},
        ps.song_id as @string{song_id},
        @string{song},
        @string?{recording_id},
        @string{artist},
        @string?{album},
        @string?{release_id},
        @string?{release_group_id},
        @string?{release_date},
        @string?{rotation_status},
        @bool{is_local},
        @bool{is_request},
        @string?{labels},
        @string?{thumbnail_uri}
        FROM playlist_song ps
        JOIN songs s ON ps.song_id = s.song_id
        WHERE ps.playlist_id = %int{id}
      |sql}
          record_out]
    ;;
  end
end
