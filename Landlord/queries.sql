
--------------------------------------------------------------
-- 4.1
-- List active tenants in alphabetical order,
-- with details of the addresses
-- and other characteristics of the apartments they rent.
--------------------------------------------------------------
-- 4.1 Variant 1
-- List active tenants in alphabetical order,
-- with personnumer, phone and email, expire date and rent per year
--------------------------------------------------------------
SELECT
CONCAT(Tenants.firstname, ' ', Tenants.lastname) as Name,
Tenants.personnummer as Personnummer,
Tenants.phone as Phone,
Tenants.email as Email,
Contracts.end_date as ExpireDate,
CONCAT(Contracts.rent, ' kr/year') as Rent
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Tenants.firstname ASC;

--------------------------------------------------------------
-- 4.1 Variant 2
-- List active tenants in alphabetical order,
-- with a bunch of other details not listed on variant 1
-- Also with a lot of CONCAT
--------------------------------------------------------------
SELECT
CONCAT(Tenants.firstname, ' ', Tenants.lastname) as Name,
CONCAT(Locations.street, ' ', Locations.nr, ' Lgh ', '1', floorlevel, LPAD(door, 2, '0'), ', ', municipality) as Full_Address,
Apartments.rooms as Rooms,
CONCAT(ROUND(Contracts.rent/12, 0), ' SEK') as Price_Next_Month,
CONCAT(Apartments.surface, ' m2') as Surface,
Apartments.floorlevel as Floorplan,
CONCAT(Locations.tract, ' ', Locations.block, ':', Locations.unit) as Tract_Block_Unit
FROM Tenants
INNER JOIN Contracts ON Tenants.tenant_id = Contracts.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE Contracts.end_date > CURDATE()
ORDER BY Tenants.firstname ASC;


--------------------------------------------------------------
-- 4.2
-- List tracts alphabetically, with data per block
-- on number of houses,
-- number of apartments,
-- and total square meters.
--------------------------------------------------------------
-- 4.2 Variant 1
-- List tracts alphabetically, with data per Tract
--------------------------------------------------------------
SELECT
UPPER(Tract) as Tract,
Block,
COUNT(DISTINCT unit) as Houses,
COUNT(apartment_id) as Apartments,
CONCAT(SUM(surface), ' m2') as Total_Surface
FROM Locations
INNER JOIN Apartments ON Locations.location_id = Apartments.location_id
GROUP BY tract, block
ORDER BY tract ASC, block ASC;

--------------------------------------------------------------
-- 4.2 Variant 2
-- List tracts alphabetically, with data per Tract with Tract Nr
--------------------------------------------------------------
SELECT
CONCAT(tract, ' ', block) as Block,
COUNT(DISTINCT unit) as Houses,
COUNT(apartment_id) as Apartments,
SUM(surface) as Total_Surface
FROM Locations
INNER JOIN Apartments ON Locations.location_id = Apartments.location_id
GROUP BY tract, block
ORDER BY tract ASC, block ASC;

--------------------------------------------------------------
-- 4.2 Variant 3
-- Another variation with more details about Tract, Now Tract, Block, and Unit
--------------------------------------------------------------
SELECT CONCAT(UPPER(tract), ' ', UPPER(block), ':', UPPER(unit)) as Block,
COUNT(apartment_id) as Apartments,
CONCAT(SUM(surface), ' m2') as Total_Surface
FROM Locations
INNER JOIN Apartments ON Locations.location_id = Apartments.location_id
GROUP BY tract, block, unit
ORDER BY tract ASC, block ASC, unit ASC;


--------------------------------------------------------------
-- 4.3
-- List data on number of blocks,
-- number of houses, number of apartments,
-- and total number of square metres, grouped by tract name.
--------------------------------------------------------------
-- 4.3 Variant 1
-- List Tract, Blocks, Houses, Apartments, and Total Surface
--------------------------------------------------------------
SELECT UPPER(Tract) as Tract,
COUNT(DISTINCT block) as Blocks,
COUNT(DISTINCT apartments.location_id) as Houses,
COUNT(apartment_id) as Apartments,
CONCAT(SUM(surface), ' m2') as Total_Surface
FROM Locations
INNER JOIN Apartments ON Locations.location_id = Apartments.location_id
GROUP BY tract
ORDER BY tract ASC;


