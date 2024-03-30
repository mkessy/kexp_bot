open Tyxml.Html

let home ~(playlists : Controller.Types.playlist list) =
  Layouts.base
    [ Layouts.main_layout
        (Components.Menu.render ~home_href:"#" ~about_href:"#" ~contact_href:"#"
         :: [ Components.MainGrid.render ~playlists ])
    ]
;;

let single_song ~(song_with_art : Controller.Types.song_with_cover_art) =
  let song_name = fst song_with_art |> fun song -> song.song in
  Layouts.base
    [ Layouts.centered_layout
        (div
           [ Components.Navigation.render
               ~items:
                 [ a ~a:[ a_href "/" ] [ txt "Home" ]
                 ; a ~a:[ a_href "#" ] [ txt "Songs" ]
                 ; txt song_name
                 ]
           ; Components.Song.render ~song_with_art
           ])
    ]
;;

let single_playlist ~(playlist : Controller.Types.playlist) =
  Layouts.base
    [ Layouts.centered_layout
        (div
           [ Components.Navigation.render
               ~items:
                 [ a ~a:[ a_href "/" ] [ txt "Home" ]
                 ; a ~a:[ a_href "#" ] [ txt "Playlists" ]
                 ; txt playlist.name
                 ]
           ; Components.Playlist.render playlist
           ])
    ]
;;
