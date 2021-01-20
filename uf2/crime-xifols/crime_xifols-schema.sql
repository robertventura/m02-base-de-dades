/* 
-- -------------------------------------

Autor Robert Ventura

Basat amb SQL Murder Mystery de Kniht lab (https://mystery.knightlab.com/)
i Scene Crime de Laure Centellas (https://gitlab.com/centellas/m2-bases-de-dades/-/blob/master/)
CC BY-NC-SA 3.0
-- -------------------------------------
*/


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema crime_xifols_sql
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `crime_xifols_sql` ;

-- -----------------------------------------------------
-- Schema crime_xifols_sql
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `crime_xifols_sql` DEFAULT CHARACTER SET utf8mb4 ;
USE `crime_xifols_sql` ;

-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`agenda_victima`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`agenda_victima` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`agenda_victima` (
  `data_hora` DATETIME NOT NULL,
  `descripcio` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`data_hora`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`compres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`compres` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`compres` (
  `targeta_credit` CHAR(19) NOT NULL COMMENT 'Número de target de crèdit',
  `data_hora` DATETIME NOT NULL,
  `descripcio` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`targeta_credit`, `data_hora`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`departaments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`departaments` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`departaments` (
  `departament_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25) NOT NULL,
  `targeta_credit` CHAR(19) NOT NULL COMMENT 'Número de targeta de crèdit que s\'utilitza per realitzar compres per el departament',
  PRIMARY KEY (`departament_id`),
  UNIQUE INDEX `uk_departaments_targeta_credit` (`targeta_credit` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`carrecs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`carrecs` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`carrecs` (
  `carrec_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`carrec_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`empleats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`empleats` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`empleats` (
  `empleat_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `departament_id` INT UNSIGNED NOT NULL,
  `carrec_id` TINYINT UNSIGNED NOT NULL,
  `nom` VARCHAR(15) NOT NULL,
  `cognom1` VARCHAR(20) NOT NULL,
  `cognom2` VARCHAR(20) NOT NULL,
  `data_naixement` DATE NULL COMMENT 'S\'ha optat per guardar l\'edat dels empleats i no posar la data de naixement per atemportizar la BD.',
  `adreca` TEXT NULL DEFAULT NULL,
  `sou` FLOAT NULL DEFAULT NULL,
  `telefon` CHAR(12) NULL DEFAULT NULL,
  `targeta_credit` CHAR(19) NULL COMMENT 'Targeta de crèdit a disposició de l\'empleat per realitzar compres particulars',
  PRIMARY KEY (`empleat_id`),
  UNIQUE INDEX `uk_empleats_telefon` (`telefon` ASC),
  INDEX `fk_empleats_departaments_idx` (`departament_id` ASC),
  INDEX `fk_empleats_carrecs1_idx` (`carrec_id` ASC),
  UNIQUE INDEX `uk_empleats_targeta_credit` (`targeta_credit` ASC),
  CONSTRAINT `fk_empleats_departaments`
    FOREIGN KEY (`departament_id`)
    REFERENCES `crime_xifols_sql`.`departaments` (`departament_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleats_carrecs`
    FOREIGN KEY (`carrec_id`)
    REFERENCES `crime_xifols_sql`.`carrecs` (`carrec_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;





-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`impressions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`impressions` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`impressions` (
  `empleat_id` TINYINT UNSIGNED NULL COMMENT 'FK de la taula empleats quan s\'imprimeix el document des de l\'ordinador de l\'empleat i s\'ha de comptabilitzar la còpia a l\'empleat.',
  `departament_id` INT UNSIGNED NULL COMMENT 'FK de la taula departament quan s\'imprimeix un document a l\'impresora i s\'ha de comptabilitzar l\'impressió en el departament i no a l\'empleat',
  `data_hora` DATETIME NOT NULL,
  `document` VARCHAR(250) NOT NULL,
  INDEX `fk_impressions_empleats1_idx` (`empleat_id` ASC),
  INDEX `fk_impressions_departaments1_idx` (`departament_id` ASC),
  UNIQUE INDEX `uk_impressions_empleat_datahora` (`empleat_id` ASC, `data_hora` ASC),
  UNIQUE INDEX `uk_impressions_deps_data_hora` (`departament_id` ASC, `data_hora` ASC),
  CONSTRAINT `fk_impressions_empleats`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `crime_xifols_sql`.`empleats` (`empleat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_impressions_departaments`
    FOREIGN KEY (`departament_id`)
    REFERENCES `crime_xifols_sql`.`departaments` (`departament_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`trucades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`trucades` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`trucades` (
  `origen` CHAR(15) NOT NULL,
  `desti` CHAR(15) NOT NULL,
  `hora_inici` DATETIME NOT NULL,
  `hora_fi` DATETIME NOT NULL,
  PRIMARY KEY (`origen`, `desti`, `hora_inici`, `hora_fi`))
ENGINE = InnoDB
AUTO_INCREMENT = 58
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;





-- -----------------------------------------------------
-- Table `crime_xifols_sql`.`fitxatges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `crime_xifols_sql`.`fitxatges` ;

CREATE TABLE IF NOT EXISTS `crime_xifols_sql`.`fitxatges` (
  `data_hora` DATETIME NOT NULL,
  `empleat_id` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_fitxatges_empleats1_idx` (`empleat_id` ASC),
  PRIMARY KEY (`data_hora`, `empleat_id`),
  CONSTRAINT `fk_fitxatges_empleats`
    FOREIGN KEY (`empleat_id`)
    REFERENCES `crime_xifols_sql`.`empleats` (`empleat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
