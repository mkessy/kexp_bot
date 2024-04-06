module Song = struct
  open Model
  open Api
  open Lwt_result.Syntax

  type t = Song.t [@@deriving show]
  type song_with_art = Song.t * Api_t.release_group_response option
  type play_song = Play_song.t

  let insert_song ~(song : t) conn = Model.Song.Queries.insert song conn
  let insert_many ~(songs : t list) conn = Model.Song.Queries.insert_many conn songs

  let get_by_song_id ~song_id conn =
    let () = print_endline song_id in
    Model.Song.Queries.get_by_song_id ~song_id conn
  ;;

  let get_recently_played ~limit conn =
    Model.Play_song.Queries.get_recently_played ~limit conn
  ;;

  let get_all_by_release_group_id ~release_group_id conn =
    Model.Song.Queries.get_all_by_release_group_id ~release_group_id conn
  ;;

  let get_by_song_id_with_art ~song_id conn =
    let open Lwt_result in
    let* song = Model.Song.Queries.get_by_song_id ~song_id conn in
    match song with
    | Some s ->
      (match s.release_group_id, s.release_id with
       | Some rg_id, _ ->
         let%lwt art = Endpoints.get_cover_art_by_release_group ~release_group_id:rg_id in
         (match art with
          | Ok art -> return (Some (s, Some art))
          | Error (`Http_error (code, mes)) ->
            if code = 404
            then (
              let%lwt () =
                Lwt_io.printl
                  ("Error: cover art api returned 404 for song_id: " ^ s.song_id)
              in
              return (Some (s, None)))
            else fail (`Http_error (code, mes))
          | Error e -> fail e)
       | _, Some r_id ->
         let%lwt art = Endpoints.get_cover_art_by_release ~release_id:r_id in
         (match art with
          | Ok art -> return (Some (s, Some art))
          | Error (`Http_error (code, mes)) ->
            if code = 404
            then (
              let%lwt () =
                Lwt_io.printl
                  ("Error: cover art api returned 404 for song_id: " ^ s.song_id)
              in
              return (Some (s, None)))
            else fail (`Http_error (code, mes))
          | Error e -> fail e)
       | _ -> return (Some (s, None)))
    | None -> return None
  ;;

  let top_played_songs ~days ~limit conn =
    Model.Song.Queries.top_played_songs ~days ~limit conn
  ;;

  let find_front_image (images : Api_t.image list) =
    List.find_opt (fun (img : Api_t.image) -> img.front) images
  ;;

  let find_back_image (images : Api_t.image list) =
    List.find_opt (fun (img : Api_t.image) -> img.back) images
  ;;

  let get_thumbnail_url (image : Api_t.image) size =
    match image.thumbnails with
    | { two_fifty = Some url; _ } when size = `S250 -> Some url
    | { five_hundred = Some url; _ } when size = `S500 -> Some url
    | { twelve_hundred = Some url; _ } when size = `S1200 -> Some url
    | { small = Some url; _ } when size = `Small -> Some url
    | { large = Some url; _ } when size = `Large -> Some url
    | _ -> None
  ;;

  (* Combines the functions to find a front image and get a specific thumbnail size *)
  let get_front_thumbnail (song_with_art : song_with_art) size =
    match snd song_with_art with
    | Some art ->
      (match find_front_image art.images with
       | Some image -> get_thumbnail_url image size
       | None -> None)
    | None -> None
  ;;

  (* Similarly for back images *)
  let get_back_thumbnail (song_with_art : song_with_art) size =
    match snd song_with_art with
    | Some art ->
      (match find_back_image art.images with
       | Some image -> get_thumbnail_url image size
       | None -> None)
    | None -> None
  ;;
end
