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
UPDATE animals
SET species = 'unspecified';

SELECT name,species FROM animals;

ROLLBACK TRANSACTION;

SELECT name,species FROM animals;

/* Inside a transaction:
- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
- Commit the transaction.
- Verify that change was made and persists after commit. */

BEGIN TRANSACTION;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT name,species FROM animals;

COMMIT TRANSACTION;

SELECT name,species FROM animals;

/* Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;) */

BEGIN TRANSACTION;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK TRANSACTION;

SELECT * FROM animals;

/* Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction */

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-1-1';

SELECT name, date_of_birth FROM animals;

SAVEPOINT S1;

UPDATE animals
SET weight_kg = weight_kg * (-1);

SELECT name, weight_kg from animals;

ROLLBACK TO S1;

UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;

SELECT name, weight_kg from animals;

COMMIT TRANSACTION;


-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) as "Escape count" FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31' GROUP BY species;
