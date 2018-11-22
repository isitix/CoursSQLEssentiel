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
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES ('FRANCE', 'FRA', 'FRF', 'Franc');
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES ('UNITED STATES', 'USA','USD','Dollar');
INSERT INTO countries (name, country_code, currency_code, currency)  VALUES ( 
    'UNITED KINGDOM',
    'GBR',
    'GBP',
    'Pound Sterling'),
    (
    'GERMANY',
    'DEU',
    'DEM',
    'Mark'),
    (
        'SWITZERLAND',
        'CHE',
        'CHF',
        'Franc'),
    (
        'POLAND',
        'POL',
        'PLZ',
    'Zloty');
