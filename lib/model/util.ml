module Dynparam = struct
  type t = Pack : 'a Caqti_type.t * 'a -> t

  let empty = Pack (Caqti_type.unit, ())
  let add t x (Pack (t', x')) = Pack (Caqti_type.tup2 t' t, (x', x))
end

(** [days_to_sqlite_expr days] generates a SQLite datetime expression for the past number of [days]. *)
let sql_days_of_int days : string = Printf.sprintf "-%d days" days
