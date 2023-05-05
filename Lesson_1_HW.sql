# HW_01

CREATE SCHEMA `mobilephones` ;

CREATE TABLE `mobilephones`.`stock` (
  `id` INT UNSIGNED NOT NULL,
  `product_name` VARCHAR(100) NOT NULL,
  `manufacturer` VARCHAR(100) NOT NULL,
  `product_count` INT NOT NULL,
  `price` INT NOT NULL,
PRIMARY KEY (`id`, `price`, `product_name`, `manufacturer`, `product_count`));

INSERT INTO `mobilephones`.`stock` (`id`, `product_name`, `manufacturer`, `product_count`, `price`) VALUES ('1', 'iPhone X', 'Apple', '3', '76000');
INSERT INTO `mobilephones`.`stock` (`id`, `product_name`, `manufacturer`, `product_count`, `price`) VALUES ('2', 'iPhone 8', 'Apple', '2', '51000');
INSERT INTO `mobilephones`.`stock` (`id`, `product_name`, `manufacturer`, `product_count`, `price`) VALUES ('3', 'Galaxy S9', 'Samsung', '2', '56000');
INSERT INTO `mobilephones`.`stock` (`id`, `product_name`, `manufacturer`, `product_count`, `price`) VALUES ('4', 'Galaxy S8', 'Samsung', '1', '41000');
INSERT INTO `mobilephones`.`stock` (`id`, `product_name`, `manufacturer`, `product_count`, `price`) VALUES ('5', 'P20 Pro', 'Huawei', '5', '36000');

SELECT * FROM mobilePhones.stock;

SELECT id, product_name FROM mobilePhones.stock
where product_count > '2' ;

SELECT id, product_name, manufacturer FROM mobilePhones.stock
where manufacturer = 'Samsung' ;

SELECT id, product_name, manufacturer FROM mobilePhones.stock
where product_name like '%Iphone%' 
OR manufacturer LIKE '%Iphone%'; 

SELECT id, product_name, manufacturer FROM mobilePhones.stock
where product_name like '%Samsung%' 
OR manufacturer LIKE '%Samsung%'; 

SELECT id, product_name, manufacturer FROM mobilePhones.stock
where product_name REGEXP '[0-9]'
or manufacturer REGEXP '[0-9]';

SELECT id, product_name, manufacturer FROM mobilePhones.stock
where product_name REGEXP '8'
or manufacturer REGEXP '8';