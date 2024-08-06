--Using the SQL Server Object Explorer in Visual Studio, examine the tables, columns, and foreign keys of the database

--Query all of the entries in the Genre table

SELECT *
FROM Genre;

--Query all the entries in the Artist table and order by the artist's name. HINT: use the ORDER BY keywords

SELECT *
FROM Artist
ORDER BY ArtistName;

--Write a SELECT query that lists all the songs in the Song table and include the Artist name
SELECT s.Title, a.ArtistName
FROM Song s
JOIN Artist a
ON s.ArtistId = a.Id;

--Write a SELECT query that lists all the Artists that have a Pop Album
SELECT a.ArtistName
FROM Artist a
JOIN Album al
ON a.Id = al.ArtistId
JOIN Genre g
ON al.GenreId = g.Id
WHERE g.Name = 'Pop';

--Write a SELECT query that lists all the Artists that have a Jazz or Rock Album
SELECT DISTINCT a.ArtistName
FROM Artist a
JOIN Album al
ON a.Id = al.ArtistId
JOIN Genre g
ON al.GenreId = g.Id
WHERE g.Name = 'Jazz' OR g.Name = 'Rock';

--Write a SELECT statement that lists the Albums with no songs
SELECT a.Title, s.Title
FROM Album a
LEFT JOIN Song s
ON a.Id = s.AlbumId
WHERE s.Title IS NULL;

--Using the INSERT statement, add one of your favorite artists to the Artist table.
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('GWAR', 1984);

--Using the INSERT statement, add one, or more, albums by your artist to the Album table.
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Scumdogs of the Universe', '01/08/1990', 3355, 'Metal Blade Records', 28, 5);

--Using the INSERT statement, add some songs that are on that album to the Song table.  Album 23
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('The Years Without Light', 178, '01/08/1990', 5, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Vlad The Impaler', 194, '01/08/1990', 5, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Love Surgery', 238, '01/08/1990', 5, 28, 23);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Cool Place to Park (Vocals by Beefcake the Mighty)', 242, '01/08/1990', 5, 28, 23);

--Write a SELECT query that provides the song titles, album title, and artist name for all of the data you just entered in. 
--Use the LEFT JOIN keyword sequence to connect the tables, and the WHERE keyword to filter the results to the album and artist you added.

SELECT s.Title, al.Title, ar.ArtistName
FROM Song s
JOIN Album al
ON s.AlbumId = al.Id
JOIN Artist ar
ON al.ArtistId = ar.Id
WHERE al.Title = 'Scumdogs of the Universe' AND ar.ArtistName = 'GWAR';

--NOTE: Direction of join matters. Try the following statements and see the difference in results.

SELECT s.Title, al.Title, ar.ArtistName
FROM Song s
JOIN Album al
ON s.AlbumId = al.Id
JOIN Artist ar
ON al.ArtistId = ar.Id
WHERE al.Title = 'Scumdogs of the Universe' AND ar.ArtistName = 'GWAR';

SELECT a.Title, s.Title FROM Album a LEFT JOIN Song s ON s.AlbumId = a.Id;

SELECT a.Title, s.Title FROM Song s LEFT JOIN Album a ON s.AlbumId = a.Id;

--Write a SELECT statement to display how many songs exist for each album. 
--You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT a.Title, COUNT(s.Id) AS 'Num of Songs'
FROM Album a
LEFT JOIN Song s
ON a.Id = s.AlbumId
GROUP BY a.Title;

--Write a SELECT statement to display how many songs exist for each artist. 
--You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT a.ArtistName, COUNT(s.Id) AS 'Num of Songs'
FROM Artist a
LEFT JOIN Song s
ON a.Id = s.ArtistId
GROUP BY a.ArtistName;

--Write a SELECT statement to display how many songs exist for each genre. 
--You'll need to use the COUNT() function and the GROUP BY keyword sequence.

SELECT g.Name, COUNT(s.Id) As 'Songs per Genre'
FROM Genre g
LEFT JOIN Song s
ON g.Id = s.GenreId
GROUP BY g.Name;

SELECT COUNT(*) AS 'Num of Songs in DB'
FROM Song;

--Write a SELECT query that lists the Artists that have put out records on more than one record label. 
--Hint: When using GROUP BY instead of using a WHERE clause, use the HAVING keyword

SELECT a.ArtistName, COUNT(al.Label) AS 'Num of Labels'
FROM Artist a
JOIN Album al
ON a.Id = al.ArtistId
GROUP BY a.ArtistName
HAVING COUNT(DISTINCT al.Label) > 1;

--Using MAX() function, write a select statement to find the album with the longest duration. 
--The result should display the album title and the duration.

SELECT TOP 1 al.Title, MAX(al.AlbumLength)
FROM Album al
GROUP BY al.Title
ORDER BY MAX(al.AlbumLength) DESC;

SELECT al.Title, al.AlbumLength
FROM Album al
WHERE al.AlbumLength = (SELECT MAX(AlbumLength) FROM Album);

--Using MAX() function, write a select statement to find the song with the longest duration. 
--The result should display the song title and the duration.
SELECT TOP 1 s.Title, MAX(s.SongLength)
FROM Song s
GROUP BY s.Title
ORDER BY MAX(s.SongLength) DESC;

--Modify the previous query to also display the title of the album.
SELECT TOP 1 s.Title, al.Title, MAX(s.SongLength)
FROM Song s
JOIN Album al
ON s.AlbumId = al.Id
GROUP BY s.Title, al.Title
ORDER BY MAX(s.SongLength) DESC;








