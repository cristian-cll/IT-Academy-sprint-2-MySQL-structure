DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
-- -----------------------------------------------------
-- Table `youtube`.`channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channels` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `channel_name` VARCHAR(45) NULL,
  `description` TEXT(255) NULL,
  `created_on` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`users` (
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
    REFERENCES `youtube`.`channels` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` TEXT(255) NULL,
  `size` INT NULL,
  `file_name` VARCHAR(20) NULL,
  `length` INT NULL,
  `thumbnail` BLOB NULL,
  `views` INT NULL,
  `status` ENUM("Public", "Hidden", "Private") NULL,
  `user` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_videos_users1_idx` (`user` ASC) VISIBLE,
  CONSTRAINT `fk_videos_users1`
    FOREIGN KEY (`user`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videos_has_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videos_has_tags` (
  `tags_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  PRIMARY KEY (`tags_id`, `videos_id`),
  INDEX `fk_tags_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_tags_has_videos_tags1_idx` (`tags_id` ASC) VISIBLE,
  CONSTRAINT `fk_tags_has_videos_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `youtube`.`tags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`channels_has_subscribers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`channels_has_subscribers` (
  `channels_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`channels_id`, `users_id`),
  INDEX `fk_channels_has_users_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_channels_has_users_channels1_idx` (`channels_id` ASC) VISIBLE,
  CONSTRAINT `fk_channels_has_users_channels1`
    FOREIGN KEY (`channels_id`)
    REFERENCES `youtube`.`channels` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_channels_has_users_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `playlist_name` VARCHAR(45) NULL,
  `create_on` DATE NULL,
  `users_id` INT NOT NULL,
  `status` ENUM("Private", "Public") NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlists_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comments` (
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
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`users_likes_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`users_likes_videos` (
  `users_id` INT NOT NULL,
  `videos_id` INT NOT NULL,
  `is_like` TINYINT NULL,
  PRIMARY KEY (`users_id`, `videos_id`),
  INDEX `fk_users_has_videos_videos1_idx` (`videos_id` ASC) VISIBLE,
  INDEX `fk_users_has_videos_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_videos_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_videos_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`users_likes_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`users_likes_comments` (
  `users_id` INT NOT NULL,
  `comments_id` INT NOT NULL,
  `is_like` TINYTEXT NULL,
  `date` DATETIME NULL,
  PRIMARY KEY (`users_id`, `comments_id`),
  INDEX `fk_users_has_comments_comments1_idx` (`comments_id` ASC) VISIBLE,
  INDEX `fk_users_has_comments_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_comments_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `youtube`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_comments_comments1`
    FOREIGN KEY (`comments_id`)
    REFERENCES `youtube`.`comments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlists_has_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlists_has_videos` (
  `videos_id` INT NOT NULL,
  `playlists_id` INT NOT NULL,
  PRIMARY KEY (`videos_id`, `playlists_id`),
  INDEX `fk_videos_has_playlists_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  INDEX `fk_videos_has_playlists_videos1_idx` (`videos_id` ASC) VISIBLE,
  CONSTRAINT `fk_videos_has_playlists_videos1`
    FOREIGN KEY (`videos_id`)
    REFERENCES `youtube`.`videos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videos_has_playlists_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `youtube`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
