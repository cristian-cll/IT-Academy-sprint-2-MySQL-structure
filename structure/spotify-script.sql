DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;


-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `birth_date` DATETIME NULL,
  `gender` ENUM("Female", "Male") NULL,
  `country` VARCHAR(45) NULL,
  `post_code` VARCHAR(10) NULL,
  `role` ENUM("Free", "Premium") NOT NULL DEFAULT 'Free',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paymentMethod` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `type` ENUM("CC", "PayPal") NOT NULL,
  `cc_number` VARCHAR(45) NULL,
  `cc_month` INT NULL,
  `cc_year` INT NULL,
  `cc_cvv` INT NULL,
  `pp_user_name` VARCHAR(45) NULL,
  INDEX `fk_paymentMethod_users1_idx` (`users_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_paymentMethod_users1`
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
  `order_num` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `price` FLOAT NULL,
  `paymentMethod_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `order_num_UNIQUE` (`order_num` ASC) VISIBLE,
  INDEX `fk_payments_paymentMethod1_idx` (`paymentMethod_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_paymentMethod1`
    FOREIGN KEY (`paymentMethod_id`)
    REFERENCES `spotify`.`paymentMethod` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATETIME NULL,
  `renewal_date` DATETIME NULL,
  `users_id` INT NOT NULL,
  `payments_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_users1_idx` (`users_id` ASC) VISIBLE,
  INDEX `fk_subscriptions_payments1_idx` (`payments_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subscriptions_payments1`
    FOREIGN KEY (`payments_id`)
    REFERENCES `spotify`.`payments` (`id`)
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
  PRIMARY KEY (`id`),
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
  `users_id` INT NOT NULL,
  `added_at` DATETIME NOT NULL,
  PRIMARY KEY (`playlists_id`, `songs_id`, `users_id`),
  INDEX `fk_playlists_has_songs_songs1_idx` (`songs_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_songs_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  INDEX `fk_playlists_has_songs_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_has_songs_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlists_has_songs_songs1`
    FOREIGN KEY (`songs_id`)
    REFERENCES `spotify`.`songs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlists_has_songs_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_has_favourite_songs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_has_favourite_songs` (
  `users_id` INT NOT NULL,
  `songs_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `songs_id`),
  INDEX `fk_users_has_songs_songs1_idx` (`songs_id` ASC) VISIBLE,
  INDEX `fk_users_has_songs_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_songs_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_songs_songs1`
    FOREIGN KEY (`songs_id`)
    REFERENCES `spotify`.`songs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_shared_playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_shared_playlists` (
  `users_id` INT NOT NULL,
  `playlists_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `playlists_id`),
  INDEX `fk_users_has_playlists_playlists1_idx` (`playlists_id` ASC) VISIBLE,
  INDEX `fk_users_has_playlists_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_playlists_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_playlists_playlists1`
    FOREIGN KEY (`playlists_id`)
    REFERENCES `spotify`.`playlists` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`users_has_favourite_albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`users_has_favourite_albums` (
  `users_id` INT NOT NULL,
  `albums_id` INT NOT NULL,
  `albums_artists_id` INT NOT NULL,
  PRIMARY KEY (`users_id`, `albums_id`, `albums_artists_id`),
  INDEX `fk_users_has_albums_albums1_idx` (`albums_id` ASC, `albums_artists_id` ASC) VISIBLE,
  INDEX `fk_users_has_albums_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_albums_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `spotify`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_albums_albums1`
    FOREIGN KEY (`albums_id` , `albums_artists_id`)
    REFERENCES `spotify`.`albums` (`id` , `artists_id`)
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
-- Data for table `spotify`.`paymentMethod`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`paymentMethod` (`id`, `users_id`, `type`, `cc_number`, `cc_month`, `cc_year`, `cc_cvv`, `pp_user_name`) VALUES (DEFAULT, 1, 'CC', '089895904984', 09, 2025, 000, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`payments`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`payments` (`id`, `order_num`, `date`, `price`, `paymentMethod_id`) VALUES (DEFAULT, '2021-00000001', '2021-06-25', 20, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`subscriptions`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`subscriptions` (`id`, `start_date`, `renewal_date`, `users_id`, `payments_id`) VALUES (DEFAULT, '2021-06-25', '2022-06-25', 2, 1);

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
-- Data for table `spotify`.`users_follow_artists`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users_follow_artists` (`users_id`, `artists_id`) VALUES (1, 1);
INSERT INTO `spotify`.`users_follow_artists` (`users_id`, `artists_id`) VALUES (1, 2);
INSERT INTO `spotify`.`users_follow_artists` (`users_id`, `artists_id`) VALUES (1, 3);

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
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `users_id`, `added_at`) VALUES (1, 1, 1, '2021-06-29');
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `users_id`, `added_at`) VALUES (1, 2, 1, '2021-06-29');
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `users_id`, `added_at`) VALUES (1, 3, 2, '2021-06-28');
INSERT INTO `spotify`.`playlists_has_songs` (`playlists_id`, `songs_id`, `users_id`, `added_at`) VALUES (1, 4, 3, '2021-07-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`users_has_favourite_songs`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`) VALUES (1, 1);
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`) VALUES (1, 2);
INSERT INTO `spotify`.`users_has_favourite_songs` (`users_id`, `songs_id`) VALUES (1, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spotify`.`users_shared_playlists`
-- -----------------------------------------------------
START TRANSACTION;
USE `spotify`;
INSERT INTO `spotify`.`users_shared_playlists` (`users_id`, `playlists_id`) VALUES (1, 1);
INSERT INTO `spotify`.`users_shared_playlists` (`users_id`, `playlists_id`) VALUES (1, 2);
INSERT INTO `spotify`.`users_shared_playlists` (`users_id`, `playlists_id`) VALUES (1, 3);

COMMIT;



-- Proves

-- Mostra el nom de l'usuari i les cançons agregades a una playlist que pertanyi a un altre usuari
-- L'usuari jose_01 ha creat una playlist "Rock", quins altres usuaris han afegir cançons?

USE spotify;
SELECT u.user_name, s.name Song, p.title Playlist_title
FROM users u
INNER JOIN playlists_has_songs phs
ON u.id = phs.users_id
INNER JOIN playlists p
ON phs.playlists_id = p.id
INNER JOIN songs s
ON s.id = phs.songs_id
WHERE p.users_id != u.id

-- Result:
-- user_name | Song          | Playlist_title
-- laura_01  | Go Let It Out | Rock
-- juan_01   | Satisfaction  | Rock