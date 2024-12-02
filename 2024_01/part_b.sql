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
, counted_locs AS (
    SELECT 
        loc2 AS loc
        , COUNT(1) AS count
    FROM split_locs
    GROUP BY loc2
)
SELECT
    SUM(s.loc1*COALESCE(c.count, 0)) AS result
FROM split_locs s
LEFT JOIN counted_locs c ON s.loc1 = c.loc