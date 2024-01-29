-- 7. Create table "roles":
CREATE TABLE roles
(
  id        SERIAL PRIMARY KEY,
  role_name INT NOT NULL UNIQUE
);

-- 8. Change the role_name column type from int to varchar(30)
ALTER TABLE roles
  ALTER COLUMN role_name TYPE varchar(30);

-- 9. Fill the roles table with 20 rows
DO
$$
  DECLARE
    role_name VARCHAR[] := ARRAY [
      'Junior Python developer', 'Middle Python developer', 'Senior Python developer',
      'Junior Java developer', 'Middle Java developer', 'Senior Java developer',
      'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer',
      'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer',
      'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer',
      'Middle Automation QA engineer', 'Senior Automation QA engineer'
      ];

  BEGIN
    FOR i IN 1..ARRAY_LENGTH(role_name, 1)
      LOOP
        INSERT INTO roles (role_name) VALUES (role_name[i]);
      END LOOP;
  END
$$;