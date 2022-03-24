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

-- Milestone-4
CREATE TABLE vets(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations(
    species_id INT,
    vet_id INT,
    FOREIGN KEY(species_id) references species(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(vet_id) references vets(id) ON DELETE SET NULL ON UPDATE CASCADE,
    PRIMARY KEY (species_id, vet_id)
);

CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date DATE,
    FOREIGN KEY(animal_id) references animals(id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY(vet_id) references vets(id) ON DELETE SET NULL ON UPDATE CASCADE
);


