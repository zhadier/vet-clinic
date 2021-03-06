/*Queries that provide answers to the questions from all projects.*/
-- Milestone-1
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon%';

SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-01-01';

SELECT
  name
FROM
  animals
WHERE
  neutered = true
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN ('Agumon', 'Pikachu');

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

SELECT
  *
from
  animals
WHERE
  neutered = true;

SELECT
  *
from
  animals
WHERE
  name != 'Gabumon';

SELECT
  *
from
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

-- Milestone 2
/* Inside a transaction update the animals table by setting the species column to unspecified.
 Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.*/
BEGIN TRANSACTION;

UPDATE
  animals
SET
  species = 'unspecified';

SELECT
  name,
  species
FROM
  animals;

ROLLBACK TRANSACTION;

SELECT
  name,
  species
FROM
  animals;

/* Inside a transaction:
 - Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
 - Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
 - Commit the transaction.
 - Verify that change was made and persists after commit. */
BEGIN TRANSACTION;

UPDATE
  animals
SET
  species = 'digimon'
WHERE
  name LIKE '%mon%';

UPDATE
  animals
SET
  species = 'pokemon'
WHERE
  species IS NULL;

SELECT
  name,
  species
FROM
  animals;

COMMIT TRANSACTION;

SELECT
  name,
  species
FROM
  animals;

/* Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
 After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;) */
BEGIN TRANSACTION;

DELETE FROM
  animals;

SELECT
  *
FROM
  animals;

ROLLBACK TRANSACTION;

SELECT
  *
FROM
  animals;

/* Inside a transaction:
 Delete all animals born after Jan 1st, 2022.
 Create a savepoint for the transaction.
 Update all animals' weight to be their weight multiplied by -1.
 Rollback to the savepoint
 Update all animals' weights that are negative to be their weight multiplied by -1.
 Commit transaction */
BEGIN TRANSACTION;

DELETE FROM
  animals
WHERE
  date_of_birth > '2022-1-1';

SELECT
  name,
  date_of_birth
FROM
  animals;

SAVEPOINT S1;

UPDATE
  animals
SET
  weight_kg = weight_kg * (-1);

SELECT
  name,
  weight_kg
from
  animals;

ROLLBACK TO S1;

UPDATE
  animals
SET
  weight_kg = weight_kg * (-1)
WHERE
  weight_kg < 0;

SELECT
  name,
  weight_kg
from
  animals;

COMMIT TRANSACTION;

-- How many animals are there?
SELECT
  COUNT(*)
FROM
  animals;

-- How many animals have never tried to escape?
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts = 0;

-- What is the average weight of animals?
SELECT
  AVG(weight_kg)
FROM
  animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
  neutered,
  COUNT(escape_attempts) as "Escape count"
FROM
  animals
GROUP BY
  neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT
  species,
  MIN(weight_kg),
  MAX(weight_kg)
FROM
  animals
GROUP BY
  species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
  species,
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-1-1'
  AND '2000-12-31'
GROUP BY
  species;

-- Milestone-3 
-- What animals belong to Melody Pond?
SELECT
  name,
  full_name as Owner
FROM
  animals
  JOIN owners on animals.owner_id = owners.id
WHERE
  full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
  A.name,
  S.name as Species
FROM
  animals as A
  JOIN species as S on A.species_id = S.id
WHERE
  S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
  full_name as Owner,
  name
FROM
  animals
  RIGHT JOIN owners on animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT
  COUNT(A.name),
  S.name as Species
FROM
  species as S
  JOIN animals as A on S.id = A.species_id
GROUP BY
  S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT
  A.name,
  full_name as Owner,
  S.name as Species
FROM
  animals as A
  JOIN owners on A.owner_id = owners.id
  JOIN species as S on A.species_id = S.id
WHERE
  S.name = 'Digimon'
  AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
  A.name,
  full_name as Owner,
  escape_attempts
FROM
  animals as A
  JOIN owners on A.owner_id = owners.id
WHERE
  escape_attempts = 0
  AND full_name = 'Dean Winchester';

-- Who owns the most animals?
SELECT
  COUNT(*),
  full_name as Owner
FROM
  animals as A
  JOIN owners on A.owner_id = owners.id
GROUP BY
  full_name
ORDER BY
  COUNT(*) desc
LIMIT
  1;

-- Milestone-4
-- Who was the last animal seen by William Tatcher?
SELECT
  animals.name as Animal,
  vets.name as Vet,
  date_of_visit
FROM
  visits
  JOIN vets on visits.vet_id = vets.id
  JOIN animals on visits.animal_id = animals.id
WHERE
  vets.name = 'William Thatcher'
ORDER BY
  date_of_visit desc
LIMIT
  1;

-- How many different animals did Stephanie Mendez see?
SELECT
  COUNT(DISTINCT animals.name)
FROM
  visits
  JOIN vets on visits.vet_id = vets.id
  JOIN animals on visits.animal_id = animals.id
WHERE
  vets.name = 'Stephanie Mendez';

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name as Animal,
  vets.name as Vet,
  date_of_visit
FROM
  visits
  JOIN vets on visits.vet_id = vets.id
  JOIN animals on visits.animal_id = animals.id
WHERE
  vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-4-1'
  AND '2020-8-30';

-- What animal has the most visits to vets?
SELECT
  COUNT(animals.name),
  animals.name
FROM
  visits
  JOIN animals on visits.animal_id = animals.id
GROUP BY
  animals.name
ORDER BY
  COUNT(animals.name) desc
LIMIT
  1;

-- Who was Maisy Smith's first visit?
SELECT
  animals.name as Animal,
  vets.name as Vet,
  date_of_visit
FROM
  visits
  JOIN vets on visits.vet_id = vets.id
  JOIN animals on visits.animal_id = animals.id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  date_of_visit
LIMIT
  1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  date_of_visit,
  animals.name as "animal's name",
  animals.date_of_birth,
  animals.escape_attempts,
  animals.neutered,
  animals.weight_kg,
  vets.name as "vet's name",
  vets.age as "vet's age",
  vets.date_of_graduation
FROM
  visits
  JOIN vets on visits.vet_id = vets.id
  JOIN animals on visits.animal_id = animals.id
ORDER BY
  date_of_visit desc
LIMIT
  1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  -- You can have COUNT(animals.name) here if you want count instead of tabular data
  vet_specs.species_name,
  vet_specs.name,
  animals.name as "Animal Name"
FROM
  visits
  JOIN (
    SELECT
      vets.name,
      vets.id as vet_id,
      species.name as species_name,
      species.id as species_id
    FROM
      specializations
      JOIN vets on specializations.vet_id = vets.id
      JOIN species on specializations.species_id = species.id
  ) as vet_specs on visits.vet_id = vet_specs.vet_id
  JOIN animals on visits.animal_id = animals.id
WHERE
  animals.species_id != vet_specs.species_id
  AND vet_specs.name != 'Stephanie Mendez';

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  specs.species_name,
  COUNT(specs.species_name)
FROM
  visits
  JOIN (
    SELECT
      animals.name,
      animals.id as animal_id,
      species.name as species_name,
      species.id as species_id
    FROM
      animals
      JOIN species on animals.species_id = species.id
  ) as specs on visits.animal_id = specs.animal_id
  JOIN vets on visits.vet_id = vets.id
WHERE
  vets.name = 'Maisy Smith'
GROUP BY
  specs.species_name
ORDER BY
  COUNT(specs.species_name) desc
LIMIT
  1;