SELECT
    a.*
    , c.concept_name
    , c.standard_concept
    , c.invalid_reason
    , c.concept_code
    , c.domain_id
    , c.vocabulary_id
    , c.concept_class_id
FROM (
         -- Find the UNION & INTERSECTION OF THESE CONCEPT SETS
         SELECT
             COALESCE(a.concept_id, b.concept_id) concept_id
              , CASE WHEN a.concept_id IS NOT NULL AND b.concept_id IS NULL THEN 1 ELSE 0 END concept_in_1_only
              , CASE WHEN a.concept_id IS NULL AND b.concept_id IS NOT NULL THEN 1 ELSE 0 END concept_in_2_only
              , CASE WHEN a.concept_id IS NOT NULL AND b.concept_id IS NOT NULL THEN 1 ELSE 0 END concept_in_both_1_and_2
         FROM (@cs1_expression) a
                  FULL OUTER JOIN (@cs2_expression) b ON a.concept_id = b.concept_id
     ) a
INNER JOIN @vocabulary_database_schema.concept c ON a.concept_id = c.concept_id
