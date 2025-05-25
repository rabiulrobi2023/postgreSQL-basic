-- Active: 1747409864817@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

DROP TABLE rangers;

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
)

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id  INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time DATE NOT NULL,
    location VARCHAR(20) NOT NULL,
    notes VARCHAR (255)
);