--------------------------------------------------------------
-- 4.4
-- List what the rents will be next calendar month for all unexpired leases
--------------------------------------------------------------
-- 4.4 Variant 1
-- Lists Contract, Tenant, Rent next Month
--------------------------------------------------------------
SELECT
CONCAT('Contract ', Apartments.apartment_id) as Contract,
CONCAT(Tenants.firstname, ' ', Tenants.lastname) as Tenant,
CONCAT(ROUND((Contracts.rent)/12, 0), ' SEK') as Rent_Next_Month
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Apartments.apartment_id ASC;


--------------------------------------------------------------
-- 4.4 Variant 2
-- Month, Active Contracts, Number of Apartments, Total Rent for all apartments
--------------------------------------------------------------
SELECT
MONTHNAME(DATE_ADD(CURDATE(), INTERVAL 1 MONTH)) as Month,
COUNT(DISTINCT Contracts.contract_id) as Active_Contracts,
COUNT(Apartments.apartment_id) as Apartments,
CONCAT(ROUND(SUM(Contracts.rent)/12, 0), ' SEK') as Price
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Tenants.firstname ASC;


--------------------------------------------------------------
-- 4.4 Variant 3
-- Just the Month and Total Income
--------------------------------------------------------------
SELECT
MONTHNAME(DATE_ADD(CURDATE(), INTERVAL 1 MONTH)) as Month,
CONCAT(ROUND(SUM(Contracts.rent)/12, 0), ' SEK') as Income
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Tenants.firstname ASC;


--------------------------------------------------------------
-- 4.4 Variant 4
-- List all active contracts with start and end date and rent next month
--------------------------------------------------------------
SELECT
DISTINCT Apartments.apartment_id as Apartment,
DATE_FORMAT(Contracts.start_date, '%d %M %Y') as Start_Date,
DATE_FORMAT(Contracts.end_date, '%d %M %Y') as End_Date,
CONCAT(ROUND((Contracts.rent)/12, 0), ' SEK') as Rent_Next_Month
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Apartments.apartment_id ASC;



--------------------------------------------------------------
----------------------------EXTRA-----------------------------
--------------------------------------------------------------
-- Extra Query 01
-- Name, ID, Birthday, Age using CONCAT and SUBSTRING
--------------------------------------------------------------
SELECT
CONCAT(Tenants.firstname, ' ', Tenants.lastname) as Name,
Tenants.personnummer as ID,
--SUBSTRING(Tenants.personnummer, 1, 4) as Year,
--SUBSTRING(Tenants.personnummer, 5, 2) as Month,
--SUBSTRING(Tenants.personnummer, 7, 2) as Day,
DATE_FORMAT(CONCAT(SUBSTRING(Tenants.personnummer, 1, 4), '-', SUBSTRING(Tenants.personnummer, 5, 2), '-', SUBSTRING(Tenants.personnummer, 7, 2)), '%d %M %Y') as Birthday,
(YEAR(CURDATE()) - SUBSTRING(Tenants.personnummer, 1, 4)) as Age
FROM Tenants
ORDER BY Tenants.firstname ASC;
--ORDER BY Age DESC;

--------------------------------------------------------------
-- Extra Query 02
-- List all tracts
--------------------------------------------------------------
SELECT DISTINCT tract as Tract
FROM Locations
ORDER BY tract ASC;

