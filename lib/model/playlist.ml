[@@@warning "-33"]

(*
   id	name	description	created_at	updated_at
   1	recently_played	Songs played in the last 30 days	2024-01-20 19:13:47	2024-01-20 19:13:47
*)

module Playlist = struct
  type t =
    { id : int
    ; name : string
    ; description : string option
    ; created_at : string
    ; updated_at : string
    }
  [@@deriving yojson]

  module Queries = struct
    open Caqti_request.Infix

    let get_by_id =
      [%rapper
        get_opt
          {sql|
          SELECT @int{id}, @string{name}, @string?{description}, @string{created_at}, @string{updated_at} 
          FROM playlist
          WHERE id = %int{id}
    |sql}
          syntax_off
          record_out]
    ;;

    let get_all =
      [%rapper
        get_many
          {sql|
          SELECT @int{id}, @string{name}, @string?{description}, @string{created_at}, @string{updated_at} 
          FROM playlist
    |sql}
          syntax_off
          record_out]
    ;;

    let insert_and_get ~name ~description =
      let open Lwt_result.Infix in
      let insert_sql =
        {sql| INSERT INTO playlist (name, description, created_at, updated_at) VALUES (?, ?, datetime('now'), datetime('now')) |sql}
      in
      let select_sql =
        {sql| SELECT * FROM playlist WHERE id = last_insert_rowid() |sql}
      in
      let insert_query = Caqti_type.(tup2 string (option string) ->. unit) insert_sql in
      let select_query =
        Caqti_type.(
          unit ->! tup2 int (tup2 string (tup2 (option string) (tup2 string string))))
          select_sql
      in
      fun (module DB : Caqti_lwt.CONNECTION) ->
        DB.exec insert_query (name, description) >>= DB.find select_query
    ;;
  end
end
