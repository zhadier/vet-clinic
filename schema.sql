/* Database schema to keep the structure of entire database. */
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

-- Milestone-2
ALTER TABLE
    animals
ADD
    COLUMN species VARCHAR;

-- Milestone-3
CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT
);

CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100)
);

ALTER TABLE
    animals
DROP 
    COLUMN species,
ADD
    COLUMN species_id INT references species(id),
ADD
    COLUMN owner_id INT references owners(id);
