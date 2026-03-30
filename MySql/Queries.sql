#To create the database
create database Project;

#Ensure record counts match between the database and Power BI reports
SELECT COUNT(*) FROM Patient;
SELECT COUNT(*) FROM Visit;
SELECT COUNT(*) FROM Treatments;
SELECT COUNT(*) FROM LabResult;

#Identify missing or null values in key columns
SELECT * FROM Patient WHERE FirstName IS NULL OR LastName IS NULL;
SELECT * FROM Visit WHERE VisitType IS NULL OR VisitDate IS NULL;
SELECT * FROM Treatments WHERE TreatmentName IS NULL OR Status IS NULL;
SELECT * FROM LabResult WHERE TestName IS NULL OR Result IS NULL;

#Ensure data relationships are consistent across tables
SELECT v.VisitID, v.PatientID, p.PatientID
FROM Visit v
LEFT JOIN Patient p ON v.PatientID = p.PatientID
WHERE p.PatientID IS NULL;

SELECT t.TreatmentID, t.VisitID, v.VisitID
FROM Treatments t
LEFT JOIN Visit v ON t.VisitID = v.VisitID
WHERE v.VisitID IS NULL;

#Identify duplicate entries in key tables
SELECT PatientID, COUNT(*)
FROM Patient
GROUP BY PatientID
HAVING COUNT(*) > 1;

SELECT VisitID, COUNT(*)
FROM Visit
GROUP BY VisitID
HAVING COUNT(*) > 1;

#Compare sum or average values between SQL and Power BI
SELECT SUM(TreatmentCost) FROM Treatments;
SELECT AVG(Age) FROM Patient;

#Check query performance
SELECT * FROM Visit WHERE VisitDate BETWEEN '2023-01-01' AND '2023-12-31';

