-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

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
-- Table `pizzeria`.`tipos_trabajo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tipos_trabajo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_trabajo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
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
  `tipo_trabajo` INT NULL,
  `tienda` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_empleados_tiendas_idx` (`tienda` ASC) VISIBLE,
  INDEX `fk_empleados_tipos_trabajo_idx` (`tipo_trabajo` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tiendas`
    FOREIGN KEY (`tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_tipos_trabajo`
    FOREIGN KEY (`tipo_trabajo`)
    REFERENCES `pizzeria`.`tipos_trabajo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`envios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`envios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `repartidor` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_envios_empleados_idx` (`repartidor` ASC) VISIBLE,
  CONSTRAINT `fk_envios_empleados`
    FOREIGN KEY (`repartidor`)
    REFERENCES `pizzeria`.`empleados` (`id`)
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
  `tienda` INT NULL,
  `envios_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comandas_tiendas_idx` (`tienda` ASC) VISIBLE,
  INDEX `fk_comandas_clientes_idx` (`cliente` ASC) VISIBLE,
  INDEX `fk_comandas_envios1_idx` (`envios_id` ASC) VISIBLE,
  CONSTRAINT `fk_comandas_tiendas`
    FOREIGN KEY (`tienda`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comandas_clientes`
    FOREIGN KEY (`cliente`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comandas_envios1`
    FOREIGN KEY (`envios_id`)
    REFERENCES `pizzeria`.`envios` (`id`)
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
  `categoria` ENUM("Pizzas", "Hamburguesas", "Bebidas") NULL,
  PRIMARY KEY (`id`),
  INDEX `pizzas_cat_pizzas_idx` (`categoria_pizzas` ASC) VISIBLE,
  CONSTRAINT `pizzas_cat_pizzas`
    FOREIGN KEY (`categoria_pizzas`)
    REFERENCES `pizzeria`.`cat_pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`id`))
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
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_comanda_bebidas`
    FOREIGN KEY (`producto`)
    REFERENCES `pizzeria`.`bebidas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_comanda_hamburguesas`
    FOREIGN KEY (`producto`)
    REFERENCES `pizzeria`.`hamburguesas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `pizzeria`.`provincias`
-- -----------------------------------------------------
START TRANSACTION;
USE `pizzeria`;
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Barcelona');
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Madrid');
INSERT INTO `pizzeria`.`provincias` (`id`, `nombre_provincia`) VALUES (DEFAULT, 'Valencia');

COMMIT;

