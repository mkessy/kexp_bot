(*
   id	INTEGER	NO	NULL
   uri	VARCHAR	YES	NULL
   name	VARCHAR	NO	NULL
   is_active	BOOLEAN	NO	NULL
   description	TEXT	YES	NULL
   tags	VARCHAR	YES	NULL
*)

type t =
  { id : int
  ; uri : string option
  ; name : string
  ; is_active : bool
  ; description : string option
  ; tags : string option
  }
[@@deriving yojson, show]

module Dynparam = struct
  type t = Pack : 'a Caqti_type.t * 'a -> t

  let empty = Pack (Caqti_type.unit, ())
  let add t x (Pack (t', x')) = Pack (Caqti_type.tup2 t' t, (x', x))
end

let insert_many_programs (module DB : Caqti_lwt.CONNECTION) programs =
  let placeholders =
    List.map (fun _ -> "(?, ?, ?, ?, ?, ?)") programs |> String.concat ", "
  in
  let (Dynparam.Pack (typ, values)) =
    List.fold_left
      (fun pack p ->
        Dynparam.add
          Caqti_type.(
            tup2
              int
              (tup2
                 (option string)
                 (tup2 string (tup2 bool (tup2 (option string) (option string))))))
          (p.id, (p.uri, (p.name, (p.is_active, (p.description, p.tags)))))
          pack)
      Dynparam.empty
      programs
  in
  let sql =
    Printf.sprintf
      "INSERT INTO programs (id, uri, name, is_active, description, tags) VALUES %s"
      placeholders
  in
  let open Caqti_request.Infix in
  let query = (typ -->. Caqti_type.unit) ~oneshot:true @:- sql in
  DB.exec query values
;;

module Queries = struct
  let insert =
    [%rapper
      execute
        {sql|
    INSERT INTO programs (uri, name, is_active, description, tags)
    VALUES (%string?{uri}, %string{name}, %bool{is_active}, %string?{description}, %string?{tags})
        |sql}
        syntax_off]
  ;;

  let get_by_id =
    [%rapper
      get_opt
        {sql|
        SELECT @int{id}, @string?{uri}, @string{name}, @bool{is_active}, @string?{description}, @string?{tags}
          FROM programs WHERE id = %int{id}
        |sql}
        syntax_off
        record_out]
  ;;

  let get_all =
    [%rapper
      get_many
        {sql| SELECT 
          @int{id},
          @string?{uri},
          @string{name},
          @bool{is_active},
          @string?{description},
          @string?{tags} FROM programs |sql}
        record_out]
  ;;
end
