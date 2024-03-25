module Artist = struct
  open Model

  type artist = Artist.t
  type song_arist = Song_artist.t

  let insert_many ~(artists : artist list) = Artist.Queries.insert_many ~ids:artists

  let insert_many_song_artist ~(song_artists : song_arist list) conn =
    Song_artist.Queries.insert_many conn song_artists
  ;;

  let top_played_artists ~days ~limit conn =
    Model.Artist.Queries.top_played_artists ~days ~limit conn
  ;;
end
