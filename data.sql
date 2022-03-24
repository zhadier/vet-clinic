/* Populate database with sample data. */
INSERT INTO
  animals(
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Agumon', '2022-02-03', 0, true, 10.23);

INSERT INTO
  animals(
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO
  animals(
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Pikachu', '2021-1-7', 1, false, 15.04);

INSERT INTO
  animals(
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Devimon', '2017-5-12', 5, true, 11);

-- Milestone-2
INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Charmander', '2020-2-8', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-4-2', 3, false, -12.13),
  ('Angemon', '2005-6-12', 1, true, -45),
  ('Boarmon', '2005-6-7', 7, true, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17),
  ('Ditto', '2022-5-14', 4, true, 22);

-- Milestone-3
INSERT INTO
  owners(full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO
  species(name)
VALUES
  ('Pokemon'),
  ('Digimon');

/*Modify your inserted animals so it includes the species_id value:
 If the name ends in "mon" it will be Digimon
 All other animals are Pokemon*/
BEGIN TRANSACTION;

UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    where
      name = 'Digimon'
  )
WHERE
  name LIKE '%mon%';

UPDATE
  animals
SET
  species_id = (
    SELECT
      id
    FROM
      species
    where
      name = 'Pokemon'
  )
WHERE
  name NOT LIKE '%mon%';

COMMIT;

/*Modify your inserted animals to include owner information (owner_id):
 Sam Smith owns Agumon.
 Jennifer Orwell owns Gabumon and Pikachu.
 Bob owns Devimon and Plantmon.
 Melody Pond owns Charmander, Squirtle, and Blossom.
 Dean Winchester owns Angemon and Boarmon.*/
BEGIN TRANSACTION;

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    where
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    where
      full_name = 'Jennifer Orwell'
  )
WHERE
  name IN ('Gabumon', 'Pikachu');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    where
      full_name = 'Bob'
  )
WHERE
  name IN ('Devimon', 'Plantmon');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    where
      full_name = 'Melody Pond'
  )
WHERE
  name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    where
      full_name = 'Dean Winchester'
  )
WHERE
  name IN ('Angemon', 'Boarmon');

COMMIT;

-- Milestone-4
INSERT INTO
  vets(name, age, date_of_graduation)
VALUES
  ('William Thatcher', 45, '2000-4-23'),
  ('Maisy Smith', 26, '2019-1-17'),
  ('Stephanie Mendez', 64, '1981-5-4'),
  ('Jack Harkness', 38, '2008-6-8');

INSERT INTO
  specializations(species_id, vet_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        species.name = 'Pokemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'William Thatcher'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        species.name = 'Pokemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        species.name = 'Digimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        species.name = 'Digimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Jack Harkness'
    )
  );

INSERT INTO
  visits(animal_id, vet_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'William Thatcher'
    ),
    '2020-5-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    ),
    '2020-7-22'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Jack Harkness'
    ),
    '2021-2-2'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2020-1-5'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2020-3-8'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2020-5-14'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    ),
    '2021-5-4'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Jack Harkness'
    ),
    '2021-2-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2019-12-21'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'William Thatcher'
    ),
    '2020-8-10'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2021-4-7'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    ),
    '2019-9-29'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Jack Harkness'
    ),
    '2020-10-3'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Jack Harkness'
    ),
    '2020-11-4'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2019-1-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2019-5-15'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2020-2-27'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Maisy Smith'
    ),
    '2020-8-3'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'Stephanie Mendez'
    ),
    '2020-5-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        animals.name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        vets.name = 'William Thatcher'
    ),
    '2021-1-11'
  );