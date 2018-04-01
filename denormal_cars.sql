DROP DATABASE IF EXISTS denormal_cars;
DROP USER IF EXISTS denormal_user;
CREATE USER denormal_user;
CREATE DATABASE denormal_cars;
\c denormal_cars;
\i scripts/denormal_data.sql;

\dS;
SELECT DISTINCT make_title
FROM car_models;

SELECT DISTINCT model_title
FROM car_models
WHERE make_code = 'VOLKS';

SELECT DISTINCT make_code, model_code, model_title, year
FROM car_models
WHERE make_code = 'LAM';

SELECT DISTINCT *
FROM car_models
WHERE year BETWEEN 2010 AND 2015;