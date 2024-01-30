module Playlist = struct
  open Model.Playlist
  open Model.Playlist_song

  type t =
    { id : int
    ; name : string
    ; description : string option
    ; songs : Playlist_song.t list
    ; created_at : string
    ; updated_at : string
    }
  [@@deriving yojson, show]

  let make ~id ~name ~description ~songs ~created_at ~updated_at () : t =
    { id; name; description; songs; created_at; updated_at }
  ;;

  let of_model ~(songs : Playlist_song.t list) ~(playlist : Playlist.t) : t =
    make
      ~id:playlist.id
      ~name:playlist.name
      ~songs
      ~description:playlist.description
      ~created_at:playlist.created_at
      ~updated_at:playlist.updated_at
      ()
  ;;

  let get_by_id ~id conn =
    let open Lwt_result.Syntax in
    let* playlist = Playlist.Queries.get_by_id ~id conn in
    match playlist with
    | Some playlist ->
      let* songs = Playlist_song.Queries.get_all_by_playlist_id ~id conn in
      Lwt.return_ok (Some (of_model ~songs ~playlist))
    | None -> Lwt.return_ok None
  ;;

  let get_all conn =
    let open Lwt.Syntax in
    Lwt_result.( >>= ) (Playlist.Queries.get_all () conn) (fun playlists ->
      let* result =
        Lwt_list.fold_left_s
          (fun acc (playlist : Model.Playlist.Playlist.t) ->
            let* songs =
              Playlist_song.Queries.get_all_by_playlist_id ~id:playlist.id conn
            in
            match songs with
            | Ok songs -> Lwt.return (of_model ~songs ~playlist :: acc)
            | Error _ -> Lwt.return acc)
          []
          playlists
      in
      Lwt.return_ok result)
  ;;

  let length t = List.length t.songs

  let get_song_by_index t index =
    match List.nth_opt t.songs index with
    | Some song -> Some song
    | None -> None
  ;;
end
