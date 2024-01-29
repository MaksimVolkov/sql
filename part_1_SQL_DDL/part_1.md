# First part SQL_DDL.

## Task №1 "Table employees"
### Condition

1. Create table "employees":
   - id. serial,  primary key,
   - employee_name. Varchar(50), not null
2. Fill the employee table with 70 rows.

### Solutions
*To simplify this task, an array of names was prepared.
``` SQL
-- 1. Create table "employees":
CREATE TABLE employees(
  id            SERIAL PRIMARY KEY,
  employee_name VARCHAR(50) NOT NULL
);

-- 2. Fill the employee table with 70 rows.
DO $$
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
END $$;
```

## Task №2 "Table salary"
### Condition

3. Create table "salary":
   - id. Serial  primary key,
   - monthly_salary. Int, not null
   
4. Fill the salary table with 15 rows:

``` json
[ 
  1000, 1100, 1200, 1300, 1400,
  1500, 1600, 1700, 1800, 1900,
  2000, 2100, 2200, 2300, 2400,
  2500
]
```

### Solutions
*The original data array contains 16 elements, and not 15 as indicated in the condition. 
``` SQL
-- 3. Create table "salary"
CREATE TABLE salary(
  id              SERIAL PRIMARY KEY,
  monthly_salary  INT NOT NULL
);

-- 4. Fill the salary table with 15 rows:
DO $$
  DECLARE
    monthly_salary INT[] := ARRAY[
      1000, 1100, 1200, 1300, 1400,
      1500, 1600, 1700, 1800, 1900,
      2000, 2100, 2200, 2300, 2400,
      2500
    ];

  BEGIN
    FOR i IN 1..ARRAY_LENGTH(monthly_salary, 1) 
      LOOP
        INSERT INTO salary (monthly_salary) VALUES (monthly_salary[i]);
      END LOOP;
END $$;
```

## Task №3 "Table employee_salary"
### Condition

5. Create table "employee_salary":
    - id. Serial  primary key,
    - employee_id. Int, not null, unique
    - salary_id. Int, not null
   
6. Fill the employee salary table with 40 rows:
    - insert non-existent "employee_id" into 10 lines out of 40
```
ex.
| id  | employee_id | salary_id |
|-----|-------------|-----------|
| 1   | 3           | 7         |
| 2   | 1           | 4         |
| 3   | 5           | 9         |
| 4   | 40          | 13        |
| 5   | 23          | 4         |
| 6   | 11          | 2         |
| 7   | 52          | 10        |
| 8   | 15          | 13        |
| 9   | 26          | 4         |
| 10  | 16          | 1         |
| 11  | 33          | 7         |
| ... | ...         | ...       |
```

### Solutions

```SQL
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

    FOR i IN 1..array_length(random_employee_ids, 1)
      LOOP
        -- Getting a random id value from the salary table
        SELECT id FROM salary ORDER BY RANDOM() LIMIT 1 INTO random_salary_id;

        -- Inserting data into employee_salary table given foreign keys
        INSERT INTO employee_salary (employee_id, salary_id)
        VALUES (random_employee_ids[i], random_salary_id);
      END LOOP;
END $$;
```


## Task №4 "Table roles"
### Condition
7. Create table "roles":
    - id. Serial  primary key,
    - role_name. int, not null, unique
8. Change the role_name column type from int to varchar(30)
9. Fill the roles table with 20 rows:
``` 
  [
    'Junior Python developer', 'Middle Python developer', 'Senior Python developer',
    'Junior Java developer', 'Middle Java developer', 'Senior Java developer',
    'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer',
    'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer',
    'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer',
    'Middle Automation QA engineer', 'Senior Automation QA engineer'
  ]
```

### Solutions
``` SQL
-- 7. Create table "roles":
CREATE TABLE roles(
  id SERIAL PRIMARY KEY,
  role_name INT NOT NULL UNIQUE
);

-- 8. Change the role_name column type from int to varchar(30)
ALTER TABLE roles
ALTER COLUMN role_name TYPE varchar(30);

-- 9. Fill the roles table with 20 rows
DO $$
DECLARE
  role_name VARCHAR[] := ARRAY[
    'Junior Python developer', 'Middle Python developer', 'Senior Python developer',
    'Junior Java developer', 'Middle Java developer', 'Senior Java developer',
    'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer',
    'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer',
    'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer',
    'Middle Automation QA engineer', 'Senior Automation QA engineer'
  ];

BEGIN
  FOR i IN 1..ARRAY_LENGTH(role_name, 1) LOOP
    INSERT INTO roles (role_name) VALUES (role_name[i]);
  END LOOP;
END $$;
```


## Task №5 "Table roles_employee"
### Condition

10. Create table "roles_employee":
    - id. Serial  primary key,
    - employee_id. Int, not null, unique (foreign key to employees table, id field)
    - role_id. Int, not null (foreign key to roles table, id field)
11. Fill the roles_employee table with 40 rows:

```
ex.
| id  | employee_id | role_id |
|-----|-------------|---------|
| 1   | 7           | 2       |
| 2   | 20          | 4       |
| 3   | 3           | 9       |
| 4   | 5           | 13      |
| 5   | 23          | 4       |
| 6   | 11          | 2       |
| 7   | 10          | 9       |
| 8   | 22          | 13      |
| 9   | 21          | 3       |
| 10  | 34          | 4       |
| 11  | 6           | 7       |
| ... | ...         | ...     |
```

### Solutions
``` SQL
-- 10. Create table "roles_employee"
CREATE TABLE roles_employee(
  id SERIAL PRIMARY KEY,
  employee_id INT NOT NULL UNIQUE,
  role_id INT NOT NULL,
  FOREIGN KEY (employee_id)
    REFERENCES employees(id),
  FOREIGN KEY (role_id)
    REFERENCES role(id)
);

-- 11. Fill the roles_employee table with 40 rows:
DO $$
DECLARE
    random_employee_ids INT[];
    random_salary_id    INT;

BEGIN
    -- Selecting random employee ids
    SELECT ARRAY(
        SELECT id FROM (
            SELECT id, row_number() OVER (
                ORDER BY RANDOM()
            ) as rnum FROM employees
        ) AS subquery ORDER BY rnum LIMIT (SELECT COUNT(*) FROM employees)
    )
    INTO random_employee_ids;

    FOR i IN 1..array_length(random_employee_ids, 1) LOOP
        -- Getting a random id value from the salary table
        SELECT id FROM salary ORDER BY RANDOM() LIMIT 1
        INTO random_salary_id;

        -- Inserting data into employee_salary table given foreign keys
        INSERT INTO employee_salary (employee_id, salary_id)
        VALUES (random_employee_ids[i], random_salary_id);
    END LOOP;
END $$;
```