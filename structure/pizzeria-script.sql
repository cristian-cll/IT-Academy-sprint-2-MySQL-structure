DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_localidad` VARCHAR(45) NULL,
  `provincia` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_localidad_provincia_idx` (`provincia` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia`
    FOREIGN KEY (`provincia`)
    REFERENCES `pizzeria`.`provincias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `cod_postal` VARCHAR(45) NULL,
  `localidad` INT NULL,
  `telefono` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_localidad_idx` (`localidad` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_localidad`
    FOREIGN KEY (`localidad`)
    REFERENCES `pizzeria`.`localidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NULL,
  `cod_postal` VARCHAR(45) NULL,
  `localidad` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tiendas_localidades_idx` (`localidad` ASC) VISIBLE,
  CONSTRAINT `fk_tiendas_localidades`
    FOREIGN KEY (`localidad`)
    REFERENCES `pizzeria`.`localidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `nif` VARCHAR(11) NULL,
  `telefono` VARCHAR(15) NULL,
  `categoria` ENUM("Cocinero", "Repartidor") NULL,
  `tiendas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleados_tiendas1_idx` (`tiendas_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tiendas_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comandas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` TIMESTAMP NULL,
  `envio` TINYINT NULL,
  `precio_total` FLOAT NULL,
  `cliente` INT NULL,
  `empleados_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandas_clientes_idx` (`cliente` ASC) VISIBLE,
  INDEX `fk_comandas_empleados1_idx` (`empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`cliente`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comandas_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cat_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cat_pizzas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `categoria_pizzas` INT NULL,
  `tipo` ENUM("Pizza", "Hamburguesa", "Bebida") NULL,
  PRIMARY KEY (`id`),
  INDEX `pizzas_cat_pizzas_idx` (`categoria_pizzas` ASC) VISIBLE,
  CONSTRAINT `pizzas_cat_pizzas`
    FOREIGN KEY (`categoria_pizzas`)
    REFERENCES `pizzeria`.`cat_pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`detalle_comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`detalle_comanda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cantidad` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `producto` INT NULL,
  `comanda` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_detalle_comanda_productos_idx` (`producto` ASC) VISIBLE,
  INDEX `fk_detalle_comanda_comanda_idx` (`comanda` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_comanda_pizzas`
    FOREIGN KEY (`producto`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_comanda_comanda`
    FOREIGN KEY (`comanda`)
    REFERENCES `pizzeria`.`comandas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`envios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empleados_id` INT NOT NULL,
  `comandas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_envios_empleados1_idx` (`empleados_id` ASC) VISIBLE,
  INDEX `fk_envios_comandas1_idx` (`comandas_id` ASC) VISIBLE,
  CONSTRAINT `fk_envios_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `pizzeria`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_envios_comandas1`
    FOREIGN KEY (`comandas_id`)
    REFERENCES `pizzeria`.`comandas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`provincias`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Barcelona');
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Madrid');
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Valencia');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`localidades`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'Hospitalet', 1);
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'Manresa', 1);
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'Alcalá de Henares', 2);
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'El Escorial', 2);
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'Turia', 3);
INSERT INTO `pizzeria`.`localidades` (`id`, `nombre_localidad`, `provincia`) VALUES (DEFAULT, 'Alfafar', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`clientes`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`clientes` (`id`, `nombre`, `apellido1`, `apellido2`, `direccion`, `cod_postal`, `localidad`, `telefono`) VALUES (DEFAULT, 'Pepito', 'Roman', 'Cortés', 'poligono 2', '08008', 1, '16546587');
INSERT INTO `pizzeria`.`clientes` (`id`, `nombre`, `apellido1`, `apellido2`, `direccion`, `cod_postal`, `localidad`, `telefono`) VALUES (DEFAULT, 'Jaimito', 'Pérez', 'García', 'poligono 3', '78449', 4, '98798487');
INSERT INTO `pizzeria`.`clientes` (`id`, `nombre`, `apellido1`, `apellido2`, `direccion`, `cod_postal`, `localidad`, `telefono`) VALUES (DEFAULT, 'Mireia', 'Salvador', 'Moreno', 'poligono 4', '89778', 5, '89857897');
INSERT INTO `pizzeria`.`clientes` (`id`, `nombre`, `apellido1`, `apellido2`, `direccion`, `cod_postal`, `localidad`, `telefono`) VALUES (DEFAULT, 'Flugencio', 'Puyol', 'Guell', 'poligono 5', '08010', 2, '59549847');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`tiendas`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`tiendas` (`id`, `direccion`, `cod_postal`, `localidad`) VALUES (DEFAULT, 'Balmes 123', '08008', 1);
INSERT INTO `pizzeria`.`tiendas` (`id`, `direccion`, `cod_postal`, `localidad`) VALUES (DEFAULT, 'ejemplo 123', '45885', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`empleados`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`empleados` (`id`, `nombre`, `apellido1`, `apellido2`, `nif`, `telefono`, `categoria`, `tiendas_id`) VALUES (DEFAULT, 'Juan', 'García', 'García', '45856625X', '122256556', 'Repartidor', 1);
INSERT INTO `pizzeria`.`empleados` (`id`, `nombre`, `apellido1`, `apellido2`, `nif`, `telefono`, `categoria`, `tiendas_id`) VALUES (DEFAULT, 'Laura', 'Jímenez', 'Valverde', '45848748F', '121458487', 'Cocinero', 1);
INSERT INTO `pizzeria`.`empleados` (`id`, `nombre`, `apellido1`, `apellido2`, `nif`, `telefono`, `categoria`, `tiendas_id`) VALUES (DEFAULT, 'Claudia', 'Fernández', 'Gutierrez', '54874877D', '487498798', 'Repartidor', 2);
INSERT INTO `pizzeria`.`empleados` (`id`, `nombre`, `apellido1`, `apellido2`, `nif`, `telefono`, `categoria`, `tiendas_id`) VALUES (DEFAULT, 'Ramón', 'Valiente', 'Herrero', '79879494G', '448749847', 'Cocinero', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`comandas`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`comandas` (`id`, `fecha`, `envio`, `precio_total`, `cliente`, `empleados_id`) VALUES (DEFAULT, '2021-06-25', 1, NULL, 1, 1);
INSERT INTO `pizzeria`.`comandas` (`id`, `fecha`, `envio`, `precio_total`, `cliente`, `empleados_id`) VALUES (DEFAULT, '2021-06-30', 0, NULL, 2, 2);
INSERT INTO `pizzeria`.`comandas` (`id`, `fecha`, `envio`, `precio_total`, `cliente`, `empleados_id`) VALUES (DEFAULT, '2021-06-12', 0, NULL, 2, 2);
INSERT INTO `pizzeria`.`comandas` (`id`, `fecha`, `envio`, `precio_total`, `cliente`, `empleados_id`) VALUES (DEFAULT, '2021-05-28', 0, NULL, 3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`cat_pizzas`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`cat_pizzas` (`id`, `nombre`) VALUES (DEFAULT, 'Vegana');
INSERT INTO `pizzeria`.`cat_pizzas` (`id`, `nombre`) VALUES (DEFAULT, 'Vegetariana');
INSERT INTO `pizzeria`.`cat_pizzas` (`id`, `nombre`) VALUES (DEFAULT, 'Barbacoa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`productos`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'Popeye', 'espinacas y manzana', 'http://wdsw.com/ass.jpg', 8.75, 2, 'Pizza');
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'Delicia', 'pizza sin nada animal', 'http://wdsw.com/ass.jpg', 6.80, 1, 'Pizza');
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'BigBoy', 'Hamburguesa Sheldon', 'http://wdsw.com/ass.jpg', 8.60, NULL, 'Hamburguesa');
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'Whopper', 'Idéntica a BKING', 'http://wdsw.com/ass.jpg', 9.20, NULL, 'Hamburguesa');
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'Coca-Cola', 'Bebida refrescante', 'http://wdsw.com/ass.jpg', 2.50, NULL, 'Bebida');
INSERT INTO `pizzeria`.`productos` (`id`, `nombre`, `descripcion`, `imagen`, `precio`, `categoria_pizzas`, `tipo`) VALUES (DEFAULT, 'Fanta', 'Bebida refrecsante', 'http://wdsw.com/ass.jpg', 2.50, NULL, 'Bebida');

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`detalle_comanda`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '2', NULL, 1, 1);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '3', NULL, 2, 1);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '4', NULL, 3, 1);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '1', NULL, 4, 1);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '2', NULL, 5, 2);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '3', NULL, 2, 2);
INSERT INTO `pizzeria`.`detalle_comanda` (`id`, `cantidad`, `precio`, `producto`, `comanda`) VALUES (DEFAULT, '4', NULL, 6, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pizzeria`.`envios`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`envios` (`id`, `empleados_id`, `comandas_id`) VALUES (DEFAULT, 1, 1);

COMMIT;



-- Llista quants productes de categoria 'Begudas' s'han venut en una determinada localitat

USE pizzeria;
SELECT d.cantidad, p.nombre Producto, p.tipo, l.nombre_localidad Localidad
FROM detalle_comanda d
INNER JOIN productos p
ON d.producto = p.id
INNER JOIN comandas c
ON c.id = d.comanda
INNER JOIN empleados e
ON e.id = c.empleados_id
INNER JOIN tiendas t
ON t.id = e.tiendas_id
INNER JOIN localidades l
ON t.localidad = l.id
WHERE p.tipo = "Bebida" AND l.nombre_localidad = "Hospitalet";


-- Llista quantes comandes ha efectuat un determinat empleat

USE pizzeria;
SELECT e.nombre Empleado, COUNT(c.id) AS pedidos 
FROM comandas c
INNER JOIN empleados e
ON c.empleados_id = e.id
WHERE e.nombre = "Laura"