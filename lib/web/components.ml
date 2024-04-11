open Tyxml.Html
open Uri

let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

let thumbnail_or_placeholder (uri : string option) =
  match uri with
  | Some uri -> if uri = "" then "/static/placeholder.png" else uri
  | None -> "/static/placeholder.png"
;;

let uri_of_song (s : Controller.Types.song) = "/song/" ^ pct_encode s.song_id
let uri_of_play_song (s : Controller.Types.play_song) = "/song/" ^ pct_encode s.song_id

module Playlist = struct
  type t = Controller.Types.playlist

  let song_item (song : Model.Playlist_song.Playlist_song.playlist_song) =
    let thumbnail_src = thumbnail_or_placeholder song.thumbnail_uri in
    div
      ~a:[ a_class [ "grid"; "gap-2" ] ]
      [ a
          ~a:[ a_href ("/song/" ^ song.song_id) ]
          [ div
              ~a:[ a_class [ "flex"; "items-center"; "gap-2" ] ]
              [ img
                  ~src:thumbnail_src
                  ~alt:"Album Cover"
                  ~a:
                    [ a_class [ "h-12"; "w-12" ]
                    ; a_width 50
                    ; a_height 50
                    ; a_style "aspect-ratio:50/50;object-fit:cover"
                    ]
                  ()
              ; div
                  [ h3 ~a:[ a_class [ "font-semibold"; "text-white" ] ] [ txt song.song ]
                  ; p
                      ~a:[ a_class [ "text-sm"; "text-gray-400" ] ]
                      [ txt song.artist
                      ; txt " • "
                      ; txt (Option.value song.album ~default:"")
                      ]
                  ]
              ]
          ]
      ]
  ;;

  let render (playlist : t) =
    let songs = List.map song_item playlist.songs in
    let name = playlist.name in
    let details =
      div
        ~a:[ a_class [ "col-span-1"; "bg-gray-800"; "rounded-lg"; "overflow-hidden" ] ]
        [ div
            ~a:[ a_class [ "px-4"; "py-5"; "sm:p-6" ] ]
            [ h2 ~a:[ a_class [ "font-semibold"; "mb-2"; "text-white" ] ] [ txt name ]
            ; p
                ~a:[ a_class [ "text-sm"; "text-gray-400"; "mb-2" ] ]
                [ txt "Created by: User 1" ]
            ; p
                ~a:[ a_class [ "text-sm"; "text-gray-400"; "mb-2" ] ]
                [ txt "Total songs: 20" ]
            ; p
                ~a:[ a_class [ "text-sm"; "text-gray-400"; "mb-2" ] ]
                [ txt "Duration: 1hr 30min" ]
            ]
        ]
    in
    let song_items =
      div
        ~a:
          [ a_class
              [ "border-l"
              ; "border-gray-700"
              ; "col-span-2"
              ; "bg-gray-800"
              ; "rounded-lg"
              ; "overflow-hidden"
              ; "flex-1"
              ]
          ]
        [ div
            ~a:[ a_class [ "px-4"; "py-5"; "sm:p-6" ] ]
            [ h2 ~a:[ a_class [ "font-semibold"; "mb-2"; "text-white" ] ] [ txt "Songs" ]
            ; div songs
            ]
        ]
    in
    div ~a:[ a_class [ "grid"; "grid-cols-3"; "gap-4" ] ] [ details; song_items ]
  ;;
end

