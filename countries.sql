# Table des codes et des devis pour pouvoir 
# convertir les salaires de la monnaie locale en dollars
# MDY 20181123
USE employees;
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    country_code CHAR(3) NOT NULL,
    name CHAR(3) NOT NULL,
    currency_code CHAR(3),
    currency VARCHAR(16),
    PRIMARY KEY (country_code),
    UNIQUE KEY (name)
);
ALTER TABLE countries MODIFY COLUMN name VARCHAR(32) NOT NULL;
ALTER TABLE countries MODIFY COLUMN currency VARCHAR(32) NOT NULL;