--------------------------------------------------------------
-- Extra Query 03
-- List number of tenants active or not
-- average age rounded with 1 decimal, youngest and oldest
--------------------------------------------------------------
SELECT
COUNT(DISTINCT Tenants.tenant_id) as Tenants,
ROUND(AVG(YEAR(CURDATE()) - SUBSTRING(Tenants.personnummer, 1, 4)), 1) as Average_Age,
MIN(YEAR(CURDATE()) - SUBSTRING(Tenants.personnummer, 1, 4)) as Youngest,
MAX(YEAR(CURDATE()) - SUBSTRING(Tenants.personnummer, 1, 4)) as Oldest
FROM Tenants
ORDER BY Tenants.firstname ASC;

--------------------------------------------------------------
-- Extra Query 04
-- Price per square meter of active contracts
--------------------------------------------------------------
SELECT
CONCAT(ROUND((Contracts.rent/Apartments.surface), 0), ' SEK') as Price_per_Square_Meter
FROM Contracts
INNER JOIN Tenants ON Contracts.tenant_id = Tenants.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
WHERE Contracts.end_date > CURDATE()
AND Tenants.tenant_id IS NOT NULL
ORDER BY Price_per_Square_Meter DESC;


--------------------------------------------------------------
-- Extra Query 05
-- Post address of every apartment to know where to send the invoices ;)
-- Didn't bother with the postal code
--------------------------------------------------------------
SELECT CONCAT(street, ' ', nr, ' Lgh ', '1', floorlevel, LPAD(door, 2, '0'), ', ', municipality) as PostAddress
FROM Apartments
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
ORDER BY PostAddress ASC;

--------------------------------------------------------------
-- Extra Query 06
-- List the tenants that have a gmail email address
--------------------------------------------------------------
SELECT * FROM Tenants WHERE Email LIKE '%gmail.com';

--------------------------------------------------------------
-- Extra Query 07
-- List the tenants born in 1984 based on the first 4 numbers from personnummer
--------------------------------------------------------------
SELECT * FROM Tenants WHERE Personnummer LIKE '1984%';

--------------------------------------------------------------
-- Extra Query 08
-- List the tenants that have a phone number that ends with 9
--------------------------------------------------------------
SELECT * FROM Tenants WHERE Phone LIKE '%9';

--------------------------------------------------------------
-- Extra Query 09
-- List the address of the apartments with the highest surface
--------------------------------------------------------------
SELECT street, nr, unit, surface FROM Apartments
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE surface = (SELECT MAX(surface) FROM Apartments);

--------------------------------------------------------------
-- Extra Query 10
-- List the address of the apartments with the lowest surface
--------------------------------------------------------------
SELECT
street,
nr,
unit,
surface
FROM Apartments
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE surface = (SELECT MIN(surface) FROM Apartments);

--------------------------------------------------------------
-- Extra Query 11
-- List the adress of the apartments above floorlevel 5 and their surface
--------------------------------------------------------------
SELECT
CONCAT(street, ' ', nr) as Address,
floorlevel,
door,
surface
FROM Apartments
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE floorlevel > 5;

--------------------------------------------------------------
-- Extra Query 12
-- Calculate the total surface of all apartaments from location_id 16
--------------------------------------------------------------
SELECT CONCAT(SUM(surface), ' kvm')as TotalSurface FROM Apartments WHERE location_id = 16;

--------------------------------------------------------------
-- Extra Query 13
-- Calculate the total surface of all apartments
--------------------------------------------------------------
SELECT CONCAT(SUM(surface), ' m2') as TotalSurface FROM Apartments;

--------------------------------------------------------------
-- Extra Query 14
-- Calculate the total surface of all apartments with x rooms
--------------------------------------------------------------
SELECT
SUM(surface) as Total_Surface
FROM Apartments WHERE rooms = 6;

--------------------------------------------------------------
-- Extra Query 15
-- List the apartments with 6 rooms
--------------------------------------------------------------
SELECT * FROM Apartments WHERE rooms = 6;

