
INSERT INTO physician VALUE ("123456", "Lindsey, Jeremy", "999999", "704-123-0123", "Pediatrcian", "123 Main Street.");
INSERT INTO physician VALUE ("234567", "Booker, Julia","888888", "616-321-4321", "Obstetrician", "2356 Apartment Road.");
INSERT INTO physician VALUE ("987321", "Mcfarland, Cleetus","555555", "876-123-8520", "Surgeon", "987 Desoto Lane.");
INSERT INTO physician VALUE ("654123", "Bool, Jeb","333333", "789-456-3210", "Anethesiologist", "5213 Townhome Circle.");
INSERT INTO physician VALUE ("147852", "Rankin, Ruby","111222", "798-258-3690", "Surgeon", "185 Street Road.");

INSERT INTO nurse VALUE ("111111", "Jenkins, Melody","222333", "135 Street Lane.", "797-254-3790");
INSERT INTO nurse VALUE ("122211", "Travis, Randy","211333", "1689 Apartment Lane.", "704-234-8791");
INSERT INTO nurse VALUE ("111113", "Savage, Erik","244443", "222 2nd Street NW.", "777-159-9090");
INSERT INTO nurse VALUE ("123211", "Salmon, Devon","211337", "852 Jenkins Road.", "123-987-1590");
INSERT INTO nurse VALUE ("888888", "Jass, Jeremiah","444333", "135 RoadStreet Lane.", "616-897-2580");

INSERT INTO patient VALUE ("887788", "Jenkins, Jeremy", "135 Street Lane.", "797-897-2580");
INSERT INTO patient VALUE ("878886", "Mizzle, Misty", "789 Unionville Road.", "586-741-0000");
INSERT INTO patient VALUE ("878555", "Hilton, AJ", "651 Unionville Road.", "616-741-0550");
INSERT INTO patient VALUE ("876655", "Yule, Rohit", "632 Monroe Road.", "716-747-0531");
INSERT INTO patient VALUE ("976445", "Yoo, Yuri", "431 Matthews Street.", "717-747-5555");

INSERT INTO monitors VALUE ("987321", "976445", "3 days");
INSERT INTO monitors VALUE ("147852", "887788", "7 days");
INSERT INTO monitors VALUE ("123456", "876655", "2 days");
INSERT INTO monitors VALUE ("234567", "878555", "2 weeks");
INSERT INTO monitors VALUE ("654123", "878886", "2 days");

