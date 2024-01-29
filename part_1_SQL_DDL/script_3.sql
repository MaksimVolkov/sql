-- 5. Create table "employee_salary"
CREATE TABLE employee_salary
(
  id          SERIAL PRIMARY KEY,
  employee_id INT NOT NULL UNIQUE,
  salary_id   INT NOT NULL
);

-- 6. Fill the employee salary table with 40 rows:
DO $$
  DECLARE
    random_employee_ids INT[];
    random_salary_id    INT;

  BEGIN
    -- Getting 30 unique random id values from the employees table
    SELECT ARRAY(
      SELECT id FROM (
        SELECT id, row_number() OVER (
          ORDER BY RANDOM()
        ) as rnum FROM employees
      ) AS subquery ORDER BY rnum LIMIT 30
    )
    INTO random_employee_ids;

    random_employee_ids :=
        random_employee_ids || (SELECT ARRAY(SELECT generate_series(71, 99) ORDER BY random() LIMIT 10));

    FOR i IN 1..array_length(random_employee_ids, 1) LOOP
      -- Getting a random id value from the salary table
      SELECT id FROM salary ORDER BY RANDOM() LIMIT 1 INTO random_salary_id;

      -- Inserting data into employee_salary table given foreign keys
      INSERT INTO employee_salary (employee_id, salary_id)
      VALUES (random_employee_ids[i], random_salary_id);
    END LOOP;
END $$;