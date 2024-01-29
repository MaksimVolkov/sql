-- 1. Create table "employees":
CREATE TABLE employees
(
  id            SERIAL PRIMARY KEY,
  employee_name VARCHAR(50) NOT NULL
);

-- 2. Fill the employee table with 70 rows.
DO
$$
  DECLARE
    employee_names VARCHAR[] := ARRAY [
      'Amanda Smith', 'John Johnson', 'Emily Miller', 'Michael Davis',
      'Sarah Taylor', 'Christopher White', 'Jessica Wilson', 'Ryan Brown',
      'Olivia Moore', 'Daniel Anderson', 'Sophia Garcia', 'Ethan Martinez',
      'Ava Robinson', 'Matthew Thomas', 'Isabella Jackson', 'Andrew Harris',
      'Emma Davis', 'James Smith', 'Mia Wilson', 'Nicholas Taylor',
      'Emily Anderson', 'Benjamin Johnson', 'Grace Garcia', 'Samuel Martin',
      'Abigail White', 'Christopher Robinson', 'Natalie Brown', 'Daniel Wilson',
      'Elizabeth Moore', 'William Thomas', 'Lily Anderson', 'Jackson Taylor',
      'Ava Harris', 'Ethan Jackson', 'Madison Wilson', 'Aiden Thomas',
      'Harper White', 'Jacob Robinson', 'Ella Taylor', 'Carter Smith',
      'Scarlett Garcia', 'Lucas Anderson', 'Addison Brown', 'Noah Wilson',
      'Zoey Moore', 'Landon Thomas', 'Chloe Smith', 'Jackson Martin',
      'Grace Davis', 'Logan Anderson', 'Victoria Johnson', 'Oliver Taylor',
      'Amelia Wilson', 'Mason Brown', 'Ella Moore', 'Carter White',
      'Aria Robinson', 'Liam Thomas', 'Zoe Harris', 'Lincoln Jackson',
      'Penelope Taylor', 'Wyatt Anderson', 'Aubrey Davis', 'Owen Wilson',
      'Brooklyn Moore', 'Samuel Thomas', 'Harper Smith', 'Leo Robinson',
      'Ava Taylor', 'Elijah White'
      ];

  BEGIN
    FOR i IN 1..ARRAY_LENGTH(employee_names, 1)
      LOOP
        INSERT INTO employees (employee_name) VALUES (employee_names[i]);
      END LOOP;
  END
$$;