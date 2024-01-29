-- 3. Create table "salary"
CREATE TABLE salary
(
  id             SERIAL PRIMARY KEY,
  monthly_salary INT NOT NULL
);

-- 4. Fill the salary table with 15 rows:
DO
$$
  DECLARE
    monthly_salary INT[] := ARRAY [
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
  END
$$;