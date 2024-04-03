let router =
  Dream.router
    [ Dream.get "/static/**" (Dream.static "./www/static")
    ; Dream.get "/" Handler.index
    ; Dream.get "/playlist/:id" Handler.playlist
    ; Dream.get "/song/:song_id" Handler.song
    ; Dream.get "/search" Handler.search
    ; Dream.scope
        "/api"
        [ Dream.origin_referrer_check ]
        [ Dream.post "/search" Handler.api_search ]
    ]
;;
