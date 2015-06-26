-- MySQL Script generated by MySQL Workbench
-- 06/24/15 20:11:35
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema university_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university_system` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `university_system` ;

-- -----------------------------------------------------
-- Table `university_system`.`faculties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`faculties` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(50) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`departments` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(50) NOT NULL COMMENT '',
  `faculty_id` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_departments_faculties_idx` (`faculty_id` ASC)  COMMENT '',
  CONSTRAINT `fk_departments_faculties`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university_system`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`professors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`professors` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(50) NOT NULL COMMENT '',
  `department_id` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_professors_departments_idx` (`department_id` ASC)  COMMENT '',
  CONSTRAINT `fk_professors_departments`
    FOREIGN KEY (`department_id`)
    REFERENCES `university_system`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`titles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`titles` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `title` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  UNIQUE INDEX `title_UNIQUE` (`title` ASC)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`courses` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `department_id` INT UNSIGNED NOT NULL COMMENT '',
  `professor_id` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_courses_departments_idx` (`department_id` ASC)  COMMENT '',
  INDEX `fk_courses_professors1_idx` (`professor_id` ASC)  COMMENT '',
  CONSTRAINT `fk_courses_departments`
    FOREIGN KEY (`department_id`)
    REFERENCES `university_system`.`departments` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_professors1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `university_system`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`students` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `faculty_id` INT UNSIGNED NOT NULL COMMENT '',
  `first_name` VARCHAR(45) NULL COMMENT '',
  `last_name` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '',
  INDEX `fk_students_faculties_idx` (`faculty_id` ASC)  COMMENT '',
  CONSTRAINT `fk_students_faculties`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university_system`.`faculties` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`courses_has_students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`courses_has_students` (
  `courses_id` INT UNSIGNED NOT NULL COMMENT '',
  `student_id` INT UNSIGNED NOT NULL COMMENT '',
  PRIMARY KEY (`courses_id`, `student_id`)  COMMENT '',
  INDEX `fk_courses_has_students_students1_idx` (`student_id` ASC)  COMMENT '',
  INDEX `fk_courses_has_students_courses1_idx` (`courses_id` ASC)  COMMENT '',
  CONSTRAINT `fk_courses_has_students_courses1`
    FOREIGN KEY (`courses_id`)
    REFERENCES `university_system`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_has_students_students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university_system`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `university_system`.`professor_has_title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_system`.`professor_has_title` (
  `professor_id` INT UNSIGNED NOT NULL COMMENT '',
  `title_id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`professor_id`, `title_id`)  COMMENT '',
  INDEX `fk_professor_has_title_title_idx` (`title_id` ASC)  COMMENT '',
  CONSTRAINT `fk_professor_has_title_title`
    FOREIGN KEY (`title_id`)
    REFERENCES `university_system`.`titles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_title_professor`
    FOREIGN KEY (`professor_id`)
    REFERENCES `university_system`.`professors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;