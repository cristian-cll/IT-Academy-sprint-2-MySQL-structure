-- Base de dades Tienda

-- Tenim les taules producto i fabricador, cadascuna amb els següents camps:
-- - producto (codigo, nombre, precio, codigo_fabricante)
-- - fabricante (codigo, nombre)
-- El camp 'codigo_fabricante' de l'entitat producto es relaciona amb el camp 'codi' de l'entitat fabricante.
-- Si us plau, efectua les siguentes consultes:


USE tienda;
-- 1.	Llista el nom de tots els productes que hi ha en la taula producto.

SELECT nombre
FROM producto;

-- 2.	Llista els noms i els preus de tots els productes de la taula producto.

SELECT nombre, precio
FROM producto;

-- 3.	Llista totes les columnes de la taula producto.

SELECT * 
FROM producto;

-- 4.	Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD).

SELECT nombre, precio AS EUR, 
TRUNCATE(precio * 1.22, 2) AS USD 
FROM producto;

-- 5.	Llista el nom dels productos, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dolars.

SELECT nombre AS "nom de producte", precio AS euros,
TRUNCATE(precio * 1.22, 2) AS dolars 
FROM producto;

-- 6.	Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a majúscula.

SELECT UPPER(nombre), precio
FROM producto;

-- 7.	Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a minúscula.

SELECT LOWER(nombre), precio
FROM producto;

-- 8.	Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.

SELECT nombre, UPPER(LEFT(nombre, 2)) AS iniciales
FROM producto;

-- 9.	Llista els noms i els preus de tots els productos de la taula producto, arrodonint el valor del preu.

SELECT nombre, ROUND(precio) AS precio
FROM producto;

-- 10.	Llista els noms i els preus de tots els productos de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.

SELECT nombre,
TRUNCATE(precio, 0) AS precio
FROM producto;

-- 11.	Llista el codi dels fabricants que tenen productos en la taula producto.

SELECT f.codigo 
FROM fabricante f, producto p 
WHERE f.codigo = p.codigo_fabricante;

-- 12.	Llista el codi dels fabricants que tenen productos en la taula producto, eliminant els codis que apareixen repetits.

SELECT f.codigo 
FROM fabricante f, producto p 
WHERE f.codigo = p.codigo_fabricante
GROUP BY f.codigo;


-- 13.	Llista els noms dels fabricants ordenats de manera ascendent.

SELECT nombre
FROM fabricante
ORDER BY nombre ASC;

-- 14.	Llista els noms dels fabricants ordenats de manera descendent.

SELECT nombre
FROM fabricante
ORDER BY nombre DESC;

-- 15.	Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent i en segon lloc pel preu de manera descendent.

SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- 16.	Retorna una llista amb les 5 primeres files de la taula fabricante.

SELECT * 
FROM fabricante 
LIMIT 5;

-- 17.	Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.

SELECT * 
FROM fabricante 
LIMIT 3,2;

-- 18.	Llista el nom i el preu del producto més barat. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY

SELECT nombre, precio 
FROM producto 
ORDER BY precio ASC 
LIMIT 1;
-- 19.	Llista el nom i el preu del producto més car. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.

SELECT nombre, precio 
FROM producto
ORDER BY precio DESC 
LIMIT 1;

-- 20.	Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.

SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

-- 21.	Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.

SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f
ON p.codigo_fabricante = f.codigo;

-- 22.	Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordeni el resultat pel nom del fabricador, per ordre alfabètic.

SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
ORDER BY fabricante ASC;

-- 23.	Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.

SELECT p.codigo, p.nombre, f.codigo, f.nombre 
FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo;

-- 24.	Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
ORDER BY precio ASC LIMIT 1;

-- 25.	Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo  
ORDER BY precio DESC LIMIT 1;

-- 26.	Retorna una llista de tots els productes del fabricador Lenovo.

SELECT p.nombre, f.nombre AS fabricante
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = "Lenovo";

-- 27.	Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€.

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre ="Crucial" AND p.precio > 200;

-- 28.	Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.

SELECT p.nombre, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre ="Asus" OR f.nombre ="Hewlett-Packard" OR f.nombre ="Seagate";

-- 29.	Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Utilitzant l'operador IN.

SELECT p.nombre, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre IN("Asus", "Hewlett-Packard", "Seagate");

-- 30.	Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre LIKE "%e";

-- 31.	Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre LIKE "%w%";

-- 32.	Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180€. Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent)

SELECT p.nombre, p.precio, f.nombre AS fabricante 
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE precio >= 180
ORDER BY precio DESC, fabricante ASC;


