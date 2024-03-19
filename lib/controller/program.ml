module Program = struct
  open Model

  type t = Program.t [@@deriving yojson]

  let insert_program ~(program : t) conn =
    Model.Program.Queries.insert
      ~uri:program.uri
      ~name:program.name
      ~is_active:program.is_active
      ~description:program.description
      ~tags:program.tags
      conn
  ;;

  let insert_many ~(programs : t list) conn = Program.Queries.insert_many conn programs
  let get_all conn = Program.Queries.get_all conn
  let get_latest conn = Program.Queries.get_latest conn
end
