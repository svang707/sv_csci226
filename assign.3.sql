### CSCI 226, Assignment 3
### Sam Vang
### NOTE: These SQL statements assume you have created the database and tables found in computers.sql.
### This script also assumes that you have created a "tmp" folder on your C:\ drive.

USE computers;

# 3.1
# a)
SELECT p.model, p.speed, p.hd
FROM pc p 
INNER JOIN product prod ON p.model = prod.model
WHERE p.price < 1000
INTO OUTFILE 'c:/tmp/assign.3.1.a.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# b)
SELECT p.model, p.speed AS gigahertz, p.hd AS gigabytes
FROM pc p 
INNER JOIN product prod ON p.model = prod.model
WHERE p.price < 1000
INTO OUTFILE 'c:/tmp/assign.3.1.b.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# c)
SELECT m.maker, m.makername
FROM printer p
INNER JOIN product prod ON prod.model = p.model
INNER JOIN manf m ON m.maker = prod.maker
INTO OUTFILE 'c:/tmp/assign.3.1.c.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# d)
SELECT l.model, l.ram, l.screen
FROM laptop l 
WHERE l.price > 1000
INTO OUTFILE 'c:/tmp/assign.3.1.d.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;


# e)
SELECT p.*
FROM printer p
WHERE p.color = 1
INTO OUTFILE 'c:/tmp/assign.3.1.e.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# f)
SELECT p.model, p.hd, p.speed
FROM pc p 
WHERE CAST( p.speed AS DECIMAL(3,2) ) = 3.2 AND p.price < 2000
INTO OUTFILE 'c:/tmp/assign.3.1.f.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# 3.2
# a)
SELECT m.makername, l.speed
FROM laptop l
INNER JOIN product prod ON prod.model = l.model
INNER JOIN manf m ON m.maker = prod.maker
WHERE l.hd >= 30
INTO OUTFILE 'c:/tmp/assign.3.2.a.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# b)
SELECT l.model, l.price
FROM product prod
INNER JOIN laptop l ON l.model = prod.model
WHERE prod.maker = 'B'
UNION 
SELECT pc.model, pc.price
FROM product prod
INNER JOIN pc pc ON pc.model = prod.model
WHERE prod.maker = 'B'
UNION
SELECT pr.model, pr.price
FROM product prod
INNER JOIN printer pr ON pr.model = prod.model
WHERE prod.maker = 'B'
UNION
SELECT l.model, l.price
FROM product prod
INNER JOIN laptop l ON l.model = prod.model
WHERE prod.maker = 'B'
INTO OUTFILE 'c:/tmp/assign.3.2.b.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# c)
SELECT m.makername
FROM laptop l 
INNER JOIN product p ON p.model = l.model
INNER JOIN manf m ON m.maker = p.maker
WHERE m.maker NOT IN (
	SELECT m.maker
	FROM pc pc
	INNER JOIN product p ON p.model = pc.model
	INNER JOIN manf m ON m.maker = p.maker
)
INTO OUTFILE 'c:/tmp/assign.3.2.c.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# d)
SELECT p.hd, COUNT(*)
FROM pc p
GROUP BY p.hd
HAVING COUNT(*) >= 2
INTO OUTFILE 'c:/tmp/assign.3.2.d.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# e)
SELECT pc1.model, pc2.model
FROM pc pc1
INNER JOIN pc pc2 ON pc2.speed = pc1.speed AND pc2.ram = pc1.ram
WHERE pc1.model < pc2.model
INTO OUTFILE 'c:/tmp/assign.3.2.e.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# f)
SELECT m.makername, COUNT(*)
FROM (SELECT model, speed FROM pc 
	  UNION
	  SELECT model, speed FROM laptop) AS computer
INNER JOIN product p on p.model = computer.model
INNER JOIN manf m on m.maker = p.maker
WHERE CAST(computer.speed AS DECIMAL(3,2)) >= 3.0
GROUP BY m.makername
HAVING COUNT(*) >= 2
INTO OUTFILE 'c:/tmp/assign.3.2.f.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;


# 3.3
# a)
SELECT DISTINCT m.maker
FROM pc pc
INNER JOIN product p ON p.model = pc.model
INNER JOIN manf m ON m.maker = p.maker
WHERE CAST(pc.speed AS DECIMAL(3,2)) >= 3.0
INTO OUTFILE 'c:/tmp/assign.3.3.a.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# b)
SELECT *
FROM printer p
WHERE p.price IN (
	SELECT MAX(price)
	FROM printer
)
INTO OUTFILE 'c:/tmp/assign.3.3.b.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# c)
SELECT *
FROM laptop l
WHERE l.speed < ANY (
	SELECT MIN(speed)
	FROM pc
)
INTO OUTFILE 'c:/tmp/assign.3.3.c.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# d)
SELECT model
FROM (
	SELECT model, price FROM pc 
	UNION
	SELECT model, price FROM laptop
	UNION
	SELECT model, price FROM printer) AS item
