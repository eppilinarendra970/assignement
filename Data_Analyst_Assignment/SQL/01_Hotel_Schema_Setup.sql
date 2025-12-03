-- Hotel Management System Schema Setup

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(50),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Sample INSERT statements
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) 
VALUES 
('U001', 'John Doe', '9876543210', 'john@email.com', '123 Main Street'),
('U002', 'Jane Smith', '9876543211', 'jane@email.com', '456 Oak Avenue'),
('U003', 'Bob Johnson', '9876543212', 'bob@email.com', '789 Pine Road');

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) 
VALUES 
('B001', '2021-10-15 14:30:00', 'R101', 'U001'),
('B002', '2021-11-20 10:00:00', 'R202', 'U002'),
('B003', '2021-10-22 16:45:00', 'R103', 'U001');

INSERT INTO items (item_id, item_name, item_rate) 
VALUES 
('I001', 'Breakfast', 250.00),
('I002', 'Dinner', 500.00),
('I003', 'Room Service', 150.00);

INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) 
VALUES 
('BC001', 'B001', 'BILL001', '2021-10-15 18:00:00', 'I001', 2),
('BC002', 'B001', 'BILL001', '2021-10-16 19:00:00', 'I002', 1),
('BC003', 'B002', 'BILL002', '2021-11-20 12:00:00', 'I001', 3),
('BC004', 'B003', 'BILL003', '2021-10-23 10:00:00', 'I003', 2);
