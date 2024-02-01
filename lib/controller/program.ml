module Program = struct
  open Model

  type t = Program.t [@@deriving yojson]

  let insert_program (program : t) conn =
    Model.Program.Queries.insert
      ~uri:program.uri
      ~name:program.name
      ~is_active:program.is_active
      ~description:program.description
      ~tags:program.tags
      conn
  ;;

  let get_all conn = Model.Program.Queries.get_all conn
end
