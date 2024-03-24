open Kexp_bot

let () =
  Dream.run @@ Dream.logger @@ Dream.sql_pool "sqlite3:kexp.sqlite" @@ Router.router
;;
