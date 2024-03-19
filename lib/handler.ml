let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let index (_req : Dream.request) =
  let open Controller.Playlist in
  let%lwt all_playlists = Dream.sql _req Playlist.get_all in
  match all_playlists with
  | Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.html (Web.Pages.home ~playlists:[] |> html_to_string)
  | Ok all_playlists ->
    Dream.html (Web.Pages.home ~playlists:all_playlists |> html_to_string)
;;

let playlist (req : Dream.request) =
  let open Web in
  let open Controller.Playlist in
  (* convert string to id*)
  let id = Dream.param req "id" |> int_of_string in
  let%lwt playlist = Dream.sql req (Playlist.get_by_id ~id) in
  match playlist with
  | Ok pl ->
    (match pl with
     | Some pl ->
       let () = print_string (Playlist.show pl) in
       Dream.html (Pages.single_playlist pl |> html_to_string)
     | None -> Dream.empty `Not_Found)
  | Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.empty `Internal_Server_Error
;;
