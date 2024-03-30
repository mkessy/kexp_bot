let home ~(playlists : Controller.Types.playlist list) =
  Layouts.base
    [ Layouts.main_layout
        (Components.Menu.render ~home_href:"#" ~about_href:"#" ~contact_href:"#"
         :: [ Components.MainGrid.render ~playlists ])
    ]
;;

let single_playlist ~(playlist : Controller.Types.playlist) =
  Layouts.base [ Layouts.centered_layout (Components.Playlist.render playlist) ]
;;

let single_song ~(song_with_art : Controller.Types.song_with_cover_art) =
  Layouts.base [ Layouts.centered_layout (Components.Song.render ~song_with_art) ]
;;
