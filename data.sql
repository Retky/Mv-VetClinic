/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);

----------

INSERT INTO animals VALUES (DEFAULT, 'Charmander', '2020-02-08', 0, FALSE, 11);
INSERT INTO animals VALUES (DEFAULT, 'Plantmon', '2021-11-15', 2, TRUE, 5.7);
INSERT INTO animals VALUES (DEFAULT, 'Squirtle', '1993-04-02', 3, FALSE, 12.13);
INSERT INTO animals VALUES (DEFAULT, 'Angemon', '2005-06-12', 1, TRUE, 45);
INSERT INTO animals VALUES (DEFAULT, 'Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals VALUES (DEFAULT, 'Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals VALUES (DEFAULT, 'Ditto', '2022-05-15', 4, TRUE, 22);

----------

BEGIN;
INSERT INTO owners VALUES
(DEFAULT, 'Sam Smith', 34),
(DEFAULT, 'Jennifer Orwell', 19),
(DEFAULT, 'Bob', 45),
(DEFAULT, 'Melody Pond', 77),
(DEFAULT, 'Dean Winchester', 14),
(DEFAULT, 'Jodie Whittaker', 38);
COMMIT;

BEGIN;
INSERT INTO species VALUES
(DEFAULT, 'Pokemon'),
(DEFAULT, 'Digimon');
COMMIT;

BEGIN;
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
SET owner_id =
  CASE name
    WHEN 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN 'Gabumon' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN 'Devimon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN 'Charmander' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Squirtle' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Angemon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    WHEN 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  END;
COMMIT;

-----

BEGIN;
INSERT INTO vets VALUES
(DEFAULT, 'William Tatcher', 45, '2000-04-23'),
(DEFAULT, 'Maisy Smith', 26, '2019-01-17'),
(DEFAULT, 'Stephanie Mendez', 64, '1980-05-04'),
(DEFAULT, 'Jack Harkness', 38, '2008-06-08');
COMMIT;

BEGIN;
INSERT INTO specializations VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));
COMMIT;
