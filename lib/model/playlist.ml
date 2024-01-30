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
  end
end
