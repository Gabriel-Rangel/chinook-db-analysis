-- dw_chinook is the collection of fact and dimensions tables where the datawarehouse is logical organized.
-- chinook is the collection of tables that contains the original transactional database.

CREATE TABLE dw_chinook.dim_track AS
SELECT  track.track_id
       ,track.name      AS track -- name of track
       ,media_type.name AS media_type -- name of media type
       ,genre.name      AS genre -- name of genre
       ,album.title     AS album -- name of album
       ,artist.name     AS artist -- name of artist
       ,playlist.name   AS playlist -- name of playlist
       ,track.composer
       ,track.milliseconds
       ,track.bytes
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
