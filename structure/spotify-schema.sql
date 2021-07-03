DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;

-- -----------------------------------------------------
-- Table `spotify`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `user_name` VARCHAR(45) NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM("Female", "Male") NULL,
  `country` VARCHAR(45) NULL,
  `post_code` VARCHAR(10) NULL,
  `role` ENUM("Free", "Premium") NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`credit_cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`credit_cards` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` BIGINT NULL,
  `month` INT NULL,
  `year` INT NULL,
  `cvv` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paypals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NULL,
  `renewal_date` DATETIME NULL,
  `pay_method` ENUM("CC", "PayPal") NULL,
  `credit_cards_id` INT NULL,
  `paypals_id` INT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_credit_cards1_idx` (`credit_cards_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_paypals1_idx` (`paypals_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_credit_cards1`
    FOREIGN KEY (`credit_cards_id`)
    REFERENCES `spotify`.`credit_cards` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_paypals1`
    FOREIGN KEY (`paypals_id`)
    REFERENCES `spotify`.`paypals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`payments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL,
  `price` VARCHAR(45) NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Payments_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payments_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `songs` INT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `status` ENUM("Active", "Deleted") NULL,
  `del_date` DATETIME NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Playlists_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_Playlists_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artists` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `image` BLOB NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `published_year` YEAR NULL,
  `cover_img` BLOB NULL,
  `artists_id` INT NOT NULL,
  PRIMARY KEY (`id`, `artists_id`),
  INDEX `fk_albums_artists1_idx` (`artists_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artists1`
    FOREIGN KEY (`artists_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`songs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `listenings` INT NULL,
  `albums_id` INT NOT NULL,
  PRIMARY KEY (`id`, `albums_id`),
  INDEX `fk_songs_albums1_idx` (`albums_id` ASC) VISIBLE,
  CONSTRAINT `fk_songs_albums1`
    FOREIGN KEY (`albums_id`)
    REFERENCES `spotify`.`albums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_follow_artists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_follow_artists` (
  `users_id` INT NOT NULL,
  `artists_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `artists_id`),
  INDEX `fk_users_has_artists_artists1_idx` (`artists_id` ASC) VISIBLE,
  INDEX `fk_users_has_artists_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_artists_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_artists_artists1`
    FOREIGN KEY (`artists_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artists_relationed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artists_relationed` (
  `artists_id` INT NOT NULL,
  `artists_id1` INT NOT NULL,
  PRIMARY KEY (`artists_id`, `artists_id1`),
  INDEX `fk_artists_has_artists_artists2_idx` (`artists_id1` ASC) VISIBLE,
  INDEX `fk_artists_has_artists_artists1_idx` (`artists_id` ASC) VISIBLE,
  CONSTRAINT `fk_artists_has_artists_artists1`
    FOREIGN KEY (`artists_id`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artists_has_artists_artists2`
    FOREIGN KEY (`artists_id1`)
    REFERENCES `spotify`.`artists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlists_has_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlists_has_songs` (
  `playlists_id` INT NOT NULL,
  `songs_id` INT NOT NULL,
  `songs_albums_id` INT NOT NULL,
  PRIMARY KEY (`playlists_id`, `songs_id`, `songs_albums_id`),
  INDEX `fk_playlists_has_songs_songs1_idx` (`songs_id` ASC, `songs_albums_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_songs_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_songs_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlists_has_songs_songs1`
    FOREIGN KEY (`songs_id` , `songs_albums_id`)
    REFERENCES `spotify`.`songs` (`id` , `albums_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_has_favourite_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_has_favourite_songs` (
  `users_id` INT NOT NULL,
  `songs_id` INT NOT NULL,
  `songs_albums_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `songs_id`, `songs_albums_id`),
  INDEX `fk_users_has_songs_songs1_idx` (`songs_id` ASC, `songs_albums_id` ASC) VISIBLE,
  INDEX `fk_users_has_songs_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_songs_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_songs_songs1`
    FOREIGN KEY (`songs_id` , `songs_albums_id`)
    REFERENCES `spotify`.`songs` (`id` , `albums_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_add_songs_playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_add_songs_playlist` (
  `users_id` INT NOT NULL,
  `songs_id` INT NOT NULL,
  `songs_albums_id` INT NOT NULL,
  `playlists_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `songs_id`, `songs_albums_id`, `playlists_id`),
  INDEX `fk_users_has_songs_songs2_idx` (`songs_id` ASC, `songs_albums_id` ASC) VISIBLE,
  INDEX `fk_users_has_songs_users2_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_users_add_songs_playlist_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_songs_users2`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_songs_songs2`
    FOREIGN KEY (`songs_id` , `songs_albums_id`)
    REFERENCES `spotify`.`songs` (`id` , `albums_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_add_songs_playlist_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `spotify`.`users`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users` (`id`, `email`, `password`, `user_name`, `birth_date`, `gender`, `country`, `post_code`, `role`) VALUES (DEFAULT, 'jose@gmail.com', '1234', 'jose_01', '1990-05-01', 'Male', 'Spain', '08008', 'Free');
INSERT INTO `spotify`.`users` (`id`, `email`, `password`, `user_name`, `birth_date`, `gender`, `country`, `post_code`, `role`) VALUES (DEFAULT, 'laura@gmail.com', '1234', 'laura_01', '1990-05-02', 'Female', 'Spain', '08017', 'Premium');
INSERT INTO `spotify`.`users` (`id`, `email`, `password`, `user_name`, `birth_date`, `gender`, `country`, `post_code`, `role`) VALUES (DEFAULT, 'juan@gmail.com', '1234', 'juan_01', '1985-08-25', 'Male', 'Spain', '08980', 'Premium');
INSERT INTO `spotify`.`users` (`id`, `email`, `password`, `user_name`, `birth_date`, `gender`, `country`, `post_code`, `role`) VALUES (DEFAULT, 'claudia@gmail.com', '1234', 'claudia_01', '1992-03-14', 'Female', 'Spain', '08987', 'Free');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`credit_cards`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`credit_cards` (`id`, `number`, `month`, `year`, `cvv`) VALUES (DEFAULT, 05999874848484, 06, 2025, 000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`paypals`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`paypals` (`id`, `user_name`) VALUES (DEFAULT, 'juan_01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`subscriptions`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`subscriptions` (`id`, `start_date`, `renewal_date`, `pay_method`, `credit_cards_id`, `paypals_id`, `users_id`) VALUES (DEFAULT, '2021-06-25', '2022-06-25', 'CC', 1, NULL, 2);
INSERT INTO `spotify`.`subscriptions` (`id`, `start_date`, `renewal_date`, `pay_method`, `credit_cards_id`, `paypals_id`, `users_id`) VALUES (DEFAULT, '2021-05-21', '2022-05-21', 'PayPal', NULL, 1, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`playlists`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`playlists` (`id`, `title`, `songs`, `created_at`, `status`, `del_date`, `users_id`) VALUES (DEFAULT, 'Rock', 6, NULL, 'Active', NULL, 1);
INSERT INTO `spotify`.`playlists` (`id`, `title`, `songs`, `created_at`, `status`, `del_date`, `users_id`) VALUES (DEFAULT, 'Classic', 2, NULL, 'Active', NULL, 1);
INSERT INTO `spotify`.`playlists` (`id`, `title`, `songs`, `created_at`, `status`, `del_date`, `users_id`) VALUES (DEFAULT, 'Jazz', 1, NULL, 'Deleted', NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`artists`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`artists` (`id`, `name`, `image`) VALUES (DEFAULT, 'Rolling Stones', NULL);
INSERT INTO `spotify`.`artists` (`id`, `name`, `image`) VALUES (DEFAULT, 'Bruce Springsteen', NULL);
INSERT INTO `spotify`.`artists` (`id`, `name`, `image`) VALUES (DEFAULT, 'Oasis', NULL);
INSERT INTO `spotify`.`artists` (`id`, `name`, `image`) VALUES (DEFAULT, 'Greeta Van Fleet', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`albums`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'Born in the USA', 1984, NULL, 2);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'Born to run', 1975, NULL, 2);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'The river', 1980, NULL, 2);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'The Rolling Stones', 1964, NULL, 1);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'Emotional Rescue', 1980, NULL, 1);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'Be Here Now', 1998, NULL, 3);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'Black Smoke Rising', 2017, NULL, 4);
INSERT INTO `spotify`.`albums` (`id`, `title`, `published_year`, `cover_img`, `artists_id`) VALUES (DEFAULT, 'From The Fires', 2017, NULL, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`songs`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`songs` (`id`, `name`, `listenings`, `albums_id`) VALUES (DEFAULT, 'The river', 18558078, 3);
INSERT INTO `spotify`.`songs` (`id`, `name`, `listenings`, `albums_id`) VALUES (DEFAULT, 'Watching Over', 87484, 8);
INSERT INTO `spotify`.`songs` (`id`, `name`, `listenings`, `albums_id`) VALUES (DEFAULT, 'Go Let It Out', 8595948, 6);
INSERT INTO `spotify`.`songs` (`id`, `name`, `listenings`, `albums_id`) VALUES (DEFAULT, 'Satisfaction', 65998748, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`artists_relationed`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`artists_relationed` (`artists_id`, `artists_id1`) VALUES (1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`playlists_has_songs`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `songs_albums_id`) VALUES (1, 1, 3);
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `songs_albums_id`) VALUES (1, 2, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`users_has_favourite_songs`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`, `songs_albums_id`) VALUES (1, 1, 3);
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`, `songs_albums_id`) VALUES (1, 2, 8);
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`, `songs_albums_id`) VALUES (1, 4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`users_add_songs_playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users_add_songs_playlist` (`users_id`, `songs_id`, `songs_albums_id`, `playlists_id`) VALUES (1, 1, 3, 1);

COMMIT;




-- Consultes de prova

-- Les playlists que tinguin un status "Active" d'un usuari

USE spotify;
SELECT p.title Playlist_name, u.user_name
FROM playlists p
INNER JOIN users u
ON p.users_id = u.id
WHERE u.user_name = "jose_01" AND p.status = "Active";

-- Les cançons favorites d'un usuari

USE spotify;
SELECT u.user_name, s.name Fav_Song, a.title Album
FROM songs s
INNER JOIN users_has_favourite_songs uhfv
ON uhfv.songs_id = s.id
INNER JOIN users u
ON u.id = uhfv.users_id
INNER JOIN albums a
ON a.id = s.albums_id
WHERE u.user_name = "jose_01";