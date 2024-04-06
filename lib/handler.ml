let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html
let elem_to_string el = Format.asprintf "%a" (Tyxml.Html.pp_elt ()) el

let index (_req : Dream.request) =
  let open Controller.Playlist in
  let open Controller.Song in
  let all_playlists = Dream.sql _req Playlist.get_all in
  let history = Dream.sql _req (Song.get_recently_played ~limit:5) in
  let%lwt all_playlists, history = Lwt.both all_playlists history in
  match all_playlists, history with
  | Error a, Error b ->
    let a = Caqti_error.show a in
    let b = Caqti_error.show b in
    let () = Dream.log "Error: %s" a in
    let () = Dream.log "Error: %s" b in
    Dream.html (Web.Pages.home ~history:[] ~home_playlists:[] |> html_to_string)
  | Ok all_playlists, Ok history ->
    Dream.html (Web.Pages.home ~history ~home_playlists:all_playlists |> html_to_string)
  | Ok all_playlists, Error e ->
    let e = Caqti_error.show e in
    let () = Dream.log "Error: %s" e in
    Dream.html (Web.Pages.home ~history:[] ~home_playlists:all_playlists |> html_to_string)
  | Error e, Ok history ->
    let e = Caqti_error.show e in
    let () = Dream.log "Error: %s" e in
    Dream.html (Web.Pages.home ~history ~home_playlists:[] |> html_to_string)
;;

let playlist (req : Dream.request) =
  let open Web in
  let open Controller.Playlist in
  let open Controller.Song in
  let id = Dream.param req "id" |> int_of_string in
  let playlist = Dream.sql req (Playlist.get_by_id ~id) in
  let history = Dream.sql req (Song.get_recently_played ~limit:5) in
  let%lwt playlist, history = Lwt.both playlist history in
  match playlist, history with
  | Ok (Some pl), Ok history ->
    let () = print_string (Playlist.show pl) in
    Dream.html (Pages.single_playlist ~history ~playlist:pl |> html_to_string)
  | Ok None, _ -> Dream.empty `Not_Found
  | Error e, _ ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.empty `Internal_Server_Error
  | Ok (Some pl), Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.html (Pages.single_playlist ~history:[] ~playlist:pl |> html_to_string)
;;

let song (req : Dream.request) =
  let open Web in
  let open Controller.Song in
  let song_id = Dream.param req "song_id" in
  let () = Dream.log "Song id: %s" song_id in
  let song_with_art = Dream.sql req (Song.get_by_song_id_with_art ~song_id) in
  let history = Dream.sql req (Song.get_recently_played ~limit:5) in
  let%lwt song_with_art, history = Lwt.both song_with_art history in
  match song_with_art, history with
  | Ok (Some song), Ok history ->
    Dream.html (Pages.single_song ~history ~song_with_art:song |> html_to_string)
  | Ok None, _ -> Dream.empty `Not_Found
  | Error e, _ ->
    (match e with
     | `Curl_error (code, err_string) ->
       let () = Dream.log "Curl error: %d %s" code err_string in
       Dream.empty `Internal_Server_Error
     | `Http_error (code, err_string) ->
       let () = Dream.log "Http error: %d %s" code err_string in
       Dream.empty `Internal_Server_Error
     | _ -> Dream.empty `Internal_Server_Error)
  | Ok (Some song), Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.html (Pages.single_song ~history:[] ~song_with_art:song |> html_to_string)
;;

let search (_req : Dream.request) =
  let open Web in
  let open Controller.Song in
  let%lwt history = Dream.sql _req (Song.get_recently_played ~limit:5) in
  match history with
  | Ok history -> Dream.html (Pages.search ~history |> html_to_string)
  | Error e ->
    let err_str = Caqti_error.show e in
    let () = Dream.log "Error: %s" err_str in
    Dream.html (Pages.search ~history:[] |> html_to_string)
;;

let api_search (req : Dream.request) =
  let open Web in
  let open Controller.Search in
  let%lwt form = Dream.form ~csrf:false req in
  match form with
  | `Ok [ ("search", "") ] -> Dream.empty `No_Content
  | `Ok [ ("search", query_string) ] ->
    let%lwt results = Dream.sql req (Search.search ~limit:25 ~query_string) in
    (match results with
     | Ok results -> Dream.html (Components.SearchResults.render results |> elem_to_string)
     | _ -> Dream.empty `Internal_Server_Error)
  | _ -> Dream.empty `Bad_Request
;;
