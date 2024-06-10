
------------------------------------------------------------
-- Show users
------------------------------------------------------------
SELECT User, Host FROM mysql.user;

------------------------------------------------------------
-- Create a new user and password, change admin and somepassword
------------------------------------------------------------
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'somepassword';

------------------------------------------------------------
-- Grant all privileges to the new user
------------------------------------------------------------
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';
FLUSH PRIVILEGES;

------------------------------------------------------------
-- Show grants for the new user
------------------------------------------------------------
SHOW GRANTS FOR 'admin'@'localhost';

------------------------------------------------------------
-- Remove grants for the new user
------------------------------------------------------------
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'someuser'@'localhost';

FLUSH PRIVILEGES;

------------------------------------------------------------
-- Remove the new user
------------------------------------------------------------
DROP USER 'admin'@'localhost';


------------------------------------------------------------
CREATE DATABASE Landlord;
------------------------------------------------------------

USE Landlord;

-- -----------------------------------------------------
-- Table PropertyCode
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PropertyCode (
  location_ID INT NOT NULL AUTO_INCREMENT,
  municipality VARCHAR(64) NOT NULL,
  tract VARCHAR(64) NOT NULL,
  block INT(3) UNSIGNED NOT NULL,
  unit INT(3) UNSIGNED NULL,
  PRIMARY KEY (location_ID),
  UNIQUE INDEX location_ID_UNIQUE (location_ID ASC) VISIBLE,
  UNIQUE INDEX municipality_UNIQUE (municipality ASC) VISIBLE);


-- -----------------------------------------------------
-- Table Price
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Price (
  price_ID INT NOT NULL AUTO_INCREMENT,
  price_per_sqm INT(6) UNSIGNED NOT NULL,
  luxury TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (price_ID));


-- -----------------------------------------------------
-- Table Contract
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Contract (
  contract_ID INT NOT NULL AUTO_INCREMENT,
  start_date DATE NOT NULL,
  end_date DATE GENERATED ALWAYS AS (DATE_ADD(start_date, INTERVAL 12 MONTH)) STORED,
  -- autogenerate price_FK by multiplying price_per_sqm with surface keeping track of luxury
  price_FK INT NOT NULL,
  PRIMARY KEY (contract_ID),
  UNIQUE INDEX contract_ID_UNIQUE (contract_ID ASC) VISIBLE,
  INDEX price_FK_idx (price_FK ASC) VISIBLE,
  CONSTRAINT price_FK
    FOREIGN KEY (price_FK)
    REFERENCES Price (price_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

  price_FK INT NULL,
  PRIMARY KEY (contract_ID),
  INDEX fk_Contract_Price1_idx (price_FK ASC) VISIBLE,
  CONSTRAINT Contract_Price
    FOREIGN KEY (price_FK)
    REFERENCES Price (price_ID)
    ON DELETE SET NULL
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table Building
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Building (
  building_ID INT NOT NULL AUTO_INCREMENT,
  apartments INT(3) UNSIGNED NOT NULL,
  floorlevels INT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (building_ID));


-- -----------------------------------------------------
-- Table Apartment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Apartment (
  apartment_ID INT NOT NULL AUTO_INCREMENT,
  rooms INT(2) NOT NULL,
  surface INT(3) NOT NULL,
  apartment_buiding_FK INT NOT NULL,
  PRIMARY KEY (apartment_ID),
  INDEX Apartment_Building_idx (apartment_buiding_FK ASC) VISIBLE,
  CONSTRAINT Apartment_Building
    FOREIGN KEY (apartment_buiding_FK)
    REFERENCES Building (building_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table Tenant
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Tenant (
  tenant_ID INT NOT NULL AUTO_INCREMENT,
  firstname VARCHAR(64) NOT NULL,
  lastname VARCHAR(64) NOT NULL,
  personnummer VARCHAR(13) NOT NULL,
  phone VARCHAR(15) NULL,
  email VARCHAR(64) NULL,
  tenant_contract_FK INT NOT NULL,
  PRIMARY KEY (tenant_ID),
  UNIQUE INDEX personnummer_UNIQUE (personnummer ASC) VISIBLE,
  INDEX fk_Tenant_Contract1_idx (tenant_contract_FK ASC) VISIBLE,
  CONSTRAINT Tenant_Contract
    FOREIGN KEY (tenant_contract_FK)
    REFERENCES Contract (contract_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table Address
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Address (
  address_ID INT NOT NULL AUTO_INCREMENT,
  street_name VARCHAR(64) NOT NULL,
  street_nr INT(3) UNSIGNED NOT NULL,
  port VARCHAR(3) NULL,
  address_property_FK INT NOT NULL,
  building_address_FK INT NOT NULL,
  PRIMARY KEY (address_ID),
  INDEX fk_Address_PropertyCode_idx (address_property_FK ASC) VISIBLE,
  INDEX fk_Address_Building1_idx (building_address_FK ASC) VISIBLE,
  CONSTRAINT Address_Property
    FOREIGN KEY (address_property_FK)
    REFERENCES PropertyCode (location_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT Buiding_Address
    FOREIGN KEY (building_address_FK)
    REFERENCES Building (building_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table Lease
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Lease (
  apartment_FK INT NOT NULL,
  contract_FK INT NOT NULL,
  PRIMARY KEY (apartment_FK, contract_FK),
  INDEX fk_Apartment_has_Contract_Contract1_idx (contract_FK ASC) VISIBLE,
  INDEX fk_Apartment_has_Contract_Apartment1_idx (apartment_FK ASC) VISIBLE,
  CONSTRAINT fk_Apartment_has_Contract_Apartment1
    FOREIGN KEY (apartment_FK)
    REFERENCES Apartment (apartment_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Apartment_has_Contract_Contract1
    FOREIGN KEY (contract_FK)
    REFERENCES Contract (contract_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
