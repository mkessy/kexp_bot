module Db : sig
  val connect : unit -> (Caqti_lwt.connection, [> Caqti_error.t ]) result Lwt.t

  val transaction
    :  ((module Caqti_lwt.CONNECTION)
        -> (unit, ([> Caqti_error.transact ] as 'a)) Lwt_result.t)
         list
    -> (module Caqti_lwt.CONNECTION)
    -> (unit, 'a) Lwt_result.t
end = struct
  let uri = "sqlite3:./path/to/your.db" (* Replace with your actual .db file path *)
  let connect () = Caqti_lwt.connect (Uri.of_string uri)

  let iter_queries queries conn =
    List.fold_left
      (fun a f -> Lwt_result.bind a (fun () -> f conn))
      (Lwt.return (Ok ()))
      queries
  ;;

  let transaction queries conn =
    let open Lwt_result.Syntax in
    let module Connection = (val conn : Caqti_lwt.CONNECTION) in
    let* () = Connection.start () in
    match%lwt iter_queries queries conn with
    | Ok () -> Connection.commit ()
    | Error e ->
      let%lwt _ = Connection.rollback () in
      Lwt.return (Error e)
  ;;
end
