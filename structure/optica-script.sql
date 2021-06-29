-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`direcciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`direcciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NULL,
  `puerta` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `cod_postal` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` INT NULL,
  `telefono` VARCHAR(15) NULL,
  `fax` VARCHAR(45) NULL,
  `nif` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_proveedores_direcciones_idx` (`direccion` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_direcciones`
    FOREIGN KEY (`direccion`)
    REFERENCES `optica`.`direcciones` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marcas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proveedor` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_proveedor_nombre_idx` (`proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_nombre`
    FOREIGN KEY (`proveedor`)
    REFERENCES `optica`.`proveedores` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NULL,
  `marca` INT NULL,
  `tipo_montura` INT NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_gafas_marcas_idx` (`marca` ASC) VISIBLE,
  INDEX `fk_gafas_tipos_montura_idx` (`tipo_montura` ASC) VISIBLE,
  UNIQUE INDEX `modelo_UNIQUE` (`modelo` ASC) VISIBLE,
  CONSTRAINT `fk_gafas_marca`
    FOREIGN KEY (`marca`)
    REFERENCES `optica`.`marcas` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_gafas_tipos_montura`
    FOREIGN KEY (`tipo_montura`)
    REFERENCES `optica`.`tipos_montura` (`id`)
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
  `direccion` INT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(45) NULL,
  `registro_fecha` TIMESTAMP NOT NULL,
  `recomendado` INT NULL,
  `clientescol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_clientes_idx` (`recomendado` ASC) VISIBLE,
  INDEX `fk_clientes_direcciones_idx` (`direccion` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_clientes`
    FOREIGN KEY (`recomendado`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_direcciones`
    FOREIGN KEY (`direccion`)
    REFERENCES `optica`.`direcciones` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empleado` INT NULL,
  `cliente` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ventas_empleados_idx` (`empleado` ASC) VISIBLE,
  INDEX `fk_ventas_clientes_idx` (`cliente` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_empleados`
    FOREIGN KEY (`empleado`)
    REFERENCES `optica`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_clientes`
    FOREIGN KEY (`cliente`)
    REFERENCES `optica`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`detalle_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`detalle_ventas` (
  `ventas_id` INT NOT NULL,
  `gafas_id` INT NOT NULL,
  PRIMARY KEY (`ventas_id`, `gafas_id`),
  INDEX `fk_ventas_has_gafas_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  INDEX `fk_ventas_has_gafas_ventas1_idx` (`ventas_id` ASC) VISIBLE,
  CONSTRAINT `fk_ventas_has_gafas_ventas1`
    FOREIGN KEY (`ventas_id`)
    REFERENCES `optica`.`ventas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_has_gafas_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`vidrios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`vidrios` (
  `id` INT NOT NULL,
  `grad_der` FLOAT NULL,
  `grad_izq` FLOAT NULL,
  `color_der` VARCHAR(25) NULL,
  `color_izq` VARCHAR(25) NULL,
  `gafas_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vidrios_gafas1_idx` (`gafas_id` ASC) VISIBLE,
  CONSTRAINT `fk_vidrios_gafas1`
    FOREIGN KEY (`gafas_id`)
    REFERENCES `optica`.`gafas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `optica` ;

-- -----------------------------------------------------
-- Placeholder table for view `optica`.`view1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`view1` (`id` INT);

-- -----------------------------------------------------
-- View `optica`.`view1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `optica`.`view1`;
USE `optica`;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