let music_icon () =
  Tyxml_svg.(
    svg
      ~a:
        [ a_width (100., Some `Percent)
        ; a_height (100., Some `Percent)
        ; a_viewBox (0., 0., 24., 24.)
        ; a_fill `None
        ; a_stroke `CurrentColor
        ; a_stroke_width (2., Some `Px)
        ; a_stroke_linecap `Round
        ; a_stroke_linejoin `Round
        ]
      [ path ~a:[ a_d "M9 18V5l12-2v13" ] []
      ; circle ~a:[ a_cx (6., Some `Px); a_cy (18., Some `Px); a_r (3., Some `Px) ] []
      ; circle ~a:[ a_cx (18., Some `Px); a_cy (16., Some `Px); a_r (3., Some `Px) ] []
      ])
;;

module Breadcrumb = struct
  let render ~items =
    nav
      ~a:
        [ a_class
            [ "flex"; "items-center"; "space-x-2"; "text-sm"; "text-gray-400"; "mb-8" ]
        ]
      (List.rev items
       |> List.tl
       |> List.rev
       |> List.map (fun item -> span [ item; txt " > " ])
       |> fun items ->
       items @ [ span ~a:[ a_class [ "text-gray-200" ] ] [ List.hd (List.rev items) ] ])
  ;;
end

module Menu = struct
  let render ~home_href ~about_href ~contact_href =
    div
      ~a:
        [ a_class
            [ "flex"
            ; "items-center"
            ; "gap-2"
            ; "p-4"
            ; "max-w-3xl"
            ; "w-full"
            ; "mx-auto"
            ; "border-b"
            ; "border-gray-700"
            ]
        ]
      [ h1 ~a:[ a_class [ "text-lg"; "font-semibold" ] ] [ txt "Playlists" ]
      ; nav
          ~a:[ a_class [ "ml-auto"; "flex"; "gap-4" ] ]
          [ a
              ~a:[ a_href home_href; a_class [ "text-sm"; "hover:underline" ] ]
              [ txt "Home" ]
          ; a
              ~a:[ a_href about_href; a_class [ "text-sm"; "hover:underline" ] ]
              [ txt "About" ]
          ; a
              ~a:[ a_href contact_href; a_class [ "text-sm"; "hover:underline" ] ]
              [ txt "Contact" ]
          ]
      ]
  ;;
end

module Navigation = struct
  let render ~items =
    nav
      ~a:
        [ a_class
            [ "flex"; "items-center"; "space-x-2"; "text-sm"; "text-gray-400"; "mb-8" ]
        ]
      (List.rev items
       |> List.rev
       |> List.map (fun item -> span [ item; txt " > " ])
       |> fun items ->
       items @ [ span ~a:[ a_class [ "text-gray-200" ] ] [ List.hd (List.rev items) ] ]
       |> List.rev
       |> List.tl
       |> List.rev)
  ;;
end

module MainGrid : sig
  type t = Controller.Types.playlist

  val render : playlists:t list_wrap -> [> Html_types.div ] elt
end = struct
  type t = Controller.Types.playlist

  let playlist_item (pl : t) =
    div
      ~a:[ a_class [ "col-span-1"; "bg-gray-800"; "rounded-lg"; "overflow-hidden" ] ]
      [ div
          ~a:[ a_class [ "px-4"; "py-5"; "sm:p-6" ] ]
          [ h2 ~a:[ a_class [ "font-semibold"; "mb-2"; "text-white" ] ] [ txt pl.name ]
          ; p
              ~a:[ a_class [ "text-sm"; "text-gray-400"; "mb-2" ] ]
              [ txt ("Total songs: " ^ (pl.songs |> List.length |> string_of_int)) ]
          ; p
              ~a:[ a_class [ "text-sm"; "text-gray-400"; "mb-2" ] ]
              [ txt ("Description: " ^ Option.value pl.description ~default:"") ]
          ]
      ]
  ;;

  let render ~(playlists : t list) =
    div
      ~a:
        [ a_class [ "flex-1"; "overflow-auto"; "p-4"; "max-w-3xl"; "w-full"; "mx-auto" ] ]
      [ div
          ~a:[ a_class [ "grid"; "grid-cols-3"; "gap-4" ] ]
          (List.map playlist_item playlists)
      ]
  ;;
end

module Song : sig
  type t = Controller.Types.song_with_cover_art
  type song = Controller.Types.song

  val render : song_with_art:t -> [> Html_types.div ] elt
end = struct
  type t = Controller.Types.song_with_cover_art
  type song = Controller.Types.song

  let placeholder_img = "/static/placeholder.png"

  let render_image ~src ~alt =
    let open Tyxml.Html in
    img
      ~src
      ~alt
      ~a:
        [ a_class [ "max-w-xs"; "w-full"; "rounded-lg"; "shadow-lg" ]
        ; a_width 500
        ; a_height 500
        ; a_style "aspect-ratio:1/1;object-fit:cover"
        ]
      ()
  ;;

  let render_artwork (song_with_art : t) =
    let open Controller.Song.Song in
    let song = fst song_with_art in
    let image =
      match
        ( get_front_thumbnail song_with_art `Large
        , get_back_thumbnail song_with_art `Large
        , song.thumbnail_uri )
      with
      | Some front, _, _ -> front
      | None, Some back, _ -> back
      | None, None, Some uri -> if uri = "" then placeholder_img else uri
      | None, None, None -> placeholder_img
    in
    let () = print_endline image in
    render_image ~src:image ~alt:"Album Cover"
  ;;

  let render_song_details (song : song) =
    let open Tyxml.Html in
    let year = Option.value ~default:"" song.release_date in
    let intersperse sep = function
      | [] -> []
      | hd :: tl -> hd :: List.fold_right (fun x acc -> sep :: x :: acc) tl []
    in
    let album_info =
      List.filter_map
        (fun x ->
          match x with
          | "" -> None
          | _ -> Some (txt x))
        [ Option.value ~default:"" song.album; song.artist; year ]
      |> intersperse (txt " • ")
    in
    [ h1
        ~a:[ a_class [ "text-4xl"; "font-bold"; "mb-2"; "text-gray-100" ] ]
        [ txt song.song ]
    ; div
        ~a:
          [ a_class
              [ "flex"
              ; "justify-left"
              ; "items-center"
              ; "mb-4"
              ; "text-sm"
              ; "text-gray-500"
              ; "tracking-tighter"
              ; "leading-none"
              ]
          ]
        album_info
    ]
  ;;

  let render_stats =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "grid"; "grid-cols-2"; "gap-4"; "text-lg" ] ]
      [ div ~a:[ a_class [ "text-gray-400" ] ] [ txt "Plays" ]
      ; div ~a:[ a_class [ "text-right"; "font-bold"; "text-teal-400" ] ] [ txt "1,234" ]
      ; div ~a:[ a_class [ "text-gray-400" ] ] [ txt "Favorite" ]
      ; div ~a:[ a_class [ "text-right"; "font-bold"; "text-teal-400" ] ] [ txt "95%" ]
      ]
  ;;

  let render_last_played =
    let open Tyxml.Html in
    p
      ~a:[ a_class [ "text-sm"; "text-gray-500" ] ]
      [ txt "Last played on KEXP: 2023-04-15" ]
  ;;

  let render ~(song_with_art : t) =
    let open Tyxml.Html in
    let artwork = render_artwork song_with_art in
    let details = render_song_details (fst song_with_art) in
    div
      ~a:
        [ a_class
            [ "bg-gray-900"; "shadow-xl"; "rounded-xl"; "p-8"; "max-w-4xl"; "mx-auto" ]
        ]
      [ div
          ~a:[ a_class [ "flex"; "gap-8"; "items-start" ] ]
          [ artwork
          ; div
              ~a:[ a_class [ "flex-1"; "space-y-2" ] ]
              (details @ [ render_stats; render_last_played ])
          ]
      ]
  ;;
end

module Search = struct
  let render =
    div
      ~a:[]
      [ label ~a:[ a_label_for "search"; a_class [ "sr-only" ] ] [ txt "Search" ]
      ; div
          ~a:[ a_class [ "relative" ] ]
          [ input
              ~a:
                [ a_input_type `Text
                ; a_id "search"
                ; a_name "search"
                ; a_placeholder "Search..."
                ; a_class
                    [ "block"
                    ; "w-full"
                    ; "pl-4"
                    ; "pr-10"
                    ; "py-2"
                    ; "text-base"
                    ; "text-gray-900"
                    ; "placeholder-gray-500"
                    ; "border"
                    ; "border-gray-300"
                    ; "rounded-md"
                    ; "focus:outline-none"
                    ; "focus:ring-indigo-500"
                    ; "focus:border-indigo-500"
                    ; "focus:placeholder-gray-400"
                    ; "sm:text-sm"
                    ]
                ; Unsafe.string_attrib "hx-post" "/api/search"
                ; Unsafe.string_attrib "hx-target" "#search-results"
                ; Unsafe.string_attrib "hx-trigger" "searchEvent"
                ; Unsafe.string_attrib
                    "_"
                    "on keyup debounced at 500ms if me.value.trim().length > 2 then \
                     trigger searchEvent on me"
                ]
              ()
          ; div ~a:[ a_id "search-results"; a_class [ "mt-4"; "space-y-2" ] ] []
          ]
      ]
  ;;
