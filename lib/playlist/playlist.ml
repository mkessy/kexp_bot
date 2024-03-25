(*
   - need to create abstractions to handle playlist creation
   - the playlists can basically be reduced to sql queries
   - e.g. "top artists played in the last 30 days" becomes "select artist from plays where date > now() - 30 days group by artist order by limit(*) desc"
   - it's probably easiest to just enumerate
*)

(*
   top x artists played in the last y days or all time
   top x songs played in the last y days or all time
   top x songs by artist played in the last y days or all time
   songs played by last x instances of given program
   - instances of of a program are a 'show' so getting the songs from the last playing of a program
     is "most recent grouping of plays by show id where program id = x"
   - how do we get the last grouping of plays by show id?

   last instance of a program is "select * from plays join shows on plays.show = shows.id where shows.id = (select id from shows where program = x order by date desc limit 1)"
*)
