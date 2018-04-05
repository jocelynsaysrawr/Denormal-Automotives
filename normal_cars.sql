DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;
CREATE USER normal_user;
CREATE DATABASE normal_cars;
\c normal_cars;
\i scripts/denormal_data.sql;

CREATE TABLE make (
    make_id SERIAL PRIMARY KEY,
    make_code VARCHAR(25) NOT NULL,
    make_title VARCHAR(25) NOT NULL
);

INSERT INTO make (make_code, make_title) 
SELECT DISTINCT make_code, make_title
FROM car_models;

CREATE TABLE model (
    model_id SERIAL PRIMARY KEY,
    model_code VARCHAR(50) NOT NULL,
    model_title VARCHAR(50) NOT NULL,
    make_id INTEGER NOT NULL
);

INSERT INTO model (model_code, model_title, make_id) 
SELECT DISTINCT car_models.model_code, car_models.model_title, make.make_id
FROM make
INNER JOIN car_models 
ON car_models.make_code = make.make_code
AND car_models.make_title = make.make_title;

CREATE TABLE model_year (
    model_year_id SERIAL PRIMARY KEY,
    model_id INTEGER NOT NULL,
    year INTEGER NOT NULL
);

INSERT INTO model_year (model_id, year)
SELECT DISTINCT model.model_id, car_models.year
FROM model
INNER JOIN car_models
ON car_models.model_code = model.model_code
AND car_models.model_title = model.model_title;

SELECT make_title
FROM make;

SELECT model_title
FROM model
INNER JOIN make USING (make_id)
WHERE make_code = 'VOLKS';

SELECT make_code, model_code, model_title, year
FROM make
INNER JOIN model USING (make_id)
INNER JOIN model_year USING (model_id)
WHERE make_code = 'LAM';

SELECT make_code, make_title, model_code, model_title, year
FROM make
INNER JOIN model USING (make_id)
INNER JOIN model_year USING (model_id)
WHERE year BETWEEN 2010 AND 2015;

