CREATE TABLE dw_chinook.dim_track AS
SELECT  track.track_id
       ,track.name      AS track
       ,media_type.name AS media_type
       ,genre.name      AS genre
       ,album.title     AS album
       ,artist.name     AS artist
       ,playlist.name   AS playlist
       ,composer
       ,milliseconds
       ,bytes
FROM chinook.track
INNER JOIN chinook.media_type
ON media_type.media_type_id = track.media_type_id
INNER JOIN chinook.genre
ON genre.genre_id = track.genre_id
INNER JOIN chinook.album
ON album.album_id = track.album_id
	INNER JOIN chinook.artist
	ON artist.artist_id = album.album_id
INNER JOIN chinook.playlist_track
ON playlist_track.track_id = track.track_id
	INNER JOIN chinook.playlist
	ON playlist.playlist_id = playlist_track.playlist_id;
