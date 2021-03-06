# CSCI 226, Assignment 2
# Sam Vang
CREATE DATABASE asn2;
USE asn2;

create table R1 (
K int NOT NULL, 
A int, 
B int, 
C int
);

create table R2 (
K int NOT NULL, 
D int, 
E int
);

create table R3 (
A int NOT NULL, 
A1 int, 
A2 int, 
A3 int
);

create table R4 (
B int NOT NULL, 
B1 int, 
B2 int
);

create table R5 (
C int NOT NULL, 
C1 int, 
C2 int, 
C3 int, 
C4 int, 
C5 int
);

INSERT INTO R1 VALUES (4, 2, 0, 6);
INSERT INTO R1 VALUES (5, 2, 0, 5);
INSERT INTO R1 VALUES (1, 1, 3, 8);
INSERT INTO R1 VALUES (2, 1, 3, 7);
INSERT INTO R1 VALUES (3, 2, 3, 3);

INSERT INTO R2 VALUES (4, 1, 6);
INSERT INTO R2 VALUES (5, 1, 5);
INSERT INTO R2 VALUES (1, 1, 8);
INSERT INTO R2 VALUES (2, 1, 7);
INSERT INTO R2 VALUES (3, 1, 3);

INSERT INTO R3 VALUES (2, 4, 6, 8);
INSERT INTO R3 VALUES (2, 4, 6, 8);
INSERT INTO R3 VALUES (1, 2, 3, 4);
INSERT INTO R3 VALUES (1, 2, 3, 4);
INSERT INTO R3 VALUES (2, 4, 6, 8);

INSERT INTO R4 VALUES (0, 0, 0);
INSERT INTO R4 VALUES (0, 0, 0);
INSERT INTO R4 VALUES (3, 9, 27);
INSERT INTO R4 VALUES (3, 9, 27);
INSERT INTO R4 VALUES (3, 9, 27);

INSERT INTO R5 VALUES (4, 2, 0, 6, 1, 6);
INSERT INTO R5 VALUES (5, 2, 0, 5, 1, 5);
INSERT INTO R5 VALUES (1, 1, 3, 8, 1, 8);
INSERT INTO R5 VALUES (2, 1, 3, 7, 1, 7);
INSERT INTO R5 VALUES (3, 2, 3, 3, 1, 3);

SELECT DISTINCT r1.K, r1.A, r1.B, r1.C, r2.D, r2.E, r3.A1, r3.A2, r3.A3, r4.B1, r4.B2
FROM R1 r1
INNER JOIN R2 r2 ON r1.K = r2.K
INNER JOIN R3 r3 ON r1.A = r3.A
INNER JOIN R4 r4 ON r1.B = r4.B;

SELECT r5.*
FROM R5 r5;

DROP TABLE R1;
DROP TABLE R2;
DROP TABLE R3;
DROP TABLE R4;
DROP TABLE R5;

DROP DATABASE asn2;