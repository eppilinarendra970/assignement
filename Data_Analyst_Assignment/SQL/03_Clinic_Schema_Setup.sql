-- Clinic Management System Schema Setup

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- Sample INSERT Data
INSERT INTO clinics (cid, clinic_name, city, state, country) 
VALUES 
('C001', 'HealthCare Plus', 'Mumbai', 'Maharashtra', 'India'),
('C002', 'Wellness Clinic', 'Delhi', 'Delhi', 'India'),
('C003', 'MedCare Center', 'Bangalore', 'Karnataka', 'India'),
('C004', 'City Hospital', 'Hyderabad', 'Telangana', 'India'),
('C005', 'Prime Health', 'Chennai', 'Tamil Nadu', 'India');

INSERT INTO customer (uid, name, mobile) 
VALUES 
('CUS001', 'Rajesh Kumar', '9876543210'),
('CUS002', 'Priya Singh', '9876543211'),
('CUS003', 'Amit Patel', '9876543212'),
('CUS004', 'Neha Sharma', '9876543213'),
('CUS005', 'Vikas Gupta', '9876543214'),
('CUS006', 'Ananya Verma', '9876543215'),
('CUS007', 'Rohan Desai', '9876543216'),
('CUS008', 'Pooja Nair', '9876543217'),
('CUS009', 'Suresh Iyer', '9876543218'),
('CUS010', 'Kavya Menon', '9876543219');

INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) 
VALUES 
('O001', 'CUS001', 'C001', 5000.00, '2021-10-15 10:30:00', 'Online'),
('O002', 'CUS002', 'C001', 3500.00, '2021-10-16 14:15:00', 'Offline'),
('O003', 'CUS003', 'C002', 7200.00, '2021-10-18 09:45:00', 'Online'),
('O004', 'CUS004', 'C002', 4800.00, '2021-10-20 11:20:00', 'Phone'),
('O005', 'CUS005', 'C003', 6100.00, '2021-10-22 15:30:00', 'Online'),
('O006', 'CUS006', 'C003', 2900.00, '2021-10-25 10:00:00', 'Offline'),
('O007', 'CUS007', 'C004', 8500.00, '2021-11-05 13:45:00', 'Online'),
('O008', 'CUS008', 'C004', 3200.00, '2021-11-10 16:20:00', 'Phone'),
('O009', 'CUS009', 'C005', 5500.00, '2021-11-15 10:30:00', 'Offline'),
('O010', 'CUS010', 'C005', 4100.00, '2021-11-20 14:00:00', 'Online');

INSERT INTO expenses (eid, cid, description, amount, datetime) 
VALUES 
('E001', 'C001', 'Staff Salary', 50000.00, '2021-10-30 12:00:00'),
('E002', 'C001', 'Medical Supplies', 15000.00, '2021-10-28 11:00:00'),
('E003', 'C002', 'Equipment Maintenance', 8000.00, '2021-10-25 10:30:00'),
('E004', 'C002', 'Utilities', 12000.00, '2021-10-31 09:00:00'),
('E005', 'C003', 'Staff Salary', 48000.00, '2021-10-30 12:00:00'),
('E006', 'C003', 'Medical Supplies', 18000.00, '2021-10-27 14:30:00'),
('E007', 'C004', 'Equipment Maintenance', 20000.00, '2021-11-10 10:00:00'),
('E008', 'C004', 'Staff Salary', 55000.00, '2021-11-15 12:00:00'),
('E009', 'C005', 'Utilities', 10000.00, '2021-11-20 09:30:00'),
('E010', 'C005', 'Medical Supplies', 16000.00, '2021-11-18 11:00:00');
