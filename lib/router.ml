let router =
  Dream.router
    [ Dream.get "/" Handler.index
    ; Dream.get "/playlist/:id" Handler.playlist
    ; Dream.get "/song/:song_id" Handler.song
    ]
;;
