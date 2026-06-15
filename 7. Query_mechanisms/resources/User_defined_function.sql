-- creating sample UDF which concatenates two column values
CREATE OR REPLACE FUNCTION f_concat_ws(s1 VARCHAR, s2 VARCHAR)
RETURNS VARCHAR
STABLE
AS $$
SELECT CONCAT($1, concat('',$2))
$$ LANGUAGE sql

-- using UDF
SELECT f_concat_ws(firstname, lastname) from tickit.users;