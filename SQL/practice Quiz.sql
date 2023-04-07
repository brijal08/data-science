show databases;
USE Chinook;

SELECT * FROM PlaylistTrack;

SELECT TrackId, COUNT(PlaylistId)
FROM PlaylistTrack
WHERE PlaylistId = 2
GROUP BY TrackId;

SELECT * FROM Track;

select count(*) from genre;

select count(Distinct Name) from track;

select Title, count(Title) from employee
group by Title
order by count(Title) desc;

select al.ArtistId, ar.Name, count(al.ArtistId) 
from album al join artist ar
on al.ArtistId = ar. ArtistId
group by al.ArtistId
order by count(al.ArtistId) desc;

select Composer, count(TrackId) from track
where Milliseconds < 290000
group by Composer
order by count(TrackId) desc;

select count(*) from album
where Title like '%rock%';

select g.Name, count(t.GenreId) 
from genre g join track t
on g.GenreId = t.GenreId
group by g.GenreId
order by count(t.GenreId) desc;