--------------------------------------------------------------
-- Extra Query 16
-- List all tracts with the tenants median age
--------------------------------------------------------------
SELECT DISTINCT UPPER(tract) as Tract,
ROUND(AVG(YEAR(CURDATE()) - SUBSTRING(Tenants.personnummer, 1, 4)), 1) as Average_Age
FROM Locations, Tenants
WHERE Locations.location_id = Tenants.tenant_id
GROUP BY tract
ORDER BY tract ASC;

--------------------------------------------------------------
-- Extra Query 17
-- Show the apartments on a single address
-- Strets are Eskadervägen 26-48, Lahällsvägen 11, 22, 33, Storgatan 111
--------------------------------------------------------------
SELECT
CONCAT(street, ' ', nr, ' Lgh', '1', floorlevel, LPAD(door, 2, '0')) as Address,
surface,
rooms,
floorlevel
FROM Apartments
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE street = 'Storgatan'
AND nr = 111;

--------------------------------------------------------------
-- Extra Query 18
-- List all tracts with the highest floorlevel
--------------------------------------------------------------
SELECT DISTINCT tract as Tract,
MAX(floorlevel) as Highest_Floorlevel
FROM Locations, Apartments
WHERE Locations.location_id = Apartments.location_id
GROUP BY tract
ORDER BY tract ASC;


--------------------------------------------------------------
-- Extra Query 19
-- List all tracts with the highest rent from Contracts
--------------------------------------------------------------
SELECT DISTINCT tract as Tract,
MAX(rent) as Highest_Rent
FROM Locations, Contracts
WHERE Locations.location_id = Contracts.apartment_id
GROUP BY tract
ORDER BY tract ASC;


--------------------------------------------------------------
-- Extra Query 20
-- Show all the tenats who are or living or lived in a specific Tract
--------------------------------------------------------------
SELECT * FROM Tenants
INNER JOIN Contracts ON Tenants.tenant_id = Contracts.tenant_id
INNER JOIN Apartments ON Contracts.apartment_id = Apartments.apartment_id
INNER JOIN Locations ON Apartments.location_id = Locations.location_id
WHERE tract = 'Staden';


--------------------------------------------------------------
-- Fun Queries
--------------------------------------------------------------


-- Fun 01
-- List info for every building but using CASE for some extra fun
SELECT
CONCAT('Buiding ', address_FK) AS Buiding,
CONCAT(CASE
WHEN COUNT(DISTINCT level) = 1 THEN 'level'
ELSE 'levels'
END, ' ', COUNT(DISTINCT level)) AS Floors,
CONCAT(COUNT(DISTINCT apartment_ID), ' apartments') AS Apartments,
CONCAT(CASE
WHEN COUNT(DISTINCT person_ID) = 1 THEN 'person'
ELSE 'persons'
END, ' ', COUNT(DISTINCT person_ID)) AS Persons,
COUNT(DISTINCT lease_ID) AS Leases
FROM Floorlevel
JOIN Apartment
ON Floorlevel.floorlevel_ID = Apartment.floorlevel_FK
JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
JOIN Person
ON Lease.lease_ID = Person.lease_FK
GROUP BY address_FK;

-- Fun 02
-- Same query but clean
SELECT
address_FK AS Buiding,
COUNT(DISTINCT level) AS Floors,
COUNT(DISTINCT apartment_ID) AS Apartments,
COUNT(DISTINCT person_ID) AS Persons,
COUNT(DISTINCT lease_ID) AS Leases
FROM Floorlevel
JOIN Apartment
ON Floorlevel.floorlevel_ID = Apartment.floorlevel_FK
JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
JOIN Person
ON Lease.lease_ID = Person.lease_FK
GROUP BY address_FK;

-- Fun 03
-- List the apartments with more than 1 tenant
SELECT
apartment_ID AS Apartment,
CONCAT(COUNT(person_ID), ' persons') AS Persons,
CONCAT(ROUND(SUM(anual_rent) / 2), ' kr') AS Total_anual_rent
FROM Apartment
JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
JOIN Person
ON Lease.lease_ID = Person.lease_FK
GROUP BY apartment_ID
HAVING COUNT(person_ID) > 1;

