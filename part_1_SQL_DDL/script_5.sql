-- 10. Create table "roles_employee"
CREATE TABLE roles_employee
(
  id          SERIAL PRIMARY KEY,
  employee_id INT NOT NULL UNIQUE,
  role_id     INT NOT NULL,
  FOREIGN KEY (employee_id)
    REFERENCES employees (id),
  FOREIGN KEY (role_id)
    REFERENCES roles (id)
);

-- 11. Fill the roles_employee table with 40 rows:
DO $$
  DECLARE
    random_employee_ids INT[];
    random_role_id    INT;

  BEGIN
    -- Selecting random employee ids
    SELECT ARRAY(
      SELECT id FROM (
        SELECT id, row_number() OVER (
            ORDER BY RANDOM()
          ) as rnum FROM employees
        ) AS subquery ORDER BY rnum LIMIT (
            SELECT COUNT(*) FROM employees
          )
    )
    INTO random_employee_ids;

    FOR i IN 1..array_length(random_employee_ids, 1) LOOP
      -- Getting a random id value from the role table
      SELECT id FROM roles ORDER BY RANDOM() LIMIT 1 INTO random_role_id;

      -- Inserting data into roles_employee table given foreign keys
      INSERT INTO roles_employee (employee_id, role_id)
      VALUES (random_employee_ids[i], random_role_id);
    END LOOP;
  END $$;