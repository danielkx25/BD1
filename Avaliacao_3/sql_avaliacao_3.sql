-- MySQL Script generated by MySQL Workbench
-- Fri Nov 13 22:02:37 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Loja
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Loja
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Loja` DEFAULT CHARACTER SET utf8 ;
USE `Loja` ;

-- -----------------------------------------------------
-- Table `Loja`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Usuarios` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Login` VARCHAR(45) NOT NULL,
  `Senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Logins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Logins` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Data_Login` DATE NOT NULL,
  `Hora_Login` TIME NOT NULL,
  `Usuarios_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Logins_Usuarios_idx` (`Usuarios_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Logins_Usuarios`
    FOREIGN KEY (`Usuarios_Id`)
    REFERENCES `Loja`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Fornecedores` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Compras` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  `Descricao` VARCHAR(45) NOT NULL,
  `Total` FLOAT NOT NULL,
  `Usuarios_Id` INT NOT NULL,
  `Fornecedores_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Compras_Usuarios1_idx` (`Usuarios_Id` ASC) VISIBLE,
  INDEX `fk_Compras_Fornecedores1_idx` (`Fornecedores_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Compras_Usuarios1`
    FOREIGN KEY (`Usuarios_Id`)
    REFERENCES `Loja`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compras_Fornecedores1`
    FOREIGN KEY (`Fornecedores_Id`)
    REFERENCES `Loja`.`Fornecedores` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Clientes` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Vendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Vendas` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Data` DATE NOT NULL,
  `Total` FLOAT NOT NULL,
  `Usuarios_Id` INT NOT NULL,
  `Clientes_Id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Vendas_Usuarios1_idx` (`Usuarios_Id` ASC) VISIBLE,
  INDEX `fk_Vendas_Clientes1_idx` (`Clientes_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Vendas_Usuarios1`
    FOREIGN KEY (`Usuarios_Id`)
    REFERENCES `Loja`.`Usuarios` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendas_Clientes1`
    FOREIGN KEY (`Clientes_Id`)
    REFERENCES `Loja`.`Clientes` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Produtos` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Preco` FLOAT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Historico_Precos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Historico_Precos` (
  `Preco_Venda` INT NOT NULL,
  `Data_Inicio` DATE NOT NULL,
  `Data_Fim` DATE NOT NULL,
  `Produtos_Id` INT NOT NULL,
  INDEX `fk_Historico_Precos_Produtos1_idx` (`Produtos_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Historico_Precos_Produtos1`
    FOREIGN KEY (`Produtos_Id`)
    REFERENCES `Loja`.`Produtos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Produtos_Comprados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Produtos_Comprados` (
  `Compras_Id` INT NOT NULL,
  `Num_Sequencia` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Preco` FLOAT NOT NULL,
  `Total` FLOAT NOT NULL,
  `Desconto` INT NOT NULL,
  `Produtos_Id` INT NOT NULL,
  PRIMARY KEY (`Compras_Id`, `Num_Sequencia`),
  INDEX `fk_Produtos_Comprados_Produtos1_idx` (`Produtos_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_Comprados_Compras1`
    FOREIGN KEY (`Compras_Id`)
    REFERENCES `Loja`.`Compras` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_Comprados_Produtos1`
    FOREIGN KEY (`Produtos_Id`)
    REFERENCES `Loja`.`Produtos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Loja`.`Produtos_Vendidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Loja`.`Produtos_Vendidos` (
  `Vendas_Id` INT NOT NULL,
  `Num_Sequencia` VARCHAR(45) NOT NULL,
  `Quantidade` INT NOT NULL,
  `Preco` FLOAT NOT NULL,
  `Desconto` INT NOT NULL,
  `Total` FLOAT NOT NULL,
  `Produtos_Id` INT NOT NULL,
  PRIMARY KEY (`Vendas_Id`, `Num_Sequencia`),
  INDEX `fk_Produtos_Vendidos_Produtos1_idx` (`Produtos_Id` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_Vendidos_Vendas1`
    FOREIGN KEY (`Vendas_Id`)
    REFERENCES `Loja`.`Vendas` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_Vendidos_Produtos1`
    FOREIGN KEY (`Produtos_Id`)
    REFERENCES `Loja`.`Produtos` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/* Atividade 4 */

INSERT INTO Usuarios(Nome,Login,Senha) VALUES ('José Castro Alves','josecastro','1234');
INSERT INTO Usuarios(Nome,Login,Senha) Values('Maria Jackson Rodrigues','mariajackson','6789');

INSERT INTO Logins(Data_Login,Hora_Login,Usuarios_Id) VALUES ('2020-01-01','12:30',1);
INSERT INTO Logins(Data_Login,Hora_Login,Usuarios_Id) VALUES ('2020-11-01','12:40',2);

SELECT * FROM Usuarios;
SELECT * FROM Logins;

UPDATE Usuarios SET Nome='Jose Castro Almerindo' WHERE Id=1;

SELECT * FROM Usuarios;

DELETE FROM Logins WHERE Id>=1;
DELETE FROM Usuarios WHERE Id>=1;

/* Atividade 5 */

/*a*/
SELECT * FROM Clientes WHERE Nome LIKE 'A%';

/*b*/
SELECT * FROM Vendas WHERE Clientes_Id=2443;

/*c*/
SELECT * FROM Logins WHERE Data_Login BETWEEN '2020-11-01' AND '2020-11-20';

/*d*/
SELECT * FROM Vendas WHERE Id=2300;
SELECT * FROM Produtos_Vendidos WHERE Vendas_Id=2300;

/*e*/
SELECT * FROM Produtos WHERE Quantidade > 900;


DROP DATABASE Loja;