-- Fun 04
-- List the total anual rent for each building
SELECT
CONCAT('Buiding ', address_FK) AS Buiding,
CONCAT(COUNT(DISTINCT level), ' levels') AS Floors,
CONCAT(COUNT(apartment_ID), ' apartments') AS Apartments,
CONCAT(ROUND(SUM(anual_rent)), ' kr') AS Total_anual_rent
FROM Floorlevel
JOIN Apartment
ON Floorlevel.floorlevel_ID = Apartment.floorlevel_FK
JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
GROUP BY address_FK;

-- Fun 05
-- List the amount of floorlevels in each building
SELECT
CONCAT('Buiding ', address_FK) AS Buiding,
CONCAT(COUNT(DISTINCT level), ' levels') AS Floors
FROM Floorlevel
GROUP BY address_FK;

-- Fun 06
-- Address and Fastighetsbeteckning
SELECT
CONCAT('Building ', house_ID) AS Building,
municipality AS Municipality,
tract AS Tract,
block AS Block,
unit AS UNIT,
street_name AS Street,
street_nr AS Number
FROM House
JOIN Block
ON House.block_FK = Block.block_ID
JOIN Address
ON House.block_FK = Address.address_ID
ORDER BY Building;

-- Fun 07
-- List leases that are expiring in 2025
SELECT
CONCAT('Lease nr: ', lease_ID) AS Lease,
DATE_FORMAT(end_date, '%d %M %Y') AS Expire_Date
FROM Lease
WHERE YEAR(end_date) = 2025
ORDER BY end_date ASC;

-- Fun 08
-- List the leases that expire in the next 12 months
SELECT
CONCAT('Hyresavtal nr: ', lease_ID) AS Hyresavtal,
DATE_FORMAT(end_date, '%d %M %Y') AS Avslutas
FROM Lease
WHERE end_date > CURDATE()
AND end_date < DATE_ADD(CURDATE(), INTERVAL 12 MONTH)
ORDER BY end_date ASC;

-- Fun 09
-- Use describe to see the table Format
DESCRIBE Lease;
DESCRIBE Person;
DESCRIBE Apartment;
DESCRIBE Address;

-- Fun 10
-- Show availability
SELECT
CONCAT('Lägenhet nr: ', apartment_ID) AS Lägenhet,
CONCAT(rooms, ' rum') AS Rum,
surface AS Area,
CASE
WHEN end_date < CURDATE() OR end_date IS NULL THEN 'Inte upptagen'
ELSE 'Upptagen'
END AS Status
FROM Apartment
LEFT JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
ORDER BY surface DESC;

-- Fun 11
-- List all the tenants without email or phone
SELECT
CONCAT(firstname, ' ', lastname) AS Name,
email,
phone
FROM Person
WHERE email IS NULL OR phone IS NULL
ORDER BY firstname;

-- Fun 12
-- Number of apearences of each name
SELECT
firstname AS Firstname,
COUNT(firstname) AS Number_of_apearances
FROM Person
GROUP BY firstname
ORDER BY Number_of_apearances DESC
LIMIT 10;

-- Fun 13
-- Select top 3 apartments order by the highest surface descending
SELECT
CONCAT('Apartment nr: ', apartment_ID) AS Apartment,
surface AS Surface,
CONCAT(rooms, ' rooms') AS Rooms
FROM Apartment
ORDER BY surface DESC
LIMIT 3;

-- Fun 14
-- Price per square meter for each apartment
SELECT
CONCAT('Lägenhet nr: ', apartment_ID) AS Lägenhet,
surface AS Area,
CONCAT(rooms, ' rum') AS Rum,
ROUND(anual_rent / 12 / surface, 1) AS Pris_per_kvadratmeter
FROM Apartment
JOIN Lease
ON Apartment.apartment_ID = Lease.apartment_FK
WHERE end_date > CURDATE()
ORDER BY Pris_per_kvadratmeter DESC
LIMIT 5;

