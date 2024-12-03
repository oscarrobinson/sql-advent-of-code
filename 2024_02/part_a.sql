WITH raw_file AS (
    SELECT * FROM read_csv('<INPUT_FILE>',
        columns = {
            'raw_row': 'VARCHAR'
        }
        , header = false
    )
)
, reports AS (
    SELECT 
        ARRAY(SELECT UNNEST(string_split(raw_row, ' '))::INT) AS report
    FROM raw_file
)
, report_infos AS (
    SELECT 
        report
        , ARRAY(SELECT * FROM UNNEST(report) ORDER BY 1 ASC) AS report_asc
        , ARRAY(SELECT * FROM UNNEST(report) ORDER BY 1 DESC) AS report_desc
        , ARRAY(SELECT num-LAG(num) OVER() FROM (SELECT UNNEST(report) AS num)) AS diffs
    FROM reports
)
, safe_reports AS (
    SELECT
        report
    FROM report_infos
    WHERE (report = report_asc OR report = report_desc)
    AND LEN(ARRAY(
        SELECT num FROM (SELECT UNNEST(diffs) AS num)
        WHERE num IS NOT NULL AND (abs(num) < 1 OR abs(num) > 3)
    )) = 0
)
SELECT COUNT(1) AS results FROM safe_reports