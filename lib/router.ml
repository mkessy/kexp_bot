let router =
  Dream.router [ Dream.get "/" Handler.index; Dream.get "/playlist/:id" Handler.playlist ]
;;
