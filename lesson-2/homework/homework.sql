IF OBJECT_ID('test_identity', 'U') IS NOT NULL DROP TABLE test_identity;
CREATE TABLE test_identity (
    id INT IDENTITY(1,1),
    name VARCHAR(50)
);
INSERT INTO test_identity (name) VALUES ('John'), ('Alice'), ('Bob'), ('Eve'), ('Michael');
DELETE FROM test_identity;
INSERT INTO test_identity (name) VALUES ('DeletedUser');
TRUNCATE TABLE test_identity;
INSERT INTO test_identity (name) VALUES ('TruncatedUser');
DROP TABLE test_identity;

CREATE TABLE data_types_demo (
    id INT,
    name VARCHAR(50),
    age INT,
    height FLOAT,
    is_student BIT,
    registration_date DATE,
    profile_image VARBINARY(MAX)
);
INSERT INTO data_types_demo (id, name, age, height, is_student, registration_date)
VALUES (1, 'John Doe', 30, 175.5, 1, '2023-01-15');

IF OBJECT_ID('photos', 'U') IS NOT NULL DROP TABLE photos;
CREATE TABLE photos (
    id INT,
    photo VARBINARY(MAX)
);
INSERT INTO photos (id, photo)
SELECT 1, BulkColumn FROM OPENROWSET(BULK 'image.jpg', SINGLE_BLOB) AS img;

IF OBJECT_ID('student', 'U') IS NOT NULL DROP TABLE student;
CREATE TABLE student (
    student_id INT,
    classes INT,
    tuition_per_class DECIMAL(10,2),
    total_tuition AS (classes * tuition_per_class)
);
INSERT INTO student (student_id, classes, tuition_per_class)
VALUES (1, 5, 100.00),
       (2, 3, 150.00),
       (3, 4, 120.00);
SELECT * FROM student;

IF OBJECT_ID('worker', 'U') IS NOT NULL DROP TABLE worker;
CREATE TABLE worker (
    id INT,
    name VARCHAR(50)
);
BULK INSERT worker
FROM 'workers.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
SELECT * FROM worker;
