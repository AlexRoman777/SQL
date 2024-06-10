
-- A procedeure for updating the anual_rent for every active lease
CREATE PROCEDURE update_anual_rent()
BEGIN
UPDATE Lease
SET anual_rent = anual_rent * 1.2
WHERE end_date > CURDATE() OR end_date IS NULL;
UPDATE Lease
SET end_date = CURDATE()
WHERE end_date > CURDATE() OR end_date IS NULL;
INSERT INTO Lease (anual_rent, start_date, end_date, apartment_FK)
SELECT anual_rent, CURDATE(), end_date, apartment_FK
FROM Lease
WHERE end_date > CURDATE() OR end_date IS NULL;
END;


-- Show active leases
SELECT * FROM Lease
WHERE end_date > CURDATE() OR end_date IS NULL;

CALL update_anual_rent();

DROP TRIGGER IF EXISTS Price;
