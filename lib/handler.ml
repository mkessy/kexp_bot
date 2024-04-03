let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html
let elem_to_string el = Format.asprintf "%a" (Tyxml.Html.pp_elt ()) el

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
  | Ok (Some pl) ->
    let () = print_string (Playlist.show pl) in
    Dream.html (Pages.single_playlist ~playlist:pl |> html_to_string)
  | Ok None -> Dream.empty `Not_Found
  | Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.empty `Internal_Server_Error
;;

let song (req : Dream.request) =
  let open Web in
  let open Controller.Song in
  let song_id = Dream.param req "song_id" in
  let () = Dream.log "Song id: %s" song_id in
  let%lwt song_with_art = Dream.sql req (Song.get_by_song_id_with_art ~song_id) in
  match song_with_art with
  | Ok (Some song) -> Dream.html (Pages.single_song ~song_with_art:song |> html_to_string)
  | Ok None -> Dream.empty `Not_Found
  | Error e ->
    (match e with
     | `Curl_error (code, err_string) ->
       let () = Dream.log "Curl error: %d %s" code err_string in
       Dream.empty `Internal_Server_Error
     | `Http_error (code, err_string) ->
       let () = Dream.log "Http error: %d %s" code err_string in
       Dream.empty `Internal_Server_Error
     | _ -> Dream.empty `Internal_Server_Error)
;;

let search (_req : Dream.request) =
  let open Web in
  Dream.html (Pages.search |> html_to_string)
;;

let api_search (req : Dream.request) =
  let open Web in
  let open Controller.Search in
  let%lwt form = Dream.form ~csrf:false req in
  match form with
  | `Ok [ ("search", query_string) ] ->
    let%lwt results = Dream.sql req (Search.search ~limit:25 ~query_string) in
    (match results with
     | Ok results -> Dream.html (Components.SearchResults.render results |> elem_to_string)
     | _ -> Dream.empty `Internal_Server_Error)
  | _ -> Dream.empty `Bad_Request
;;
