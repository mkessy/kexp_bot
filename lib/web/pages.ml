let home ~(playlists : Controller.Types.playlist list) =
  Layouts.base
    [ Layouts.main_layout
        (Components.Menu.render ~home_href:"#" ~about_href:"#" ~contact_href:"#"
         :: [ Components.MainGrid.render ~playlists ])
    ]
;;

let single_playlist (pl : Controller.Types.playlist) =
  Layouts.base [ Layouts.centered_layout (Components.Playlist.render pl) ]
;;
