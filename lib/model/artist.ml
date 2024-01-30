type t = { id : string } [@@deriving yojson]

module Queries = struct
  let insert =
    [%rapper
      execute
        {sql|
          INSERT INTO users (id)
          VALUES (%string{id})
          |sql}
        syntax_off]
  ;;
end
