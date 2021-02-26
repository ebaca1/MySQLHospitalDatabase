
/* Query 1 - Find the name, address, and phone number of the patient with id "976445" */
SELECT pat_name, address, phone 
FROM patient
WHERE id = "976445";


/* Query 2 - Find the id, name, and phone number of all patients who live on Unionville Road. */
SELECT id, pat_name, phone 
FROM patient
WHERE address LIKE '%Unionville Road.';


/* Query 3 - Find the name and health record of the patient with id "887788" */
SELECT pat_name, disease, record_date, status, description 
FROM health_record, patient
WHERE patient.id = "887788"
AND health_record.id = "887788";


/* Query 4 - Find the amount and the date of the payment made by the patient with id "878886" */
SELECT amount, payment_date FROM payment
WHERE id = "878886";


/* Query 5 - Find the name and id of the patient who made a payment in the amount of "70.00" */
SELECT pat_name, patient.id FROM patient
INNER JOIN payment ON patient.id = payment.id
WHERE payment.amount = "70.00";


/* Query 6 - Find the number, capacity, and fee of the room with the lowest fee */
SELECT room_num, capacity, fee
FROM room
WHERE fee = (SELECT MIN(fee) FROM room);


/* Query 7 - List all physicians id, name, field, certification number, and phone number in order by their field */
SELECT id, phy_name, field, certnum, phone 
FROM physician
ORDER BY physician.field;


/* Join queries 8 - 10 */
/* Query 8 - List patients with the room they stay in (Include room number and duration from room, name and id from patient) */
SELECT patient.id, pat_name, room_num, duration 
FROM patient
INNER JOIN stays_in ON patient.id = stays_in.id
GROUP BY patient.id;


/* Query 9 - Find the name and field of the physician who monitors a patient with the first name "Misty" (Inlcude the patient's full name) */
SELECT phy_name, field, patient.pat_name
FROM physician
INNER JOIN monitors ON physician.id = monitors.physician_id
INNER JOIN patient ON monitors.patient_id = patient.id
WHERE patient.pat_name LIKE "%MISTY";


/* Query 10 - Find the name, id, and certification number of all nurses who execute an order given by an Obstetrician (Inlcude the Obstetrician's name) */
SELECT nurse.nur_name AS "Nurse name", nurse.id AS "Nurse id", nurse.certnum AS "Cerification number", physician.phy_name AS "Obstetrician name"
FROM nurse
INNER JOIN instruction_execution ON nurse.id = instruction_execution.nurse_id
INNER JOIN instruction_order ON instruction_execution.instruct_id = instruction_order.instruct_id
INNER JOIN physician ON instruction_order.physician_id = physician.id
WHERE physician.field = "Obstetrician";


/* Aggregation queries 11 - 13 */
/* Query 11 - Find the average fee of rooms over the course of 3 nights*/
SELECT TRIM((SUM(fee)/COUNT(fee))*3)+0 AS "Average Room Fee for 3 nights"
FROM room;


/* Query 12 - Find the total number of physicians, nurses, patients, and rooms available in the hospital*/
SELECT  COUNT(DISTINCT physician.id) AS "Number of available physicians", 
		COUNT(DISTINCT nurse.id) AS "Number of available nurses", 
		COUNT(DISTINCT patient.id) AS "Number of patients", 
		COUNT(DISTINCT room.room_num) AS "Number of available rooms" 
FROM physician, nurse, patient, room;


/* Query 13 - Find the id, name, field, and total number of instruction orders given by a physician with the last name "Booker" (Assume a name format of "lastname, firstname") */
SELECT id, phy_name, field, COUNT(instruction_order.physician_id) AS "Number of instruction orders"
FROM physician, instruction_order
WHERE phy_name LIKE "Booker,%"
AND instruction_order.physician_id = physician.id;


/* Nested queries 14 - 16 */
/* Query 14 - Find the id, name, address, and phone number of all patients who have made a payment of more than 30.00. Order by payment amount, largest to smallest. */
SELECT patient.id, pat_name, address, phone
FROM patient
INNER JOIN payment ON patient.id = payment.id
WHERE payment.id NOT IN (SELECT payment.id FROM payment WHERE amount <= 30.00)
ORDER BY payment.amount DESC;


/* Query 15 - Find the id, name, address, and phone number of all patients who were given an invoice with a total of over 100.00. */
SELECT DISTINCT patient.id, pat_name, address, phone
FROM patient
INNER JOIN invoice ON patient.id = invoice.id
WHERE invoice.id IN (SELECT invoice.id FROM invoice WHERE total > 100.00)
ORDER BY pat_name;


/* Query 16 - Find the id, name, phone and of all nurses who medicate a patient. Also include the name of the patient they medicate. */
SELECT DISTINCT nurse.id, nur_name, nurse.phone, pat_name
FROM nurse
INNER JOIN medication ON nurse.id = medication.nurse_id
INNER JOIN patient ON medication.patient_id = patient.id
WHERE nurse.id IN (SELECT medication.nurse_id FROM medication)
ORDER BY nurse.id;


/* Views 1 - 3 */
/* View 1 - Display the names of physicians and patients along with the instruction id, description, and date ordered */
SELECT * FROM instructionsOrdered;

/* View 2 - Display the names of nurses and patients along with the instruction id, status, and date executed */
SELECT * FROM instructionsExecuted;

/* View 3 - Display the names of nurses and patients along with the medication, and amount */
SELECT * FROM medicationsGiven;
