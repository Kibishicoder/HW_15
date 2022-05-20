CREATE TABLE IF NOT EXISTS colors(
        id INTEGER PRIMARY KEY AUTOINCREMENT
        , color VARCHAR(50)
);

INSERT INTO colors(color)
SELECT DISTINCT * FROM (
    SELECT DISTINCT
        color1 AS color1
    FROM animals
    UNION ALL
    SELECT DISTINCT
        color2 AS color
    FROM animals
);

CREATE TABLE IF NOT EXISTS animals_colors(
    animals_id INTEGER
    , colors_id INTEGER
    , FOREIGN KEY (animals_id) REFERENCES animals("index")
    , FOREIGN KEY (colors_id) REFERENCES colors(id)
);

INSERT INTO animals_colors(animals_id, colors_id)
    SELECT DISTINCT
        animals."index", colors.id
    FROM animals
    JOIN colors
        ON colors.color = animals.color1
    UNION ALL
    SELECT DISTINCT animals."index", colors.id
    FROM animals
    JOIN colors ON colors.color = animals.color2;

CREATE TABLE IF NOT EXISTS animals_outcome (
    id INTEGER PRIMARY KEY AUTOINCREMENT
    , subtype VARCHAR(50)
    , "type" VARCHAR(50)
    , "month" INTEGER
    , "year" INTEGER
);

INSERT INTO animals_outcome(subtype, "type", "month", "year")
SELECT DISTINCT
    animals.outcome_subtype
    , animals.outcome_type
    , animals.outcome_month
    , animals.outcome_year
FROM animals;

CREATE TABLE IF NOT EXISTS animals_final (
    id INTEGER PRIMARY KEY AUTOINCREMENT
    , age_upon_outcome VARCHAR(50)
    , animal_id INTEGER
    , animal_type VARCHAR(50)
    , "name" VARCHAR(50)
    , breed VARCHAR(50)
    , date_of_birth VARCHAR(50)
    , outcome_id INTEGER
    , animal_color VARCHAR(50)
    , FOREIGN KEY (outcome_id) REFERENCES animals_outcome(id)
    , FOREIGN KEY (animal_color) REFERENCES animals_colors(colors_id)
);

INSERT INTO animals_colors(animals_id, colors_id)
SELECT DISTINCT
    animals_final.id, colors.id
FROM animals
JOIN colors
    ON colors.color = animals.color1
JOIN animals_final
    ON animals_final.animal_id = animals.animal_id
UNION ALL
SELECT DISTINCT animals_final.id, colors.id
FROM animals
JOIN colors ON colors.color = animals.color2
JOIN animals_final
    ON animals_final.animal_id = animals.animal_id;

INSERT INTO animals_final(age_upon_outcome, animal_id, animal_type, "name", breed,  date_of_birth)
SELECT
    animals.age_upon_outcome
    , animals.animal_id
    , animals.animal_type
    , animals.name
    , animals.breed
    , animals.date_of_birth
FROM animals
JOIN animals_outcome
    ON animals_outcome.subtype = animals.outcome_subtype
    AND animals_outcome."type" = animals.outcome_type
    AND animals_outcome."month" = animals.outcome_month
    AND animals_outcome."year" = animals.outcome_year;

SELECT
    animals.name, animals.age_upon_outcome, animals.animal_id, animals.date_of_birth, colors.color
FROM animals
LEFT JOIN colors
    ON animals.color1 = colors.color
    AND animals.color2 = colors.color