INSERT INTO invoice VALUE ("887788", "123456", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("878886", "234567", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("878555", "777777", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("876655", "444444", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("976445", "987654", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("878555", "555555", NULL, NULL, NULL, NULL);
INSERT INTO invoice VALUE ("976445", "111111", NULL, NULL, NULL, NULL);

INSERT INTO room VALUE ("1234", "123456", "2", 200.00);
INSERT INTO room VALUE ("2222", "234567", "2", 250.00);
INSERT INTO room VALUE ("3003", "777777", "3", 275.00);
INSERT INTO room VALUE ("1200", "444444", "4", 500.00);
INSERT INTO room VALUE ("1259", "987654", "1", 100.00);

INSERT INTO instruction VALUE ("123456", "123", 25.00, "Order/use knee brace");
INSERT INTO instruction VALUE ("234567", "456", 75.00, "Physical therapy");
INSERT INTO instruction VALUE ("777777", "789", 105.00, "Sugar-free diet");
INSERT INTO instruction VALUE ("444444", "741", 65.50, "Order/use eye patch");
INSERT INTO instruction VALUE ("987654", "852", 32.00, "Chiropractic visits");

UPDATE invoice SET charge = "200.00", room_num = "1234", total = "200.00" WHERE pay_id = "123456";
UPDATE invoice SET charge = "25.00", instruct_id = "123", total = "25.00" WHERE pay_id = "555555";
UPDATE invoice SET charge = "105.00", instruct_id = "789", total = "105.00" WHERE pay_id = "111111";
UPDATE invoice SET charge = "250.00", room_num = "2222", total = "250.00" WHERE pay_id = "444444";
UPDATE invoice SET charge = "100.00", room_num = "1259", total = "100.00" WHERE pay_id = "987654";

INSERT INTO instruction_order VALUE ("123456", "887788", "123", "Order/use knee brace", "2015-03-01");
INSERT INTO instruction_order VALUE ("234567", "878555", "456", "Physical therapy", "2018-05-01");
INSERT INTO instruction_order VALUE ("654123", "876655", "789", "Sugar-free diet", "2020-03-08");
INSERT INTO instruction_order VALUE ("234567", "976445", "741", "Order/use eye patch", "2019-12-20");
INSERT INTO instruction_order VALUE ("147852", "887788", "852", "Chiropractic visits", "2015-09-29");

INSERT INTO instruction_execution VALUE ("888888", "887788", "123", "2015-03-01", "Proceeding well");
INSERT INTO instruction_execution VALUE ("111113", "878555", "456", "2018-05-01", "Patient relunctant");
INSERT INTO instruction_execution VALUE ("123211", "876655", "789", "2020-03-08", "Not effective");
INSERT INTO instruction_execution VALUE ("123211", "976445", "741", "2019-12-20", "Proceeding well");
INSERT INTO instruction_execution VALUE ("111113", "887788", "852", "2015-09-29", "Patient reluctant");

INSERT INTO medication VALUE ("887788", "122211", "Amitriptyline", "250 mg");
INSERT INTO medication VALUE ("887788", "122211", "Amlodipine", "50 mg");
INSERT INTO medication VALUE ("878886", "888888", "Acetaminophen", "200 mg");
INSERT INTO medication VALUE ("876655", "122211", "Adderall", "250 mg");
INSERT INTO medication VALUE ("976445", "888888", "Azithromycin", "1 capsule");

INSERT INTO health_record VALUE ("887788", "Diabetes", "2020-05-06", "Positive", "Pre-diabetic");
INSERT INTO health_record VALUE ("878886", "AFM", "2019-10-10", "Declining", "Acute Myelitis");
INSERT INTO health_record VALUE ("878555", "Alzheimers", "2018-02-06", "Positive", "Early stages");
INSERT INTO health_record VALUE ("876655", "Heart Disease", "2020-05-09", "Negative", "Stage C failure");
INSERT INTO health_record VALUE ("976445", "Diabetes", "2019-07-16", "Positive", "Type 2");

INSERT INTO stays_in VALUE ("1234", "887788", "2 days");
INSERT INTO stays_in VALUE ("2222", "976445", "4 days");
INSERT INTO stays_in VALUE ("1259", "878555", "3 days");
INSERT INTO stays_in VALUE ("3003", "876655", "2 days");
INSERT INTO stays_in VALUE ("1200", "878886", "7 days");

INSERT INTO payment VALUE ("887788", "123456", "852369", "2019-12-30", 78.60);
INSERT INTO payment VALUE ("976445", "234567", "963147", "2020-9-07", 23.33);
INSERT INTO payment VALUE ("878555", "777777", "123698", "2020-10-20", 70.00);
INSERT INTO payment VALUE ("876655", "444444", "741257", "2020-11-17", 50.00);
INSERT INTO payment VALUE ("878886", "987654", "987436", "2019-10-19", 25.00);

/* -For testing purposes-
SELECT * FROM patient;
SELECT * FROM physician;
SELECT * FROM nurse;
SELECT * FROM monitors;
SELECT * FROM invoice;
SELECT * FROM instruction;
SELECT * FROM instruction_order;
SELECT * FROM instruction_execution;
SELECT * FROM medication;
SELECT * FROM health_record;
SELECT * FROM room;
SELECT * FROM stays_in;
SELECT * FROM payment;
*/