-- 33.	Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.

SELECT f.nombre AS fabricante, f.codigo 
FROM fabricante f 
JOIN producto p ON p.codigo_fabricante = f.codigo 
GROUP BY f.nombre;

-- 34.	Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.

SELECT f.nombre AS fabricante, p.nombre AS producto
FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo;

-- 35.	Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.

SELECT f.nombre AS fabricante, p.nombre AS producto
FROM fabricante f 
LEFT JOIN producto p ON p.codigo_fabricante = f.codigo 
WHERE p.codigo is NULL;

-- 36.	Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).

SELECT f.nombre AS fabricante, p.nombre AS producto
FROM fabricante f, producto p 
WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo";

-- 37.	Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricador Lenovo. (Sense utilitzar INNER JOIN).

SELECT p.nombre, f.nombre fabricante, p.precio 
FROM fabricante f,  producto p 
WHERE f.codigo =  p.codigo_fabricante AND p.precio = (
SELECT max(p.precio)
FROM fabricante f,  producto p 
WHERE f.nombre = "Lenovo");

-- 38.	Llista el nom del producte més car del fabricador Lenovo.

SELECT p.nombre AS producto, f.nombre AS fabricante, MAX(p.precio) AS precio_mas_alto
FROM producto p 
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = "Lenovo";

-- 39.	Llista el nom del producte més barat del fabricant Hewlett-Packard.

SELECT p.nombre AS producto, 
f.nombre AS fabricante, 
MIN(p.precio) AS "precio mas alto"
FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
WHERE f.nombre = "Hewlett-Packard";

-- 40.	Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricador Lenovo.

SELECT * FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
WHERE p.precio > (
SELECT MAX(p.precio) 
FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
AND f.nombre = “Lenovo”);

-- 41.	Llesta tots els productes del fabricador Asus que tenen un preu superior al preu mitjà de tots els seus productes. 

SELECT * FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
WHERE p.precio > (
SELECT AVG(p.precio) 
FROM producto p 
INNER JOIN fabricante f 
ON p.codigo_fabricante = f.codigo 
AND f.nombre = “Asus”);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Base de dades Universidad

-- Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:

USE universidad;

-- 1.	Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = "alumno"
ORDER BY apellido1, apellido2, nombre;

-- 2.	Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = "alumno" AND telefono is NULL;

-- 3.	Retorna el llistat dels alumnes que van néixer en 1999.

SELECT apellido1, apellido2, nombre, fecha_nacimiento
FROM persona
WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%";

-- 4.	Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.

SELECT apellido1, apellido2, nombre, fecha_nacimiento, tipo, nif
FROM persona
WHERE tipo = "profesor" AND nif LIKE "%K";

-- 5.	Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.

SELECT * 
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6.	Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departament
FROM persona p 
JOIN profesor prof
ON p.id = prof.id_profesor 
JOIN departamento d 
ON prof.id_departamento = d.id 
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7.	Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.

SELECT p.nombre, p.apellido1, p.nif, a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin
FROM persona p 
JOIN alumno_se_matricula_asignatura mat 
ON p.id = mat.id_alumno 
JOIN asignatura a 
ON mat.id_asignatura = a.id 
JOIN curso_escolar c 
ON c.id = a.curso 
WHERE p.nif = "26902806M";

-- 8.	Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

SELECT d.nombre AS departamento
FROM departamento d 
JOIN profesor prof 
ON d.id = prof.id_departamento 
JOIN persona p 
ON prof.id_profesor = p.id 
JOIN asignatura a 
ON p.id = a.id_profesor 
JOIN grado g 
ON g.id = a.id_grado 
WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)"
GROUP BY d.id;

-- 9.	Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

SELECT p.nombre, p.apellido1, c.anyo_inicio, c.anyo_fin
FROM alumno_se_matricula_asignatura mat 
JOIN persona p 
ON p.id = mat.id_alumno 
JOIN curso_escolar c
ON c.id = mat.id_curso_escolar 
WHERE mat.id_curso_escolar = 5
GROUP BY mat.id_alumno;


-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT d.nombre AS Departamento, p.apellido1, p.apellido2, p.nombre 
FROM departamento d 
RIGHT JOIN persona p 
ON d.id = p.id 
WHERE tipo = "profesor"
ORDER BY Departamento, apellido1, apellido2, p.nombre ASC;

-- 2. Retorna un llistat amb els professors que no estan associats a un departament.

