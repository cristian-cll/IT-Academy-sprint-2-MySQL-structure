-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`channels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel_name` VARCHAR(45) NULL,
  `description` TEXT(255) NULL,
  `created_on` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `birth_date` DATE NULL,
  `gender` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `post_code` VARCHAR(45) NULL,
  `channels_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_channels1_idx` (`channels_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_channels1`
    FOREIGN KEY (`channels_id`)
    REFERENCES `mydb`.`channels` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`status_videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` TEXT(255) NULL,
  `size` INT NULL,
  `file_name` VARCHAR(20) NULL,
  `length` INT NULL,
  `thumbnail` BLOB NULL,
  `views` INT NULL,
  `status` INT NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_videos_status_videos_idx` (`status` ASC) VISIBLE,
  INDEX `fk_videos_users1_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_videos_status_videos`
    FOREIGN KEY (`status`)
    REFERENCES `mydb`.`status_videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_users1`
    FOREIGN KEY (`user`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`videos_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`videos_has_tags` (
  `tags_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  PRIMARY KEY (`tags_id`, `videos_id`),
  INDEX `fk_tags_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_tags_has_videos_tags1_idx` (`tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_tags_has_videos_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `mydb`.`tags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`posts_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`posts_videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`channels_has_subscribers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`channels_has_subscribers` (
  `channels_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`channels_id`, `users_id`),
  INDEX `fk_channels_has_users_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_channels_has_users_channels1_idx` (`channels_id` ASC) VISIBLE,
  CONSTRAINT `fk_channels_has_users_channels1`
    FOREIGN KEY (`channels_id`)
    REFERENCES `mydb`.`channels` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_channels_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status_playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`status_playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_name` VARCHAR(45) NULL,
  `create_on` DATE NULL,
  `status` INT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlists_status_playlists_idx` (`status` ASC) VISIBLE,
  INDEX `fk_playlists_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_status_playlists`
    FOREIGN KEY (`status`)
    REFERENCES `mydb`.`status_playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT(300) NULL,
  `create_on` DATE NULL,
  `user` INT NOT NULL,
  `videos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comments_users1_idx` (`user` ASC) VISIBLE,
  INDEX `fk_comments_videos1_idx` (`videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_comments_users1`
    FOREIGN KEY (`user`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users_likes_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users_likes_videos` (
  `users_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  `is_like` TINYINT NULL,
  PRIMARY KEY (`users_id`, `videos_id`),
  INDEX `fk_users_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_users_has_videos_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_videos_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users_likes_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users_likes_comments` (
  `users_id` INT NOT NULL,
  `comments_id` INT NOT NULL,
  `is_like` TINYTEXT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`users_id`, `comments_id`),
  INDEX `fk_users_has_comments_comments1_idx` (`comments_id` ASC) VISIBLE,
  INDEX `fk_users_has_comments_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_comments_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_comments_comments1`
    FOREIGN KEY (`comments_id`)
    REFERENCES `mydb`.`comments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`playlists_has_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`playlists_has_videos` (
  `videos_id` INT NOT NULL,
  `playlists_id` INT NOT NULL,
  PRIMARY KEY (`videos_id`, `playlists_id`),
  INDEX `fk_videos_has_playlists_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  INDEX `fk_videos_has_playlists_videos1_idx` (`videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_has_playlists_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `mydb`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_has_playlists_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `mydb`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
