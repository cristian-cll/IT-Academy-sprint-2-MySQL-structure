SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" AND telefono is NULL;
SELECT apellido1, apellido2, nombre, fecha_nacimiento FROM persona WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%";
SELECT apellido1, apellido2, nombre, fecha_nacimiento, tipo, nif FROM persona WHERE tipo = "profesor" AND nif LIKE "%K";
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departament FROM persona p JOIN profesor prof ON p.id = prof.id_profesor JOIN departamento d ON prof.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT p.nombre, p.apellido1, p.nif, a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura mat ON p.id = mat.id_alumno JOIN asignatura a ON mat.id_asignatura = a.id JOIN curso_escolar c ON c.id = a.curso WHERE p.nif = "26902806M";
SELECT d.nombre AS departamento FROM departamento d JOIN profesor prof ON d.id = prof.id_departamento JOIN persona p ON prof.id_profesor = p.id JOIN asignatura a ON p.id = a.id_profesor JOIN grado g ON g.id = a.id_grado WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)" GROUP BY d.id;
SELECT p.nombre, p.apellido1, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura mat JOIN persona p ON p.id = mat.id_alumno JOIN curso_escolar c ON c.id = mat.id_curso_escolar WHERE mat.id_curso_escolar = 5 GROUP BY mat.id_alumno;

-- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

SELECT d.nombre AS Departamento, p.apellido1, p.apellido2, p.nombre FROM departamento d RIGHT JOIN persona p ON d.id = p.id WHERE tipo = "profesor" ORDER BY Departamento, apellido1, apellido2, p.nombre ASC;
SELECT d.nombre Departamento, p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN departamento d ON prof.id_profesor = d.id WHERE tipo = "profesor" AND d.nombre is NULL;
SELECT d.nombre Departamento FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento WHERE prof.id_departamento is NULL;
SELECT p.nombre Profesor FROM persona p LEFT JOIN asignatura a  ON p.id = a.id_profesor LEFT JOIN profesor prof ON p.id = prof.id_profesor WHERE a.id_profesor is NULL AND p.tipo = "profesor"; 
SELECT a.nombre Asignatura FROM asignatura a LEFT JOIN profesor prof ON a.id_profesor = prof.id_profesor WHERE a.id_profesor is NULL ORDER BY a.nombre; 
SELECT DISTINCT d.nombre Departamento FROM profesor prof RIGHT JOIN departamento d ON prof.id_departamento = d.id LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE a.id_profesor is NULL;

-- Consultes resum:

SELECT count(*) "Total alumnos" FROM persona WHERE tipo = "alumno";
SELECT count(*) FROM persona WHERE tipo = "alumno" AND YEAR(fecha_nacimiento) = 1999;
SELECT d.nombre Departamento, COUNT(prof.id_profesor) AS Profesores FROM departamento d RIGHT JOIN profesor prof ON d.id = prof.id_departamento GROUP BY Departamento ORDER BY Profesores DESC;
SELECT d.nombre, COUNT(p.id) AS Profesores FROM persona p JOIN profesor prof ON p.id = prof.id_profesor RIGHT JOIN departamento d ON prof.id_departamento = d.id GROUP BY d.nombre ORDER BY Profesores DESC;
SELECT g.nombre Grado, COUNT(a.id_grado) AS Asignaturas FROM asignatura a RIGHT JOIN grado g ON a.id_grado = g.id GROUP BY Grado ORDER BY Asignaturas DESC;
SELECT g.nombre Grado, COUNT(a.id_grado) AS Asignaturas FROM asignatura a RIGHT JOIN grado g ON a.id_grado = g.id GROUP BY Grado HAVING Asignaturas > 40;
SELECT g.nombre Grado, a.tipo "Tipo_Asig.", SUM(a.creditos) AS Créditos FROM grado g RIGHT JOIN asignatura a ON g.id = a.id_grado GROUP BY Grado, a.tipo ORDER BY Créditos DESC;
SELECT c.anyo_inicio Año, COUNT(c.anyo_inicio) AS Matrículas FROM  alumno_se_matricula_asignatura matr, curso_escolar c WHERE matr.id_curso_escolar = c.id GROUP BY anyo_inicio;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS Asignaturas FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY Asignaturas DESC;
SELECT * FROM persona WHERE tipo = "alumno" ORDER BY fecha_nacimiento DESC LIMIT 1;
SELECT p.tipo, p.nombre, p.apellido1, p.apellido2, a.id Asignatura, d.nombre Departamento FROM persona p JOIN profesor prof ON p.id = prof.id_profesor JOIN departamento d ON d.id = prof.id_departamento LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE a.id is NULL;