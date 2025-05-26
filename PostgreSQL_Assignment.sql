-- Active: 1747409864817@@127.0.0.1@5432@conservation_db@public
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL ,
    region VARCHAR(50) 
);

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(50) NOT NULL,
    discovery_date DATE NOT NULL ,
    conservation_status VARCHAR(50) NOT NULL
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id  INT REFERENCES "rangers"(ranger_id) NOT NULL,
    species_id INT REFERENCES "species"(species_id) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(20) NOT NULL ,
    notes VARCHAR (255)
);

INSERT INTO rangers (name, region) VALUES 
('Alice Green ','Northern Hills'),
('Bob White','River Delta '),
('Carol King','Mountain Range');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge',        '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area',     '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass',     '2024-05-18 18:30:00', NULL);



-------------------------Problem-1-------------------------
INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');


-------------------------Problem-2-------------------------
SELECT count(DISTINCT ranger_id) as unique_species_count FROM sightings;


-------------------------Problem-3-------------------------
SELECT * FROM sightings
    WHERE location ILIKE'%Pass%';


-------------------------Problem-4-------------------------
SELECT name, count(*) as total_sightings FROM sightings
NATURAL JOIN rangers
GROUP BY name

-------------------------Problem-5--------------------------
SELECT common_name FROM sightings
RIGHT JOIN species ON sightings.species_id = species.species_id
WHERE sighting_id IS NULL;


-------------------------Problem-6--------------------------
SELECT common_name, sighting_time,name FROM sightings
JOIN rangers ON sightings.ranger_id =rangers.ranger_id
JOIN species ON sightings.species_id = species.species_id
ORDER BY sighting_time DESC
LIMIT 2;

-------------------------Problem-7--------------------------
UPDATE  species
SET conservation_status =  'Historic'
WHERE EXTRACT(YEAR FROM discovery_date )<1800;


-------------------------Problem-8--------------------------
SELECT sighting_id, 
    CASE 
        WHEN  sighting_time::TIME<'12:00' THEN 'Morning'
        WHEN sighting_time::TIME<='17:00' THEN 'Afternoon'
        ELSE 'Evening'
    END 
FROM sightings;

-------------------------Problem-9--------------------------
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings);
