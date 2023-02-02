--Seleccionar la precipitación media del mes de Marzo
--agrupado por estacion

SELECT estacion , provincia ,round(avg(precipitacion_total),2) AS "precipitacion_total"
FROM climatologia 
WHERE EXTRACT(MONTH FROM fecha) = 3
GROUP BY estacion, provincia;

/*Seleccioar la media de temperatura media agrupando por provincia y mes.
 * Ordena los resultados por provincia ASC y cronoógicamente*/

SELECT provincia, to_char(fecha,'TMMonth'), round(avg(temperatura_media),2) AS "temperatura_media"
FROM climatologia 
GROUP BY provincia,to_char(fecha,'TMMonth'),EXTRACT (MONTH FROM fecha)
ORDER BY provincia, EXTRACT (MONTH FROM fecha);

