DROP DATABASE IF EXISTS hospital_801166050;
CREATE DATABASE hospital_801166050;

DROP TABLE IF EXISTS physician;
CREATE TABLE IF NOT EXISTS physician(
    id CHAR(6) NOT NULL,
    phy_name VARCHAR(30) DEFAULT NULL,
    certnum VARCHAR(20),
    phone VARCHAR(12) DEFAULT NULL,
    field VARCHAR(20),
    address varchar(50) DEFAULT NULL,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS nurse;
CREATE TABLE IF NOT EXISTS nurse(
    id CHAR(6) NOT NULL,
    nur_name VARCHAR(30) DEFAULT NULL,
    certnum VARCHAR(20),
    address varchar(50) DEFAULT NULL,
    phone VARCHAR(12) DEFAULT NULL,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS patient;
CREATE TABLE IF NOT EXISTS patient(
    id CHAR(6) NOT NULL,
    pat_name VARCHAR(30) DEFAULT NULL,
    address varchar(50) DEFAULT NULL,
    phone VARCHAR(12) DEFAULT NULL,
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS monitors;
CREATE TABLE IF NOT EXISTS monitors(
    physician_id CHAR(6),
    patient_id CHAR(6),
    duration VARCHAR(20),
    FOREIGN KEY (physician_id) REFERENCES physician(id),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

DROP TABLE IF EXISTS invoice;
CREATE TABLE IF NOT EXISTS invoice (
    id CHAR(6),
    pay_id CHAR(6) NOT NULL,
    charge DECIMAL(6,2) DEFAULT NULL,
    room_num CHAR(4) DEFAULT NULL,
    instruct_id CHAR(6) DEFAULT NULL,
    total decimal(10,2),
    PRIMARY KEY(pay_id),
    FOREIGN KEY (id) REFERENCES patient(id)
);

DROP TABLE IF EXISTS instruction;
CREATE TABLE IF NOT EXISTS instruction(
    pay_id CHAR(6),
    instruct_id CHAR(6) NOT NULL,
    fee DECIMAL(6,2),
    description VARCHAR(20),
    PRIMARY KEY(instruct_id),
    FOREIGN KEY (pay_id) REFERENCES invoice(pay_id)
);

DROP TABLE IF EXISTS instruction_order;
CREATE TABLE IF NOT EXISTS instruction_order(
    physician_id CHAR(6),
    patient_id CHAR(6),
    instruct_id CHAR(6),
    description VARCHAR(20),
    order_date date DEFAULT NULL,
    FOREIGN KEY (physician_id) REFERENCES physician(id),
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (instruct_id) REFERENCES instruction(instruct_id)
);

DROP TABLE IF EXISTS instruction_execution;
CREATE TABLE IF NOT EXISTS instruction_execution(
    nurse_id CHAR(6),
    patient_id CHAR(6),
    instruct_id CHAR(6),
    execute_date date DEFAULT NULL,
    status VARCHAR(20),
    FOREIGN KEY (nurse_id) REFERENCES nurse(id),
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (instruct_id) REFERENCES instruction(instruct_id)
);

DROP TABLE IF EXISTS medication;
CREATE TABLE IF NOT EXISTS medication(
    patient_id CHAR(6),
    nurse_id CHAR(6),
    medication VARCHAR(20),
    amount VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patient(id),
    FOREIGN KEY (nurse_id) REFERENCES nurse(id)
);

DROP TABLE IF EXISTS health_record;
CREATE TABLE IF NOT EXISTS health_record(
    id CHAR(6) NOT NULL,
    disease VARCHAR(20) NOT NULL,
    record_date date NOT NULL,
    status VARCHAR(20),
    description VARCHAR(20),
    PRIMARY KEY(id, disease, record_date),
    FOREIGN KEY (id) REFERENCES patient(id)
);

DROP TABLE IF EXISTS room;
CREATE TABLE IF NOT EXISTS room(
    room_num CHAR(4) NOT NULL,
    pay_id CHAR(6),
    capacity CHAR(6),
    fee DECIMAL(6,2),
    PRIMARY KEY(room_num)
);

DROP TABLE IF EXISTS stays_in;
CREATE TABLE IF NOT EXISTS stays_in(
    room_num CHAR(4),
    id CHAR(6),
    duration VARCHAR(20),
    FOREIGN KEY (room_num) REFERENCES room(room_num),
    FOREIGN KEY (id) REFERENCES patient(id)
);

DROP TABLE IF EXISTS payment;
CREATE TABLE IF NOT EXISTS payment(
	id CHAR(6),
    pay_id CHAR(6),
    payment_num CHAR(6) NOT NULL,
    payment_date date DEFAULT NULL,
    amount decimal(6,2),
    PRIMARY KEY(payment_num),
    FOREIGN KEY (id) REFERENCES patient(id),
    FOREIGN KEY (pay_id) REFERENCES invoice(pay_id)
);

ALTER TABLE invoice ADD FOREIGN KEY (room_num) REFERENCES room(room_num);
ALTER TABLE invoice ADD FOREIGN KEY (instruct_id) REFERENCES instruction(instruct_id);
ALTER TABLE room ADD FOREIGN KEY (pay_id) REFERENCES invoice(pay_id);


/* Views */
/* View 1 - Display the names of physicians and patients along with the instruction id, description, and date ordered */
CREATE VIEW instructionsOrdered
AS 
SELECT DISTINCT phy_name, pat_name, instruction_order.instruct_id, description, order_date
FROM instruction_order
INNER JOIN physician ON physician.id = instruction_order.physician_id
INNER JOIN patient ON patient.id = instruction_order.patient_id
WHERE instruction_order.instruct_id IN (SELECT instruct_id FROM instruction_order)
AND patient.id IN (SELECT patient_id FROM instruction_order)
AND physician.id IN (SELECT physician_id FROM instruction_order);

/* View 2 - Display the names of nurses and patients along with the instruction id, status, and date executed */
CREATE VIEW instructionsExecuted
AS
SELECT DISTINCT nur_name, pat_name, instruction_execution.instruct_id, status, execute_date
FROM instruction_execution
INNER JOIN nurse ON nurse.id = instruction_execution.nurse_id
INNER JOIN patient ON patient.id = instruction_execution.patient_id
WHERE instruction_execution.instruct_id IN (SELECT instruct_id FROM instruction_execution)
AND patient.id IN (SELECT patient_id FROM instruction_execution)
AND nurse.id IN (SELECT nurse_id FROM instruction_execution);

/* View 3 - Display the names of nurses and patients along with the medication, and amount */
CREATE VIEW medicationsGiven
AS
SELECT DISTINCT nur_name, pat_name, medication, amount
FROM medication
INNER JOIN nurse ON nurse.id = medication.nurse_id
INNER JOIN patient ON patient.id = medication.patient_id
WHERE nurse.id IN (SELECT nurse_id FROM medication)
AND patient.id IN (SELECT patient_id FROM medication);


/* Trigger tables */
CREATE TABLE physician_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phy_name VARCHAR(30) DEFAULT NULL,
    certnum VARCHAR(20),
    phone VARCHAR(12) DEFAULT NULL,
    field VARCHAR(20),
    address varchar(50) DEFAULT NULL
);

CREATE TABLE nurse_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nur_name VARCHAR(30) DEFAULT NULL,
    certnum VARCHAR(20),
    address varchar(50) DEFAULT NULL,
    phone VARCHAR(12) DEFAULT NULL
);

CREATE TABLE patient_archive (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pat_name VARCHAR(30) DEFAULT NULL,
    address varchar(50) DEFAULT NULL,
    phone VARCHAR(12) DEFAULT NULL
);


/* Triggers */
CREATE TRIGGER beforePhysicianUpdate 
	BEFORE UPDATE ON physician
	FOR EACH ROW 
	INSERT INTO physician_audit
	SET action = 'update',
	phy_name = OLD.phy_name,
	certnum = OLD.certnum,
	phone = OLD.phone,
	field = OLD.field,
	address = OLD.address;
    

CREATE TRIGGER beforeNurseUpdate 
	BEFORE UPDATE ON nurse
	FOR EACH ROW 
	INSERT INTO nurse
	SET action = 'update',
	nur_name = OLD.nur_name,
	certnum = OLD.certnum,
	address = OLD.address,
    phone = OLD.phone;
    
    
CREATE TRIGGER beforePatientDelete
	BEFORE DELETE
    ON patient
    FOR EACH ROW
	INSERT INTO patient_archive(pat_name, address, phone)
	VALUES(OLD.pat_name, OLD.address, OLD.phone);
    