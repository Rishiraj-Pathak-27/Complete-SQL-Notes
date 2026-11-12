CREATE DATABASE hospital_db;

USE hospital_db;

CREATE TABLE patients (
    patientId INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    disease VARCHAR(100)
);

CREATE TABLE doctors (
    doctorId INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE appointments (
    appointmentId INT PRIMARY KEY,
    patientId INT,
    doctorId INT,
    date VARCHAR(20),

    FOREIGN KEY (patientId) REFERENCES patients(patientId),
    FOREIGN KEY (doctorId) REFERENCES doctors(doctorId)
);	

SELECT user, host FROM mysql.user;