WHERE price IN (
	SELECT MAX(price)
	FROM (
		SELECT model, price FROM pc 
		UNION
		SELECT model, price FROM laptop
		UNION
		SELECT model, price FROM printer) AS item
)
INTO OUTFILE 'c:/tmp/assign.3.3.d.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# e)
SELECT m.maker
FROM printer p 
INNER JOIN product prod ON prod.model = p.model
INNER JOIN manf m ON m.maker = prod.maker
WHERE p.price IN (
	SELECT MIN(price)
	FROM printer p
	WHERE p.color = 1
)
INTO OUTFILE 'c:/tmp/assign.3.3.e.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# f)
SELECT DISTINCT m.maker
FROM pc p
INNER JOIN product prod ON prod.model = p.model
INNER JOIN manf m ON m.maker = prod.maker
WHERE p.speed IN (
	SELECT MAX(speed)
	FROM pc p
	WHERE p.ram IN (
		SELECT MIN(ram) FROM pc
	)
)
INTO OUTFILE 'c:/tmp/assign.3.3.f.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# 3.4
# a)
SELECT AVG(speed) FROM pc
INTO OUTFILE 'c:/tmp/assign.3.4.a.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# b)
SELECT AVG(speed)
FROM laptop l
WHERE l.price > 1000
INTO OUTFILE 'c:/tmp/assign.3.4.b.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# c)
SELECT AVG(price)
FROM pc p
INNER JOIN product prod ON prod.model = p.model
WHERE prod.maker = 'A'
INTO OUTFILE 'c:/tmp/assign.3.4.c.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# d)
SELECT AVG(computer.price)
FROM (
	SELECT model, price FROM pc
	UNION 
	SELECT model, price FROM laptop ) AS computer
INNER JOIN product prod ON prod.model = computer.model
WHERE prod.maker = 'B'
INTO OUTFILE 'c:/tmp/assign.3.4.d.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# e)
SELECT speed, AVG(price)
FROM pc
GROUP BY speed
INTO OUTFILE 'c:/tmp/assign.3.4.e.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# f)
SELECT p.maker, AVG(screen)
FROM laptop l
INNER JOIN product p on p.model = l.model
GROUP BY p.maker
INTO OUTFILE 'c:/tmp/assign.3.4.f.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# g)
SELECT m.makername, COUNT(*)
FROM pc p
INNER JOIN product prod ON prod.model = p.model
INNER JOIN manf m ON m.maker = prod.maker
GROUP BY m.makername
HAVING COUNT(*) >= 3
INTO OUTFILE 'c:/tmp/assign.3.4.g.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# h)
SELECT m.makername, MAX(price)
FROM pc p
INNER JOIN product prod ON prod.model = p.model
INNER JOIN manf m ON m.maker = prod.maker
GROUP BY m.makername
INTO OUTFILE 'c:/tmp/assign.3.4.h.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# i)
SELECT speed, AVG(price)
FROM pc
WHERE CAST(speed AS DECIMAL(3,2)) > 2.0
GROUP BY speed
INTO OUTFILE 'c:/tmp/assign.3.4.i.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# j)
SELECT AVG(p.hd)
FROM pc p
INNER JOIN product prod ON prod.model = p.model
WHERE prod.maker IN (
	SELECT prod.maker
	FROM printer p 
	INNER JOIN product prod ON prod.model = p.model
)
INTO OUTFILE 'c:/tmp/assign.3.4.j.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;

# 3.5
# a)
START TRANSACTION;
INSERT INTO pc VALUES (1100, 3.2, 1024, 180, 2400);
INSERT INTO product VALUES ('C', 1100, 'pc');
SELECT * 
FROM pc p
INNER JOIN product prod ON prod.model = p.model
WHERE p.model = 1100
INTO OUTFILE 'c:/tmp/assign.3.5.a.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;

# b)
START TRANSACTION;
INSERT INTO laptop
SELECT p.model + 100 AS model, speed, ram, hd, 17.0 AS screen, price + 500 AS price
FROM pc p;
SELECT * FROM laptop
INTO OUTFILE 'c:/tmp/assign.3.5.b.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;

# c)
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
DELETE FROM pc WHERE hd < 100;
SELECT * FROM pc
INTO OUTFILE 'c:/tmp/assign.3.5.c.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;
SET SQL_SAFE_UPDATES=1;

# d)
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
DELETE l
FROM laptop l 
INNER JOIN product p ON p.model = l.model
WHERE p.maker IN (
	SELECT DISTINCT p.maker
	FROM product p
	WHERE p.maker NOT IN (
		SELECT prod.maker
		FROM product prod
		INNER JOIN printer p ON prod.model = p.model
	)
);
SELECT * FROM laptop
INTO OUTFILE 'c:/tmp/assign.3.5.d.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;
SET SQL_SAFE_UPDATES=1;

# e)
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
UPDATE product p
SET p.maker = 'A'
WHERE p.maker = 'B';

SELECT * FROM product
INTO OUTFILE 'c:/tmp/assign.3.5.e.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;
SET SQL_SAFE_UPDATES=1;

# f)
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
UPDATE pc p
SET p.ram = p.ram*2, p.hd = p.hd + 60;

SELECT * FROM pc
INTO OUTFILE 'c:/tmp/assign.3.5.f.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;
SET SQL_SAFE_UPDATES=1;

# g)
SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
UPDATE laptop l
INNER JOIN product p ON l.model = p.model
SET l.screen = l.screen + 1.0, l.price = l.price - 100
WHERE p.maker = 'B';

SELECT * FROM laptop
INTO OUTFILE 'c:/tmp/assign.3.5.g.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
ROLLBACK;
SET SQL_SAFE_UPDATES=1;
