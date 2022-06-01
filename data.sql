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