SELECT d.nombre Departamento, p.nombre, p.apellido1, p.apellido2
FROM persona p 
LEFT JOIN profesor prof 
ON p.id = prof.id_profesor 
LEFT JOIN departamento d 
ON prof.id_profesor = d.id 
WHERE tipo = "profesor" AND d.nombre is NULL;

-- 3. Retorna un llistat amb els departaments que no tenen professors associats.

SELECT d.nombre Departamento
FROM departamento d 
LEFT JOIN profesor prof 
ON d.id = prof.id_departamento 
WHERE prof.id_departamento is NULL;

-- 4. Retorna un llistat amb els professors que no imparteixen cap assignatura.

SELECT p.nombre Profesor
FROM persona p
LEFT JOIN asignatura a 
ON p.id = a.id_profesor 
LEFT JOIN profesor prof
ON p.id = prof.id_profesor 
WHERE a.id_profesor is NULL AND p.tipo = "profesor"; 

-- 5. Retorna un llistat amb les assignatures que no tenen un professor assignat.

SELECT a.nombre Asignatura 
FROM asignatura a
LEFT JOIN profesor prof
ON a.id_profesor = prof.id_profesor  
WHERE a.id_profesor is NULL 
ORDER BY a.nombre; 


-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT DISTINCT d.nombre Departamento
FROM profesor prof 
RIGHT JOIN departamento d 
ON prof.id_departamento = d.id 
LEFT JOIN asignatura a
ON prof.id_profesor = a.id_profesor 
WHERE a.id_profesor is NULL;


-- Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.

SELECT count(*) "Total alumnos"
FROM persona
WHERE tipo = "alumno";

-- 2. Calcula quants alumnes van néixer en 1999.

SELECT count(*) 
FROM persona 
WHERE tipo = "alumno" 
AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament 
-- i una altra amb el nombre de professors que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.

SELECT d.nombre Departamento, 
COUNT(prof.id_profesor) AS Profesores 
FROM departamento d 
RIGHT JOIN profesor prof 
ON d.id = prof.id_departamento 
GROUP BY Departamento 
ORDER BY Profesores DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.

SELECT d.nombre, 
COUNT(p.id) AS Profesores
FROM persona p 
JOIN profesor prof 
ON p.id = prof.id_profesor 
RIGHT JOIN departamento d 
ON prof.id_departamento = d.id 
GROUP BY d.nombre 
ORDER BY Profesores DESC;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. 
-- El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT g.nombre Grado, 
COUNT(a.id_grado) AS Asignaturas 
FROM asignatura a
RIGHT JOIN grado g
ON a.id_grado = g.id 
GROUP BY Grado 
ORDER BY Asignaturas DESC;


-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

SELECT g.nombre Grado, 
COUNT(a.id_grado) AS Asignaturas 
FROM asignatura a
RIGHT JOIN grado g
ON a.id_grado = g.id 
GROUP BY Grado 
HAVING Asignaturas > 40;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
-- El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

SELECT g.nombre Grado, a.tipo "Tipo_Asig.", 
SUM(a.creditos) AS Créditos 
FROM grado g 
RIGHT JOIN asignatura a 
ON g.id = a.id_grado 
GROUP BY Grado, a.tipo
ORDER BY Créditos DESC;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
-- El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

SELECT c.anyo_inicio Año, 
COUNT(c.anyo_inicio) AS Matrículas
FROM  alumno_se_matricula_asignatura matr, curso_escolar c 
WHERE matr.id_curso_escolar = c.id 
GROUP BY anyo_inicio;

-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. 
-- El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, 
COUNT(a.id) AS Asignaturas 
FROM persona p 
LEFT JOIN profesor prof 
ON p.id = prof.id_profesor 
LEFT JOIN asignatura a 
ON prof.id_profesor = a.id_profesor 
WHERE p.tipo = "profesor"
GROUP BY p.id 
ORDER BY Asignaturas DESC;


-- 10. Retorna totes les dades de l'alumne més jove.

SELECT * 
FROM persona
WHERE tipo = "alumno"
ORDER BY fecha_nacimiento DESC
LIMIT 1;

-- 11.Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.

SELECT p.tipo, p.nombre, p.apellido1, p.apellido2, a.id Asignatura, d.nombre Departamento
FROM persona p 
JOIN profesor prof 
ON p.id = prof.id_profesor 
JOIN departamento d 
ON d.id = prof.id_departamento 
LEFT JOIN asignatura a 
ON prof.id_profesor = a.id_profesor 
WHERE a.id is NULL;