-- 1. Количество исполнителей в каждом жанре;
-- Способ 1
SELECT COUNT(performer_id) AS count_pi, genre_id AS gi
  FROM performers_genres AS pg
 GROUP BY gi
 ORDER BY count_pi DESC;
-- Способ 2
SELECT COUNT(performer_id) AS count_performer, name_genre AS ng
  FROM performers_genres AS pg
       JOIN genres AS g 
       ON pg.genre_id = g.genre_id
 GROUP BY ng
 ORDER BY count_performer DESC;
 
-- 2. Количество треков, вошедших в альбомы 2019-2020 годов;
SELECT name_album, year_album, COUNT(name_track) AS count_nt
  FROM albums AS a
       JOIN tracks AS t 
       ON a.album_id = t.album_id
 WHERE year_album BETWEEN 2019 AND 2020
 GROUP BY a.album_id
 ORDER BY count_nt DESC;

-- 3. Средняя продолжительность треков по каждому альбому;
SELECT name_album AS na, AVG(duration)
  FROM tracks AS t
       JOIN albums AS a 
       ON a.album_id = t.album_id 
 GROUP BY na;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году;
SELECT alias, name_album, year_album  
  FROM albums AS a
       JOIN performers_albums AS pa 
       ON a.album_id = pa.album_id
       JOIN performers AS p
       ON p.performer_id = pa.performer_id 
 WHERE NOT year_album  = 2020;

-- 5. Названия сборников, в которых присутствует конкретный исполнитель 'Frank Sinatra';
SELECT DISTINCT(name_collection), alias
  FROM collections AS c
       JOIN collections_tracks AS ct
       ON c.collection_id = ct.collection_id
       JOIN tracks AS t 
       ON ct.track_id = t.track_id
       JOIN performers_albums AS pa 
       ON t.album_id = pa.album_id
       JOIN performers AS p 
       ON pa.performer_id = p.performer_id   
 WHERE alias LIKE 'Frank Sinatra';
 
--6. Название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT name_album, COUNT(name_genre) AS count_genre  
  FROM albums AS a
       JOIN performers_albums AS pa
       ON a.album_id = pa.album_id
       JOIN performers_genres AS pg 
       ON pa.performer_id = pg.performer_id
       JOIN genres AS g 
       ON pg.genre_id = g.genre_id
 GROUP BY name_album
HAVING COUNT(name_genre) > 1;

--7. Наименование треков, которые не входят в сборники;
 SELECT name_track 
   FROM tracks 
  WHERE name_track NOT IN 
        (SELECT DISTINCT(name_track) 
           FROM tracks AS t
                JOIN collections_tracks AS ct
                ON t.track_id = ct.track_id);

--8. Исполнителя(-ей), написавшего самый короткий по продолжительности трек;  
SELECT alias, duration
   FROM tracks AS t
        JOIN performers_albums AS pa
        ON t.album_id = pa.album_id
        JOIN performers AS p
        ON pa.performer_id = p.performer_id
  WHERE duration = (SELECT MIN(duration) 
                    FROM tracks)

--9. Названия альбомов, содержащих наименьшее количество треков.
SELECT name_album, COUNT(name_track) AS count_track 
  FROM albums AS a
       JOIN tracks AS t 
       ON a.album_id = t.album_id
 GROUP BY name_album
 HAVING COUNT(name_track) = (SELECT COUNT(name_track)
                               FROM albums AS a
                                    JOIN tracks AS t 
                                    ON a.album_id = t.album_id
                              GROUP BY name_album
                              ORDER BY COUNT(name_track)  
                              LIMIT 1);


