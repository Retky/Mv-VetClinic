/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;
SELECT name, date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

----------

BEGIN;
UPDATE animals
  SET species = 'unspecified';
ROLLBACK;
----------
BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon' WHERE species = '';
COMMIT;
----------
BEGIN;
DELETE FROM animals;
ROLLBACK;
----------
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deldate;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO deldate;
UPDATE animals
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

----------

-- How many animals are there?
SELECT count(*) FROM animals;

-- How many animals have never tried to escape?
SELECT count(*) FROM animals WHERE escape_attempts <= 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT * FROM animals WHERE escape_attempts = (
  SELECT MAX(escape_attempts) FROM animals
);

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2000-12-31'
GROUP BY species;

----------

-- What animals belong to Melody Pond?
SELECT name
  FROM animals
  JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name
  FROM animals
  JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';


-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name
  FROM animals
  FULL JOIN owners ON animals.owner_id = owners.id;


-- How many animals are there per species?
SELECT species.name,
  COUNT(*)
  FROM animals
  JOIN species ON animals.species_id = species.id
  GROUP BY species.name;


-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name
  FROM animals
  JOIN species ON animals.species_id = species.id
  JOIN owners ON owner_id = owners.id
WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';


-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name
  FROM animals
  JOIN owners ON owner_id = owners.id
WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name,
  COUNT(*)
  FROM animals
  JOIN owners ON owner_id = owners.id
GROUP BY full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

-----

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
WHERE vets.name = 'William Tatcher'
GROUP BY visits.date, animals.name
ORDER BY visits.date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vet_names, species.name AS specialty
  FROM specializations
  FULL JOIN vets ON vets_id = vets.id
  FULL JOIN species ON species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
WHERE vets.name = 'Stephanie Mendez' AND date BETWEEN '2020-04-01' AND '2020-08-30'
GROUP BY visits.date, animals.name
ORDER BY visits.date DESC;

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) AS visits FROM visits
  JOIN animals ON animals.id = animals_id
GROUP BY animals.name
ORDER BY visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, owners.full_name AS owner, visits.date
  FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  JOIN owners ON animals.owner_id = owners.id
WHERE vets.name = 'Maisy Smith'
GROUP BY visits.date, animals.name, owners.full_name
ORDER BY visits.date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM visits
  JOIN animals ON animals.id = animals_id
ORDER BY visits.date ASC;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  JOIN owners ON animals.owner_id = owners.id
  JOIN specializations ON vets.id = specializations.vets_id
WHERE specializations.species_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*) FROM visits
  JOIN animals ON animals.id = animals_id
  JOIN vets ON vets.id = vets_id
  JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;
