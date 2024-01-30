
module Db : sig
  val connect: unit -> (Caqti_lwt.connection, [> Caqti_error.t ]) result Lwt.t
end = struct
  let uri = "sqlite3:./path/to/your.db" (* Replace with your actual .db file path *)

  let connect () = 
    Caqti_lwt.connect (Uri.of_string uri)
end
