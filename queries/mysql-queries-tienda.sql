SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio AS EUR, TRUNCATE(precio * 1.22, 2) AS USD FROM producto;
SELECT nombre AS "nom de producte", precio AS euros, TRUNCATE(precio * 1.22, 2) AS dolars FROM producto;
SELECT UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT nombre, UPPER(LEFT(nombre, 2)) AS iniciales FROM producto;
SELECT nombre, ROUND(precio) AS precio FROM producto;
SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;
SELECT f.codigo FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante;
SELECT f.codigo FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante GROUP BY f.codigo;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
SELECT p.nombre, p.precio, f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre AS producto, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY fabricante ASC;
SELECT p.codigo, p.nombre, f.codigo, f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY precio ASC LIMIT 1;
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY precio DESC LIMIT 1;
SELECT p.nombre, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre ="Crucial" AND p.precio > 200;
SELECT p.nombre, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre ="Asus" OR f.nombre ="Hewlett-Packard" OR f.nombre ="Seagate";
SELECT p.nombre, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN("Asus", "Hewlett-Packard", "Seagate");
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%e";
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%w%";
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE precio >= 180 ORDER BY precio DESC, fabricante ASC;
SELECT f.nombre AS fabricante, f.codigo FROM fabricante f JOIN producto p ON p.codigo_fabricante = f.codigo GROUP BY f.nombre;
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo;
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante f LEFT JOIN producto p ON p.codigo_fabricante = f.codigo WHERE p.codigo is NULL;
SELECT f.nombre AS fabricante, p.nombre AS producto FROM fabricante f, producto p WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo";
SELECT p.nombre, f.nombre fabricante, p.precio FROM fabricante f,  producto p WHERE f.codigo =  p.codigo_fabricante AND p.precio = (SELECT max(p.precio) FROM fabricante f,  producto p WHERE f.nombre = "Lenovo" );
SELECT p.nombre AS producto, f.nombre AS fabricante, MAX(p.precio) AS precio_mas_alto FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";
SELECT p.nombre AS producto, f.nombre AS fabricante, MIN(p.precio) AS "precio mas alto" FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Hewlett-Packard";
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio > (SELECT MAX(p.precio) FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo AND f.nombre = ???Lenovo???);
SELECT * FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio > (SELECT AVG(p.precio) FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo AND f.nombre = ???Asus???);