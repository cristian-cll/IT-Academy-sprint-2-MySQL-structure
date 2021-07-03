DROP DATABASE IF EXISTS youtube;
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
  `email` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
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
  `views` INT NOT NULL DEFAULT 0,
  `status` ENUM("Public", "Hidden", "Private") NULL,
  `likes` INT NOT NULL DEFAULT 0,
  `dislikes` INT NOT NULL DEFAULT 0,
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
  `status` ENUM("Private", "Public") NOT NULL DEFAULT 'Public',
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



-- -----------------------------------------------------
-- Data for table `youtube`.`channels`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`channels` (`id`, `channel_name`, `description`, `created_on`) VALUES (DEFAULT, 'Rincón de Jose', 'Entertainment', NULL);
INSERT INTO `youtube`.`channels` (`id`, `channel_name`, `description`, `created_on`) VALUES (DEFAULT, 'Rincón de Laura', 'Fun', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`users` (`id`, `email`, `username`, `birth_date`, `gender`, `country`, `post_code`, `channels_id`) VALUES (DEFAULT, 'jose@gmail.com', 'jose_01', '1990-05-25', 'Male', 'Spain', '08008', 1);
INSERT INTO `youtube`.`users` (`id`, `email`, `username`, `birth_date`, `gender`, `country`, `post_code`, `channels_id`) VALUES (DEFAULT, 'laura@gmail.com', 'laura_01', '1992-04-28', 'Female', 'Spain', '09897', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`videos` (`id`, `title`, `description`, `size`, `file_name`, `length`, `thumbnail`, `views`, `status`, `likes`, `dislikes`, `user`) VALUES (DEFAULT, 'Monkey jumping', 'Monkey jumping at forest ', 4, 'monkey_jumping', 3, NULL, DEFAULT, NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `youtube`.`videos` (`id`, `title`, `description`, `size`, `file_name`, `length`, `thumbnail`, `views`, `status`, `likes`, `dislikes`, `user`) VALUES (DEFAULT, 'Cats smiling', 'Cats smiling and singing', 6, 'cats_smiling', 5, NULL, DEFAULT, NULL, DEFAULT, DEFAULT, 2);
INSERT INTO `youtube`.`videos` (`id`, `title`, `description`, `size`, `file_name`, `length`, `thumbnail`, `views`, `status`, `likes`, `dislikes`, `user`) VALUES (DEFAULT, 'Persevernace on Mars', 'NASA\'s perseverance', 10, 'perseverance_on_mars', 8, NULL, DEFAULT, NULL, DEFAULT, DEFAULT, 1);
INSERT INTO `youtube`.`videos` (`id`, `title`, `description`, `size`, `file_name`, `length`, `thumbnail`, `views`, `status`, `likes`, `dislikes`, `user`) VALUES (DEFAULT, 'Cats sleeping', 'Cats slepping on sofa', 2, 'cats_sleeping', 2, NULL, DEFAULT, NULL, DEFAULT, DEFAULT, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`tags`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`tags` (`id`, `tag_name`) VALUES (DEFAULT, 'animals');
INSERT INTO `youtube`.`tags` (`id`, `tag_name`) VALUES (DEFAULT, 'cats');
INSERT INTO `youtube`.`tags` (`id`, `tag_name`) VALUES (DEFAULT, 'space');

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`videos_has_tags`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`videos_has_tags` (`tags_id`, `videos_id`) VALUES (1, 1);
INSERT INTO `youtube`.`videos_has_tags` (`tags_id`, `videos_id`) VALUES (2, 2);
INSERT INTO `youtube`.`videos_has_tags` (`tags_id`, `videos_id`) VALUES (3, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`channels_has_subscribers`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`channels_has_subscribers` (`channels_id`, `users_id`) VALUES (1, 2);
INSERT INTO `youtube`.`channels_has_subscribers` (`channels_id`, `users_id`) VALUES (2, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`playlists`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`playlists` (`id`, `playlist_name`, `create_on`, `users_id`, `status`) VALUES (DEFAULT, 'Animales', NULL, 1, 'Public');
INSERT INTO `youtube`.`playlists` (`id`, `playlist_name`, `create_on`, `users_id`, `status`) VALUES (DEFAULT, 'Cats', NULL, 2, 'Public');

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`comments`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`comments` (`id`, `text`, `create_on`, `user`, `videos_id`) VALUES (DEFAULT, 'Wow! I like it', '2021-07-04', 2, 1);
INSERT INTO `youtube`.`comments` (`id`, `text`, `create_on`, `user`, `videos_id`) VALUES (DEFAULT, 'hahahah they are pretty', '2021-07-01', 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`users_likes_videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`users_likes_videos` (`users_id`, `videos_id`, `is_like`) VALUES (1, 2, 1);
INSERT INTO `youtube`.`users_likes_videos` (`users_id`, `videos_id`, `is_like`) VALUES (2, 1, 1);
INSERT INTO `youtube`.`users_likes_videos` (`users_id`, `videos_id`, `is_like`) VALUES (2, 3, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`users_likes_comments`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`users_likes_comments` (`users_id`, `comments_id`, `is_like`, `date`) VALUES (1, 1, '1', NULL);
INSERT INTO `youtube`.`users_likes_comments` (`users_id`, `comments_id`, `is_like`, `date`) VALUES (2, 2, '1', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `youtube`.`playlists_has_videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `youtube`;
INSERT INTO `youtube`.`playlists_has_videos` (`videos_id`, `playlists_id`) VALUES (1, 1);
INSERT INTO `youtube`.`playlists_has_videos` (`videos_id`, `playlists_id`) VALUES (2, 2);
INSERT INTO `youtube`.`playlists_has_videos` (`videos_id`, `playlists_id`) VALUES (4, 2);

COMMIT;



-- Proves

-- Mostra els videos de cada playlist i a qui pertany

USE youtube;
SELECT p.playlist_name, v.title video, u.username playlist_owner
FROM playlists p
INNER JOIN playlists_has_videos phv
ON phv.playlists_id = p.id 
INNER JOIN videos v
ON phv.videos_id = v.id
INNER JOIN users u
ON u.id = v.user;



-- Mostra el comentaris que existeixen, el video a qui estan assignats, el propietari del video i el text del comentari

USE youtube;
SELECT owner.username Owner_video, v.title Video, u.username Comment_from, c.text Comment
FROM comments c
INNER JOIN videos v
ON c.videos_id = v.id
INNER JOIN users u
ON u.id = c.user
INNER JOIN users owner
ON owner.id = v.id;
