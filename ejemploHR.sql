--Seleccionar el numero de empleados que trabaja en casa pais

SELECT c.country_name, count(e.employee_id)
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
JOIN locations l ON (l.location_id=d.location_id)
JOIN countries c ON (c.country_id=l.country_id)
GROUP BY c.country_name;


--Seleccionar el numero de empleados que trabaja en casa pais
--siempre que el pais no esté ne la región de Europa

SELECT c.country_name, count(e.employee_id)
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
JOIN locations l ON (l.location_id=d.location_id)
JOIN countries c ON (c.country_id=l.country_id)
JOIN regions r ON (r.region_id=c.region_id)
WHERE r.region_name != 'Europe'
GROUP BY c.country_name;


--Seleccionar el numero de empleados que trabaja en casa pais
--siempre que el pais no esté ne la región de Europa, 
--siendo el numero de empleados mayor que 5

SELECT c.country_name, l.city ,count(e.employee_id)
FROM employees e JOIN departments d ON (e.department_id=d.department_id)
JOIN locations l ON (l.location_id=d.location_id)
JOIN countries c ON (c.country_id=l.country_id)
JOIN regions r ON (r.region_id=c.region_id)
WHERE r.region_name != 'Europe'
GROUP BY c.country_name,l.city 
HAVING count(e.employee_id) > 

--seleccionar el salario medio máximo agrupando por departamentos

SELECT  max(media)
FROM (
SELECT department_name , avg(salary) AS "media"
FROM employees JOIN	departments USING (department_id)
GROUP BY department_name 
) d;

--seleccionar el salario maximo del salario medio y su departamento 

SELECT department_name , avg(salary) AS "media"
FROM employees JOIN	departments USING (department_id)
GROUP BY department_name 
ORDER BY media DESC 
LIMIT 1

--Seleccionar los datos de aquellos empleados que cobren más que la media de salarios que los empleados del departramento de purchasing.

SELECT *
FROM employees  
WHERE salary >(
					SELECT avg(salary) 
					FROM employees JOIN departments 
						USING (department_id)
					WHERE department_name = 'Purchasing');
					
--seleccionar los empleados que tienen los mismos salarios que los empleados del departamento de Recursos humanos
				
SELECT *
FROM employees JOIN departments USING (department_id) 
WHERE salary IN(
					SELECT salary
					FROM employees JOIN departments 
						USING (department_id)
					WHERE department_name = 'Human Resources')
AND department_name != 'Human Resources';

--seleccionar aquellos departamentos donde TODOS los empleados se contrataron en el año 1994

SELECT DISTINCT department_name 
FROM employees JOIN departments USING (department_id) 
WHERE department_id NOT IN  (
	SELECT department_id 
	FROM employees JOIN departments USING (department_id) 
	WHERE EXTRACT(YEAR FROM hire_date) != 1994);
	
--02/02/2023

--Seleccinar los 5 empleados que mas cobran
SELECT first_name , last_name , salary 
FROM employees 
ORDER BY salary DESC 
LIMIT 5;

--Seleccionar los empleados que cobran los 5 salarios mas altos

SELECT first_name , last_name , salary
FROM employees 
WHERE salary IN (
	SELECT DISTINCT salary 
	FROM employees 
	ORDER BY salary DESC 
	LIMIT 5);

--Seleccionar los departamentos con los empleados con los 5 salarios mas altos.
--Debe paarecer el nombre del departento y el salaro más alto de dicho departmento.

SELECT department_name, max(salary)
FROM employees JOIN departments USING (department_id)
GROUP BY department_name
HAVING max(salary) IN (
		SELECT DISTINCT max(salary)
		FROM employees 
		GROUP BY department_id 
		ORDER BY max(salary) DESC 
		LIMIT 5
)
ORDER BY max(salary) DESC; 