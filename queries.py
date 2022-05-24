GET_ANIMAL_DATA_BY_ID = """
     SELECT
         animals_final.id,
         age_upon_outcome,
         animal_id,
         animals_final.name,
         date_of_birth,
         outcome_month,
         outcome_year,
         animal_type.name as 'type_id',
         animal_breed.name as 'breed_id',
         animal_color1.name as 'color1',
         animal_color2.name as 'color2',
         outcome_subtype.name as 'outcome_subtype',
         outcome_type.name as 'outcome_type'
     FROM animals_final
     LEFT JOIN animal_type
         ON animal_type.id = animals_final.type_id
     LEFT JOIN animal_breed
         ON animal_breed.id = animals_final.breed_id
     LEFT JOIN animal_color as animal_color1
         ON animal_color1.id = animals_final.color1_id
     LEFT JOIN animal_color as animal_color2
         ON animal_color2.id = animals_final.color2_id
     LEFT JOIN outcome_subtype
         ON outcome_subtype.id = animals_final.outcome_subtype_id
     LEFT JOIN outcome_type
         ON outcome_type.id = animals_final.outcome_type_id             
    WHERE animals_final.animal_id = :1
"""
