-- 1 вариант

CREATE TABLE IF NOT EXISTS Performers (
	performer_id SERIAL PRIMARY KEY,
	alias VARCHAR(40) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS Genres (
	genre_id SERIAL PRIMARY KEY,
	name VARCHAR(40) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS Performers_Genres (
	performer_id INTEGER REFERENCES Performers(performer_id),
	genre_id INTEGER REFERENCES Genres(genre_id),
	CONSTRAINT pk_PG PRIMARY KEY (performer_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Albums (
	album_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Performers_Albums (
	performer_id INTEGER REFERENCES Performers(performer_id),
	album_id INTEGER REFERENCES Albums(album_id),
	CONSTRAINT pk_PA PRIMARY KEY (performer_id, album_id)
);

CREATE TABLE IF NOT EXISTS Tracks (
	track_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	duration INTEGER NOT NULL,
	album_id INTEGER REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS Collections (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Collections_Tracks (
	collection_id INTEGER REFERENCES Collections(collection_id),
	track_id INTEGER REFERENCES Tracks(track_id),
	CONSTRAINT pk_CT PRIMARY KEY (collection_id, track_id)
);

---------------------------------------------------------------
-- 2 вариант


CREATE TABLE IF NOT EXISTS Performers (
    performer_id INTEGER     PRIMARY KEY
                             GENERATED ALWAYS AS IDENTITY,
    alias        VARCHAR(40) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS Genres (
    genre_id   INTEGER     PRIMARY KEY
                           GENERATED ALWAYS AS IDENTITY,
    name_genre VARCHAR(40) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS Performers_Genres (
    performer_id INTEGER REFERENCES Performers(performer_id),
    genre_id     INTEGER REFERENCES Genres(genre_id),
    CONSTRAINT pk_PG     PRIMARY KEY (performer_id, genre_id)
);

CREATE TABLE IF NOT EXISTS Albums (
    album_id   INTEGER     PRIMARY KEY
                           GENERATED ALWAYS AS IDENTITY,
    name_album VARCHAR(60) UNIQUE NOT NULL,
    year_album INTEGER     NOT NULL
               CHECK(year_album BETWEEN 1980 AND 2030)
);

CREATE TABLE IF NOT EXISTS Performers_Albums (
    performer_id INTEGER REFERENCES Performers(performer_id),
    album_id     INTEGER REFERENCES Albums(album_id),
    CONSTRAINT pk_PA     PRIMARY KEY (performer_id, album_id)
);

CREATE TABLE IF NOT EXISTS Tracks (
    track_id   INTEGER        PRIMARY KEY
                              GENERATED ALWAYS AS IDENTITY,
    name_track VARCHAR(60)    UNIQUE NOT NULL,
    duration   INTEGER        NOT NULL
               CHECK(duration BETWEEN 30 AND 1000),
    album_id   INTEGER        REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT EXISTS Collections (
    collection_id   INTEGER     PRIMARY KEY
                                GENERATED ALWAYS AS IDENTITY,
    name_collection VARCHAR(60) UNIQUE NOT NULL,
    year_collection INTEGER     NOT NULL
                    CHECK(year_collection BETWEEN 1980 AND 2030)
);

CREATE TABLE IF NOT EXISTS Collections_Tracks (
    collection_id INTEGER REFERENCES Collections(collection_id),
    track_id      INTEGER REFERENCES Tracks(track_id),
    CONSTRAINT pk_CT      PRIMARY KEY (collection_id, track_id)
);




-- Заметки:

-- Удаление данных из таблицы (my_table) и сброс счетчика (ID), 
-- CASCADE для каскадного удаления всех связаных таблиц с my_table
-- TRUNCATE TABLE my_table RESTART IDENTITY [CASCADE];

-- Создание стобца ID (используется вместо SERIAL)
--CREATE TABLE IF NOT EXISTS my_table (
--    my_id INTEGER     PRIMARY KEY
--                      GENERATED ALWAYS AS IDENTITY;