-- Fun 15
-- Select the users with the phone number ending with 4
SELECT
CONCAT(firstname, ' ', lastname) AS Name,
phone AS Phone
FROM Person
WHERE phone LIKE '%4'
ORDER BY firstname;

-- Fun 16
-- Select tenats with the email address ending with .com
SELECT
CONCAT(firstname, ' ', lastname) AS Name,
email
FROM Person
WHERE email LIKE '%.com'
ORDER BY firstname;

-- Fun 17
-- List the tenats with the highest rent per square meter
SELECT
CONCAT('Lease nr: ', lease_ID) AS Active_Lease,
CONCAT(ROUND(anual_rent / 12), ' kr') AS Rent_per_month,
ROUND(anual_rent / 12 / surface, 1) AS Price_per_m2,
CONCAT(firstname, ' ', lastname) AS Name,
DATE_FORMAT(CONCAT(SUBSTRING(person_nr, 1, 4), '-', SUBSTRING(person_nr, 5, 2), '-', SUBSTRING(person_nr, 7, 2)), '%d %M %Y') AS Birthday,
(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)) AS Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
JOIN Apartment
ON Lease.apartment_FK = Apartment.apartment_ID
WHERE end_date > CURDATE()
ORDER BY Price_per_m2 DESC
LIMIT 10;

-- Fun 18
-- More info
SELECT
CONCAT('Lease nr: ', lease_ID) AS Active_Lease,
CONCAT(ROUND(anual_rent / 12), ' kr') AS Rent_per_month,
CONCAT(ROUND(anual_rent / 12 / surface, 1), ' kr/m2') AS Price_per_m2,
CONCAT(rooms, ' rooms') AS Rooms,
CONCAT(firstname, ' ', lastname) AS Name,
DATE_FORMAT(CONCAT(SUBSTRING(person_nr, 1, 4), '-', SUBSTRING(person_nr, 5, 2), '-', SUBSTRING(person_nr, 7, 2)), '%d %M %Y') AS Birthday,
(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)) AS Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
JOIN Apartment
ON Lease.apartment_FK = Apartment.apartment_ID
WHERE end_date > CURDATE() OR end_date IS NULL
ORDER BY Price_per_m2;

-- Fun 19
-- List the average age for all active tenants, grouped by tract
SELECT
UPPER(tract) AS Tract,
ROUND(AVG(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)), 1) AS Average_Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
JOIN Apartment
ON Lease.apartment_FK = Apartment.apartment_ID
JOIN Floorlevel
ON Apartment.floorlevel_FK = Floorlevel.floorlevel_ID
JOIN Address
ON Floorlevel.address_FK = Address.address_ID
JOIN House
ON Address.house_FK = House.house_ID
JOIN Block
ON House.block_FK = Block.block_ID
WHERE end_date > CURDATE() OR end_date IS NULL
GROUP BY tract
ORDER BY tract;

-- Fun 20
-- List the average age for all inactive tenants
SELECT
ROUND(AVG(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)), 1) AS Average_Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
WHERE end_date < CURDATE();

-- Fun 21
-- List the average age for all active tenants
SELECT
ROUND(AVG(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)), 1) AS Average_Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
WHERE end_date > CURDATE() OR end_date IS NULL;

-- Fun 22
-- List the names of active tennants, with birthday and age
SELECT
CONCAT(firstname, ' ', lastname) AS Name,
DATE_FORMAT(CONCAT(SUBSTRING(person_nr, 1, 4), '-', SUBSTRING(person_nr, 5, 2), '-', SUBSTRING(person_nr, 7, 2)), '%d %M %Y') AS Birthday,
(YEAR(CURDATE()) - SUBSTRING(person_nr, 1, 4)) AS Age
FROM Person
JOIN Lease
ON Person.lease_FK = Lease.lease_ID
WHERE end_date > CURDATE() OR end_date IS NULL
ORDER BY firstname;