end

module SearchResults = struct
  open Uri

  type t = Controller.Types.search_result

  let render (results : t list) =
    let render_result (result : t) =
      let icon =
        match result.kind with
        | "artist" -> txt "🎤"
        | "album" -> txt "💿"
        | "song" -> txt "🎵"
        | _ -> txt "🔍"
      in
      li
        ~a:[ a_class [ "flex"; "items-center"; "space-x-2" ] ]
        [ span ~a:[ a_class [ "text-xl" ] ] [ icon ]
        ; a
            ~a:
              [ a_href ("/song/" ^ pct_encode result.song_id)
              ; a_class [ "text-blue-500"; "hover:underline" ]
              ]
            [ txt result.value ]
        ]
    in
    ul ~a:[ a_class [ "space-y-2" ] ] (List.map render_result results)
  ;;
end

module LivePlayBar = struct
  let now_playing_item (song : Controller.Types.play_song) =
    let thumbnail = thumbnail_or_placeholder song.thumbnail_uri in
    div
      ~a:[ a_class [ "flex"; "items-center"; "space-x-4"; "text-white" ] ]
      [ img
          ~src:thumbnail
          ~alt:"Album Cover"
          ~a:[ a_class [ "h-12"; "w-12"; "rounded" ]; a_style "object-fit: cover;" ]
          ()
      ; div
          [ p
              ~a:[ a_class [ "text-sm"; "font-semibold" ] ]
              [ a ~a:[ a_href (uri_of_play_song song) ] [ txt song.song ] ]
          ; p ~a:[ a_class [ "text-xs"; "text-gray-400" ] ] [ txt song.artist ]
          ]
      ]
  ;;

  let history_item (song : Controller.Types.play_song) =
    let thumbnail = thumbnail_or_placeholder song.thumbnail_uri in
    div
      ~a:[ a_class [ "flex"; "items-center"; "space-x-4"; "text-white" ] ]
      [ img
          ~src:thumbnail
          ~alt:"Album Cover"
          ~a:[ a_class [ "h-10"; "w-10"; "rounded" ]; a_style "object-fit: cover;" ]
          ()
      ; div
          [ p
              ~a:[ a_class [ "text-xs"; "font-semibold" ] ]
              [ a ~a:[ a_href (uri_of_play_song song) ] [ txt song.song ] ]
          ; p ~a:[ a_class [ "text-xs"; "text-gray-400" ] ] [ txt song.artist ]
          ]
      ]
  ;;

  let render
    ~(now_playing : Controller.Types.play_song)
    ~(history : Controller.Types.play_song list)
    =
    let open Tyxml.Html in
    let playing_content = now_playing_item now_playing in
    div
      ~a:
        [ a_class
            [ "bg-gray-800"
            ; "border-b"
            ; "border-gray-700"
            ; "px-4"
            ; "py-2"
            ; "flex"
            ; "justify-center"
            ; "space-x-4"
            ; "overflow-x-auto"
            ]
        ]
      [ div ~a:[ a_class [ "flex-none" ] ] [ playing_content ]
      ; div ~a:[ a_class [ "flex"; "space-x-4" ] ] (List.map history_item history)
      ]
  ;;
end
