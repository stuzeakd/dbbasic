-- MySQL Script generated by MySQL Workbench
-- Tue Jan  6 06:54:23 2015
-- Model: New Model    Version: 1.0
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`account` ;

CREATE TABLE IF NOT EXISTS `mydb`.`account` (
  `id` VARCHAR(10) NOT NULL,
  `email` VARCHAR(45) NULL,
  `pwd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PHOTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PHOTO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PHOTO` (
  `id` CHAR(18) NOT NULL,
  `file_path` VARCHAR(45) NOT NULL,
  `thumbnail_path` VARCHAR(45) NOT NULL,
  `account_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_PHOTO_account_idx` (`account_id` ASC),
  CONSTRAINT `fk_PHOTO_account`
    FOREIGN KEY (`account_id`)
    REFERENCES `mydb`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PHOTO_INFO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PHOTO_INFO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PHOTO_INFO` (
  `PHOTO_id` CHAR(18) NOT NULL,
  PRIMARY KEY (`PHOTO_id`),
  CONSTRAINT `fk_PHOTO_INFO_PHOTO1`
    FOREIGN KEY (`PHOTO_id`)
    REFERENCES `mydb`.`PHOTO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`COLORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`COLORS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`COLORS` (
  `no` INT NOT NULL,
  `h` INT NOT NULL,
  `s` FLOAT NOT NULL,
  `l` FLOAT NOT NULL,
  `PHOTO_id` CHAR(18) NOT NULL,
  PRIMARY KEY (`no`, `PHOTO_id`),
  INDEX `fk_COLORS_PHOTO1_idx` (`PHOTO_id` ASC),
  CONSTRAINT `fk_COLORS_PHOTO1`
    FOREIGN KEY (`PHOTO_id`)
    REFERENCES `mydb`.`PHOTO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`USER_INFO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`USER_INFO` ;

CREATE TABLE IF NOT EXISTS `mydb`.`USER_INFO` (
  `name` VARCHAR(45) NULL,
  `profile` VARCHAR(45) NULL,
  `account_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`account_id`),
  CONSTRAINT `fk_USER_INFO_account1`
    FOREIGN KEY (`account_id`)
    REFERENCES `mydb`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BG_COLORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`BG_COLORS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`BG_COLORS` (
  `PHOTO_id` CHAR(18) NOT NULL,
  `COLORS_no` INT NOT NULL,
  PRIMARY KEY (`PHOTO_id`, `COLORS_no`),
  INDEX `fk_BG_COLORS_COLORS1_idx` (`COLORS_no` ASC),
  CONSTRAINT `fk_BG_COLORS_PHOTO1`
    FOREIGN KEY (`PHOTO_id`)
    REFERENCES `mydb`.`PHOTO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BG_COLORS_COLORS1`
    FOREIGN KEY (`COLORS_no`)
    REFERENCES `mydb`.`COLORS` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TEXT_COLORS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TEXT_COLORS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TEXT_COLORS` (
  `PHOTO_id` CHAR(18) NOT NULL,
  `COLORS_no` INT NOT NULL,
  PRIMARY KEY (`PHOTO_id`, `COLORS_no`),
  INDEX `fk_TEXT_COLORS_COLORS1_idx` (`COLORS_no` ASC),
  CONSTRAINT `fk_TEXT_COLORS_PHOTO1`
    FOREIGN KEY (`PHOTO_id`)
    REFERENCES `mydb`.`PHOTO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TEXT_COLORS_COLORS1`
    FOREIGN KEY (`COLORS_no`)
    REFERENCES `mydb`.`COLORS` (`no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
