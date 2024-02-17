type t = string

module Queries = struct
  let insert =
    [%rapper
      execute
        {sql|
          INSERT OR INGORE INTO users (id)
          VALUES (%string{id})
          |sql}
        syntax_off]
  ;;

  let insert_many =
    [%rapper
      execute
        {sql|
          INSERT OR IGNORE INTO users (id)
          VALUES ( %list{%string{ids}} )
          |sql}
        syntax_off]
  ;;
end
