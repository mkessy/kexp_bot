type t = string

module Queries = struct
  let insert =
    [%rapper
      execute
        {sql|
          INSERT OR INGORE INTO artists (id)
          VALUES (%string{id})
          |sql}
        syntax_off]
  ;;

  let insert_many =
    [%rapper
      execute
        {sql|
          INSERT OR IGNORE INTO artists (id)
          VALUES %list{( %string{ids} )}
          |sql}
        syntax_off]
  ;;
end
