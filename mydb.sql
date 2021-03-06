CREATE TABLE IF NOT EXISTS `mydb`.`IFM_USUARIOS` (
  `USU_ID` VARCHAR(45) NOT NULL,
  `USU_NOME` VARCHAR(45) NOT NULL,
  `USU_EMAIL` VARCHAR(30) NOT NULL,
  `USU_PASSW` VARCHAR(15) NOT NULL,
  `USU_FONE` VARCHAR(45) NULL,
  PRIMARY KEY (`USU_ID`),
  UNIQUE INDEX `USU_EMAIL_UNIQUE` (`USU_EMAIL` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_CURSOS` (
  `CUR_ID` INT NOT NULL AUTO_INCREMENT,
  `CUR_NOME` VARCHAR(45) NOT NULL,
  `CUR_CORDENADOR` VARCHAR(45) NULL,
  PRIMARY KEY (`CUR_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_PERFIL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_PERFIL` (
  `PER_ID` INT NOT NULL AUTO_INCREMENT,
  `PER_TIPO` VARCHAR(15) NULL,
  `PER_USU_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PER_ID`),
  INDEX `fk_IFM_PERFIL_IFM_USUARIOS1_idx` (`PER_USU_ID` ASC),
  CONSTRAINT `fk_IFM_PERFIL_IFM_USUARIOS1`
    FOREIGN KEY (`PER_USU_ID`)
    REFERENCES `mydb`.`IFM_USUARIOS` (`USU_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_ALUNOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_ALUNOS` (
  `IFM_PERFIL_PER_ID` INT NOT NULL,
  `ALU_MATRICULA` VARCHAR(45) NOT NULL,
  INDEX `fk_IFM_ALUNOS_IFM_PERFIL1_idx` (`IFM_PERFIL_PER_ID` ASC),
  PRIMARY KEY (`ALU_MATRICULA`),
  CONSTRAINT `fk_IFM_ALUNOS_IFM_PERFIL1`
    FOREIGN KEY (`IFM_PERFIL_PER_ID`)
    REFERENCES `mydb`.`IFM_PERFIL` (`PER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_PROFESSORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_PROFESSORES` (
  `IFM_PERFIL_PER_ID` INT NOT NULL,
  `PRO_CIAP` VARCHAR(45) NOT NULL,
  INDEX `fk_IFM_PROFESSORES_IFM_PERFIL1_idx` (`IFM_PERFIL_PER_ID` ASC),
  PRIMARY KEY (`PRO_CIAP`),
  CONSTRAINT `fk_IFM_PROFESSORES_IFM_PERFIL1`
    FOREIGN KEY (`IFM_PERFIL_PER_ID`)
    REFERENCES `mydb`.`IFM_PERFIL` (`PER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_FUNCIONARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_FUNCIONARIOS` (
  `IFM_PERFIL_PER_ID` INT NOT NULL,
  `FUN_CIAP` VARCHAR(45) NOT NULL,
  INDEX `fk_IFM_FUNCIONARIOS_IFM_PERFIL1_idx` (`IFM_PERFIL_PER_ID` ASC),
  PRIMARY KEY (`FUN_CIAP`),
  CONSTRAINT `fk_IFM_FUNCIONARIOS_IFM_PERFIL1`
    FOREIGN KEY (`IFM_PERFIL_PER_ID`)
    REFERENCES `mydb`.`IFM_PERFIL` (`PER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_DISCIPLINAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_DISCIPLINAS` (
  `DISC_ID` INT NOT NULL AUTO_INCREMENT,
  `DIS_DESCRICAO` TEXT NULL,
  PRIMARY KEY (`DISC_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_PERIODO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_PERIODO` (
  `PER_CURSOS_ID` INT NOT NULL,
  `PER_ALUNOS_MATRICULA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`PER_CURSOS_ID`, `PER_ALUNOS_MATRICULA`),
  INDEX `fk_IFM_CURSOS_has_IFM_ALUNOS_IFM_ALUNOS1_idx` (`PER_ALUNOS_MATRICULA` ASC),
  INDEX `fk_IFM_CURSOS_has_IFM_ALUNOS_IFM_CURSOS1_idx` (`PER_CURSOS_ID` ASC),
  CONSTRAINT `fk_IFM_CURSOS_has_IFM_ALUNOS_IFM_CURSOS1`
    FOREIGN KEY (`PER_CURSOS_ID`)
    REFERENCES `mydb`.`IFM_CURSOS` (`CUR_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IFM_CURSOS_has_IFM_ALUNOS_IFM_ALUNOS1`
    FOREIGN KEY (`PER_ALUNOS_MATRICULA`)
    REFERENCES `mydb`.`IFM_ALUNOS` (`ALU_MATRICULA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_PROFESSOR_DISPLINA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_PROFESSOR_DISPLINA` (
  `IFM_DISCIPLINAS_DISC_ID` INT NOT NULL,
  `IFM_PROFESSORES_PRO_CIAP` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IFM_DISCIPLINAS_DISC_ID`, `IFM_PROFESSORES_PRO_CIAP`),
  INDEX `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES1_idx` (`IFM_PROFESSORES_PRO_CIAP` ASC),
  INDEX `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS1_idx` (`IFM_DISCIPLINAS_DISC_ID` ASC),
  CONSTRAINT `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS1`
    FOREIGN KEY (`IFM_DISCIPLINAS_DISC_ID`)
    REFERENCES `mydb`.`IFM_DISCIPLINAS` (`DISC_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES1`
    FOREIGN KEY (`IFM_PROFESSORES_PRO_CIAP`)
    REFERENCES `mydb`.`IFM_PROFESSORES` (`PRO_CIAP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`IFM_DISCIPLINAS_PROFESSORES_PERIODO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IFM_DISCIPLINAS_PROFESSORES_PERIODO` (
  `IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS_DISC_ID` INT NOT NULL,
  `IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES_PRO_CIAP` VARCHAR(45) NOT NULL,
  `IFM_PERIODO_PER_CURSOS_ID` INT NOT NULL,
  `IFM_PERIODO_PER_ALUNOS_MATRICULA` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS_DISC_ID`, `IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES_PRO_CIAP`, `IFM_PERIODO_PER_CURSOS_ID`, `IFM_PERIODO_PER_ALUNOS_MATRICULA`),
  INDEX `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_has_IFM_PERIODO_IFM__idx` (`IFM_PERIODO_PER_CURSOS_ID` ASC, `IFM_PERIODO_PER_ALUNOS_MATRICULA` ASC),
  INDEX `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_has_IFM_PERIODO_IFM__idx1` (`IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS_DISC_ID` ASC, `IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES_PRO_CIAP` ASC),
  CONSTRAINT `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_has_IFM_PERIODO_IFM_DI1`
    FOREIGN KEY (`IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_DISCIPLINAS_DISC_ID` , `IFM_DISCIPLINAS_has_IFM_PROFESSORES_IFM_PROFESSORES_PRO_CIAP`)
    REFERENCES `mydb`.`IFM_PROFESSOR_DISPLINA` (`IFM_DISCIPLINAS_DISC_ID` , `IFM_PROFESSORES_PRO_CIAP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_IFM_DISCIPLINAS_has_IFM_PROFESSORES_has_IFM_PERIODO_IFM_PE1`
    FOREIGN KEY (`IFM_PERIODO_PER_CURSOS_ID` , `IFM_PERIODO_PER_ALUNOS_MATRICULA`)
    REFERENCES `mydb`.`IFM_PERIODO` (`PER_CURSOS_ID` , `PER_ALUNOS_MATRICULA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)