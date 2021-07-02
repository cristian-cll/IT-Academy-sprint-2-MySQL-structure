DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;

-- -----------------------------------------------------
-- Table `optica`.`tipos_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`tipos_montura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(45) NOT NULL,
  `color` VARCHAR(25) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NULL,
  `fax` VARCHAR(15) NULL,
  `nif` VARCHAR(11) NOT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` INT NULL,
  `piso` VARCHAR(5) NULL,
  `puerta` VARCHAR(5) NULL,
  `ciudad` VARCHAR(45) NULL,
  `cod_postal` VARCHAR(10) NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `grad_der` FLOAT NULL,
  `grad_izq` FLOAT NULL,
  `color_der` VARCHAR(45) NULL,
  `color_izq` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `tipos_montura_id` INT NOT NULL,
  `proveedores_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `modelo_UNIQUE` (`modelo` ASC) VISIBLE,
  INDEX `fk_gafas_tipos_montura1_idx` (`tipos_montura_id` ASC) VISIBLE,
  INDEX `fk_gafas_proveedores1_idx` (`proveedores_id` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_tipos_montura1`
    FOREIGN KEY (`tipos_montura_id`)
    REFERENCES `optica`.`tipos_montura` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gafas_proveedores1`
    FOREIGN KEY (`proveedores_id`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NULL,
  `registro_fecha` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `recomendado` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_clientes_idx` (`recomendado` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes`
    FOREIGN KEY (`recomendado`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `clientes_id` INT NOT NULL,
  `empleados_id` INT NOT NULL,
  `gafas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  INDEX `fk_pedidos_empleados1_idx` (`empleados_id` ASC) VISIBLE,
  INDEX `fk_pedidos_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_empleados1`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `optica`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Data for table `optica`.`tipos_montura`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`tipos_montura` (`id`, `nombre_tipo`, `color`) VALUES (DEFAULT, 'pasta', 'negro');
INSERT INTO `optica`.`tipos_montura` (`id`, `nombre_tipo`, `color`) VALUES (DEFAULT, 'clasica', 'gris');

COMMIT;


-- -----------------------------------------------------
-- Data for table `optica`.`proveedores`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`proveedores` (`id`, `nombre`, `telefono`, `fax`, `nif`, `calle`, `numero`, `piso`, `puerta`, `ciudad`, `cod_postal`, `pais`) VALUES (DEFAULT, 'Optica Andorrana', '956568978', '956568979', '25368855X', 'Av. Meritxell', 41, '1', '1', 'Andorra', '98988', 'Andorra');
INSERT INTO `optica`.`proveedores` (`id`, `nombre`, `telefono`, `fax`, `nif`, `calle`, `numero`, `piso`, `puerta`, `ciudad`, `cod_postal`, `pais`) VALUES (DEFAULT, 'Vista cansada SL', '956568980', '956568981', '87877415F', 'Ejemplo', 123, '2', '5', 'Valencia', '15454', 'España');

COMMIT;


-- -----------------------------------------------------
-- Data for table `optica`.`gafas`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`gafas` (`id`, `marca`, `modelo`, `grad_der`, `grad_izq`, `color_der`, `color_izq`, `precio`, `tipos_montura_id`, `proveedores_id`) VALUES (DEFAULT, 'Rayban', 'Aviator', 0.5, 0.5, 'verde', 'verde', 120, 1, 1);
INSERT INTO `optica`.`gafas` (`id`, `marca`, `modelo`, `grad_der`, `grad_izq`, `color_der`, `color_izq`, `precio`, `tipos_montura_id`, `proveedores_id`) VALUES (DEFAULT, 'Police', 'classic', 0, 0, 'gris', 'gris', 140, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `optica`.`empleados`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`empleados` (`id`, `nombre`) VALUES (DEFAULT, 'Juan');
INSERT INTO `optica`.`empleados` (`id`, `nombre`) VALUES (DEFAULT, 'Pedro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `optica`.`clientes`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`clientes` (`id`, `nombre`, `direccion`, `telefono`, `email`, `registro_fecha`, `recomendado`) VALUES (DEFAULT, 'Laura', 'Sepulveda Barcelona', '623521258', 'laura@gmail.com', DEFAULT, NULL);
INSERT INTO `optica`.`clientes` (`id`, `nombre`, `direccion`, `telefono`, `email`, `registro_fecha`, `recomendado`) VALUES (DEFAULT, 'Cristian', 'Paseo de la Castellana Madrid', '658599844', 'cristian@gmail.com', DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `optica`.`pedidos`
-- -----------------------------------------------------
START TRANSACTION;
USE `optica`;
INSERT INTO `optica`.`pedidos` (`id`, `fecha`, `clientes_id`, `empleados_id`, `gafas_id`) VALUES (DEFAULT, '2021-06-28', 1, 1, 1);
INSERT INTO `optica`.`pedidos` (`id`, `fecha`, `clientes_id`, `empleados_id`, `gafas_id`) VALUES (DEFAULT, '2021-06-24', 2, 2, 1);
INSERT INTO `optica`.`pedidos` (`id`, `fecha`, `clientes_id`, `empleados_id`, `gafas_id`) VALUES (DEFAULT, '2021-06-15', 1, 2, 2);
INSERT INTO `optica`.`pedidos` (`id`, `fecha`, `clientes_id`, `empleados_id`, `gafas_id`) VALUES (DEFAULT, '2021-06-05', 1, 1, 2);

COMMIT;


-- Llista el total de factures d'un client en un període determinat

USE optica;
SELECT c.nombre Cliente, c.direccion, COUNT(p.id) AS Pedidos, SUM(g.precio) AS "Precio total"
FROM pedidos p
INNER JOIN clientes c
ON p.clientes_id = c.id
INNER JOIN gafas g
ON p.gafas_id = g.id
WHERE p.clientes_id = 1 AND p.fecha between '2021-06-01' AND '2021-06-30';


-- Llista els diferents models d'ulleres que ha venut un empleat durant un any

USE optica;
SELECT g.marca, g.modelo, e.nombre AS empleado, p.fecha
FROM gafas g
INNER JOIN pedidos p
ON p.gafas_id = g.id
INNER JOIN empleados e
ON e.id = p.empleados_id
WHERE p.empleados_id = 1 AND p.fecha between '2020-01-01' AND '2021-12-31';


-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica

USE optica;
SELECT pr.nombre AS Proveedor, COUNT(g.id) AS Ventas
FROM pedidos p
INNER JOIN gafas g
ON p.gafas_id = g.id
INNER JOIN proveedores pr
ON g.proveedores_id = pr.id
GROUP BY pr.nombre;
