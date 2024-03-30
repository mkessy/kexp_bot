open Tyxml.Html

let html_to_string html = Format.asprintf "%a" (Tyxml.Html.pp ()) html

module Playlist = struct
  type t = Controller.Types.playlist

  let song_item (song : Model.Playlist_song.Playlist_song.playlist_song) =
    div
      ~a:[ a_class [ "grid"; "gap-2" ] ]
      [ div
          ~a:[ a_class [ "flex"; "items-center"; "gap-2" ] ]
          [ img
              ~src:(Option.value song.thumbnail_uri ~default:"./placeholder.png")
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

  let placeholder_img = "./placeholder.png"

  let render_image ~src ~alt =
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
    let image =
      match
        get_front_thumbnail song_with_art `Large, get_back_thumbnail song_with_art `Large
      with
      | Some front, _ -> front
      | None, Some back -> back
      | None, None -> placeholder_img
    in
    render_image ~src:image ~alt:"Album Cover"
  ;;

  let render_song_details (song : song) =
    let year = Option.value song.release_date ~default:"" in
    [ h1
        ~a:[ a_class [ "text-4xl"; "font-bold"; "mb-2"; "text-gray-100" ] ]
        [ txt song.song ]
    ; p
        ~a:[ a_class [ "text-xl"; "mb-4"; "text-gray-300" ] ]
        [ txt song.artist; txt " • "; txt (Option.value song.album ~default:"") ]
    ; p ~a:[ a_class [ "text-lg"; "text-gray-400" ] ] [ txt ("Released " ^ year) ]
    ]
  ;;

  let render_stats =
    div
      ~a:[ a_class [ "grid"; "grid-cols-2"; "gap-4"; "text-lg" ] ]
      [ div ~a:[ a_class [ "text-gray-400" ] ] [ txt "Plays" ]
      ; div ~a:[ a_class [ "text-right"; "font-bold"; "text-teal-400" ] ] [ txt "1,234" ]
      ; div ~a:[ a_class [ "text-gray-400" ] ] [ txt "Favorite" ]
      ; div ~a:[ a_class [ "text-right"; "font-bold"; "text-teal-400" ] ] [ txt "95%" ]
      ]
  ;;

  let render_last_played =
    p
      ~a:[ a_class [ "text-sm"; "text-gray-500" ] ]
      [ txt "Last played on KEXP: 2023-04-15" ]
  ;;

  let render ~(song_with_art : t) =
    let artwork = render_artwork song_with_art in
    let details = render_song_details (fst song_with_art) in
    div
      ~a:
        [ a_class
            [ "bg-gray-900"; "shadow-xl"; "rounded-xl"; "p-8"; "max-w-4xl"; "mx-auto" ]
        ]
      [ div
          ~a:[ a_class [ "flex"; "gap-8"; "items-center" ] ]
          [ artwork
          ; div
              ~a:[ a_class [ "flex-1"; "space-y-6" ] ]
              (details @ [ render_stats; render_last_played ])
          ]
      ]
  ;;
end
