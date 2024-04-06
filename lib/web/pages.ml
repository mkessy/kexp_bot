open Tyxml.Html

let home
  ~(home_playlists : Controller.Types.playlist list)
  ~(history : Controller.Types.play_song list)
  =
  let main_menu =
    Components.Menu.render ~home_href:"#" ~about_href:"#" ~contact_href:"#"
  in
  Layouts.base
    ~history
    ~body_content:
      (Layouts.main_layout
         [ main_menu; Components.MainGrid.render ~playlists:home_playlists ])
;;

let single_song
  ~(song_with_art : Controller.Types.song_with_cover_art)
  ~(history : Controller.Types.play_song list)
  =
  let song_name = fst song_with_art |> fun song -> song.song in
  Layouts.base
    ~history
    ~body_content:
      (Layouts.centered_layout
         (div
            [ Components.Navigation.render
                ~items:
                  [ a ~a:[ a_href "/" ] [ txt "Home" ]
                  ; a ~a:[ a_href "#" ] [ txt "Songs" ]
                  ; txt song_name
                  ]
            ; Components.Song.render ~song_with_art
            ]))
;;

let search ~(history : Controller.Types.play_song list) =
  Layouts.base
    ~history
    ~body_content:
      (Layouts.search_layout
         [ Components.Navigation.render
             ~items:[ a ~a:[ a_href "/" ] [ txt "Home" ]; txt "Search" ]
         ; div
             ~a:[ a_class [ "max-w-lg"; "w-full" ] ]
             [ h1
                 ~a:[ a_class [ "text-4xl"; "font-bold"; "mb-8"; "text-center" ] ]
                 [ txt "Search" ]
             ; Components.Search.render
             ]
         ])
;;

let single_playlist
  ~(playlist : Controller.Types.playlist)
  ~(history : Controller.Types.play_song list)
  =
  Layouts.base
    ~history
    ~body_content:
      (Layouts.centered_layout
         (div
            [ Components.Navigation.render
                ~items:
                  [ a ~a:[ a_href "/" ] [ txt "Home" ]
                  ; a ~a:[ a_href "#" ] [ txt "Playlists" ]
                  ; txt playlist.name
                  ]
            ; Components.Playlist.render playlist
            ]))
;;
