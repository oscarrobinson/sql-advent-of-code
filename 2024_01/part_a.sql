WITH raw_file AS (
    SELECT * FROM read_csv('<INPUT_FILE>',
        columns = {
            'raw_row': 'VARCHAR'
        }
        , header = false
    )
)
, split_locs AS (
    SELECT
        (string_split(raw_row, ' ')[1])::INT AS loc1
        , (string_split(raw_row, ' ')[4])::INT AS loc2
    FROM raw_file
)
, ordered_locs AS (
    SELECT
        t1.loc AS loc1
        , t2.loc AS loc2
    FROM (SELECT loc1 AS loc FROM split_locs ORDER BY loc1 ASC) AS t1
    POSITIONAL JOIN (SELECT loc2 AS loc FROM split_locs ORDER BY loc2 ASC) AS t2
)
SELECT
    SUM(abs(loc1 - loc2)) AS result
FROM ordered_locs