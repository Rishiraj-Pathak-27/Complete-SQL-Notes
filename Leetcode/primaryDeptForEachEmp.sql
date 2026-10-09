-- 1789. Primary Department for Each Employee

-- Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.
-- Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
-- Return the result table in any order.

SELECT e.employee_id AS employee_id,
       e.department_id AS department_id
FROM Employee e
WHERE e.primary_flag = 'Y' OR
      e.employee_id IN (
        SELECT e1.employee_id
        FROM Employee e1
        GROUP BY e1.employee_id
        HAVING COUNT(*)=1
);