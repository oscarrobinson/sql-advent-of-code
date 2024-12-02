# SQL Advent of Code

Solutions to Advent of Code problems in SQL... where possible...

## Setup

This repo uses DuckDB to run SQL.

```shell
brew install ducksb
```

## Run a solution

Put input in `input.txt`

Put test input in `test_input.txt`

Run test

```shell
 sed 's/<INPUT_FILE>/2024_01\/test_input.txt/g' 2024_01/part_a.sql | duckdb    
```

Run actual

```shell
 sed 's/<INPUT_FILE>/2024_01\/input.txt/g' 2024_01/part_a.sql | duckdb    
```