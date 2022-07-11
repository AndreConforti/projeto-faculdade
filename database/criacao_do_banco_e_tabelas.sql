-- -----------------------------------------------------
-- Schema bd_faculdade
--
-- Banco de dados criado para o gerenciamento de uma Faculdade, sendo utilizado para o aprendizado em SQL, Python, QT Designer, MySQL.
-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS db_faculdade
	DEFAULT CHARSET = utf8
    DEFAULT COLLATE = utf8_general_ci;
    
USE db_faculdade;

-- -----------------------------------------------------
-- Table DEPARTAMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `departamento` (
  `cod_departamento` INT NOT NULL AUTO_INCREMENT COMMENT 'Código do departamento',
  `nome_departamento` VARCHAR(40) NOT NULL COMMENT 'Nome do departamento',
  PRIMARY KEY (`cod_departamento`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PROFESSOR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `professor` (
  `cod_professor` INT NOT NULL AUTO_INCREMENT COMMENT 'Código do professor',
  `nome_professor` VARCHAR(40) NOT NULL COMMENT 'Nome do professor',
  `sobrenome_professor` VARCHAR(40) NOT NULL COMMENT 'Sobrenome do professor',
  `status_prof` TINYINT NOT NULL COMMENT 'Status (Lecionando / Não Lecionando)',
  `cod_departamento` INT NOT NULL COMMENT 'Código do professor',
  PRIMARY KEY (`cod_professor`),
  CONSTRAINT `fk_dep_prof`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CURSO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `curso` (
  `cod_curso` INT NOT NULL AUTO_INCREMENT COMMENT 'Código do curso',
  `nome_curso` VARCHAR(40) NOT NULL COMMENT 'Nome do curso',
  `cod_departamento` INT NOT NULL COMMENT 'Código do departamento',
  PRIMARY KEY (`cod_curso`),
  CONSTRAINT `fk_dep_curso`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table TURMA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `turma` (
  `cod_turma` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação da turma',
  `cod_curso` INT NOT NULL COMMENT 'Código de identificação do curso',
  `periodo` VARCHAR(10) NOT NULL COMMENT 'Período da turma (manhã, tarde, noite)',
  `num_alunos` INT NOT NULL COMMENT 'Número de alunos',
  `data_inicio` DATE NOT NULL COMMENT 'Data de início da turma',
  `data_fim` DATE NOT NULL COMMENT 'Data de término da turma',
  PRIMARY KEY (`cod_turma`),
  CONSTRAINT `fk_turma_curso`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table ALUNO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aluno` (
  `ra` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do aluno',
  `nome_aluno` VARCHAR(40) NOT NULL COMMENT 'Nome do aluno',
  `sobrenome_aluno` VARCHAR(40) NOT NULL COMMENT 'Sobrenome do aluno',
  `cpf` VARCHAR(11) NOT NULL COMMENT 'CPF do aluno',
  `status_aluno` TINYINT NOT NULL COMMENT 'Status da matríula do aluno (ativo / inativo)',
  `cod_turma` INT NOT NULL COMMENT 'Código de identificação da turma',
  `cod_curso` INT NOT NULL COMMENT 'Código de identificação do curso',
  `sexo` CHAR(1) NOT NULL COMMENT 'Sexo (gênero) do aluno',
  `nome_pai` VARCHAR(80) NULL COMMENT 'Nome do pai do aluno',
  `nome_mae` VARCHAR(80) NOT NULL COMMENT 'Nome da mãe do aluno',
  `email` VARCHAR(80) NOT NULL COMMENT 'e-mail do aluno',
  `whatsapp` VARCHAR(15) NOT NULL COMMENT 'Número de WhatsApp do aluno',
  PRIMARY KEY (`ra`),
  CONSTRAINT `fk_aluno_curso`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_turma`
    FOREIGN KEY (`cod_turma`)
    REFERENCES `turma` (`cod_turma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `disciplina` (
  `cod_disciplina` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação da disciplina',
  `cod_disciplina_depende` INT NULL,
  `nome_disciplina` VARCHAR(40) NOT NULL COMMENT 'Nome da disciplina',
  `descricao` VARCHAR(200) NULL COMMENT 'Descrição da disciplina',
  `cod_departamento` INT NOT NULL COMMENT 'Código de identificação do departamento',
  `carga_horaria` INT NOT NULL COMMENT 'Carga horária da disciplina',
  `num_alunos` INT NOT NULL COMMENT 'Número de alunos inscritos na disciplina',
  PRIMARY KEY (`cod_disciplina`),
  CONSTRAINT `fk_dep_disc`
    FOREIGN KEY (`cod_departamento`)
    REFERENCES `departamento` (`cod_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disc_disc`
	FOREIGN KEY (`cod_disciplina_depende`)
    REFERENCES `disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table HISTÓRICO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historico` (
  `cod_historico` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do histórico',
  `ra` INT NOT NULL COMMENT 'Código de identificação do aluno',
  `data_inicio` DATE NOT NULL COMMENT 'Data do início da disciplina para o aluno',
  `data_fim` DATE NOT NULL COMMENT 'Data de término da disciplina do aluno',
  PRIMARY KEY (`cod_historico`),
  CONSTRAINT `fk_ra_hist`
    FOREIGN KEY (`ra`)
    REFERENCES `aluno` (`ra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table HIST_DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hist_disciplina` (
  `cod_historico` INT NOT NULL COMMENT 'Código de identificação do histórico',
  `cod_disciplina` INT NOT NULL COMMENT 'Código de identificação da discipllina',
  `nota` FLOAT(4,2) NOT NULL COMMENT 'Nota da disciplina',
  `frequencia` INT NOT NULL COMMENT 'Número de faltas, baseado no número de aulas da disciplina',
  PRIMARY KEY (`cod_historico`, `cod_disciplina`),
  CONSTRAINT `fk_hist_disc`
    FOREIGN KEY (`cod_historico`)
    REFERENCES `historico` (`cod_historico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disc_hist`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table CURSO_DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `curso_disciplina` (
  `cod_curso` INT NOT NULL COMMENT 'Código de identificação do curso',
  `cod_disciplina` INT NOT NULL COMMENT 'Código de identificação da disciplina',
  PRIMARY KEY (`cod_curso`, `cod_disciplina`),
  CONSTRAINT `fk_curso_disc`
    FOREIGN KEY (`cod_curso`)
    REFERENCES `curso` (`cod_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disc_curso`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table PROF_DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `prof_disciplina` (
  `cod_professor` INT NOT NULL COMMENT 'Código de identificação do professor',
  `cod_disciplina` INT NOT NULL COMMENT 'Código de identificação da disciplina',
  PRIMARY KEY (`cod_professor`, `cod_disciplina`),
  CONSTRAINT `fk_prof_disc`
    FOREIGN KEY (`cod_professor`)
    REFERENCES `professor` (`cod_professor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disc_prof`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table ALUNO_DISCIPLINA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aluno_disciplina` (
  `ra` INT NOT NULL COMMENT 'Código de identificação do aluno',
  `cod_disciplina` INT NOT NULL COMMENT 'Código de identificação da disciplina',
  PRIMARY KEY (`ra`, `cod_disciplina`),
  CONSTRAINT `fk_aluno_disc`
    FOREIGN KEY (`ra`)
    REFERENCES `aluno` (`ra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_disc_aluno`
    FOREIGN KEY (`cod_disciplina`)
    REFERENCES `disciplina` (`cod_disciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table TIPO_LOGRADOURO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_logradouro` (
  `cod_tipo_logradouro` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do tipo de logradouro',
  `tipo_logradouro` VARCHAR(10) NOT NULL COMMENT 'Nome do tipo de logradouro',
  PRIMARY KEY (`cod_tipo_logradouro`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table ENDERECO_ALUNO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `endereco_aluno` (
  `cod_endereco` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do endereço do aluno',
  `ra` INT NOT NULL COMMENT 'Código de identicação do aluno',
  `cod_tipo_logradouro` INT NOT NULL COMMENT 'Código de identifcação do tipo de logradouro',
  `nome_rua` VARCHAR(80) NOT NULL COMMENT 'Noma da rua do endereço do aluno',
  `num_rua` INT NOT NULL COMMENT 'Número do endereço do aluno',
  `complemento` VARCHAR(20) NULL COMMENT 'Complemento do endereço do aluno (caso houver)',
  `cep` VARCHAR(10) NOT NULL COMMENT 'Número do cep do endereço do aluno',
  PRIMARY KEY (`cod_endereco`),
  CONSTRAINT `fk_ra_cod_endereco`
    FOREIGN KEY (`ra`)
    REFERENCES `aluno` (`ra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_logradouro`
    FOREIGN KEY (`cod_tipo_logradouro`)
    REFERENCES `tipo_logradouro` (`cod_tipo_logradouro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table TIPO_TELEFONE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tipo_telefone` (
  `cod_tipo_telefone` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do tipo de telefone do aluno',
  `tipo_telefone` VARCHAR(15) NOT NULL COMMENT 'Nome do tipo de telefone do aluno',
  PRIMARY KEY (`cod_tipo_telefone`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table TELEFONES_ALUNO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telefones_aluno` (
  `cod_telefone_aluno` INT NOT NULL AUTO_INCREMENT COMMENT 'Código de identificação do telefone do aluno',
  `ra` INT NOT NULL,
  `cod_tipo_telefone` INT NOT NULL COMMENT 'Código de identificação do tipo de telefone do aluno',
  `num_telefone` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`cod_telefone_aluno`),
  CONSTRAINT `fk_telefone_aluno`
    FOREIGN KEY (`ra`)
    REFERENCES `aluno` (`ra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_telefone`
    FOREIGN KEY (`cod_tipo_telefone`)
    REFERENCES `tipo_telefone` (`cod_tipo_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
