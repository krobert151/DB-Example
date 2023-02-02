--seleccionar la media de vuelos que hay cada dia de la semana coomo aeropuerto de salida

SELECT ciudad ,dia, avg(numval) 
FROM (
	SELECT ciudad, to_char(salida, 'TMDay') AS "dia", count(*) as"numval"
	FROM vuelo JOIN aeropuerto on(id_aeropuerto=desde)
	GROUP BY ciudad, dia
	ORDER BY ciudad, dia
) datos
GROUP BY ciudad, dia;
