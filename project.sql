CREATE DATABASE project;
USE project;

CREATE TABLE User (
user_id INT PRIMARY KEY AUTO_INCREMENT, 
user_name VARCHAR(100) NOT NULL,
user_mobile VARCHAR(15),
user_email VARCHAR(100),
user_address VARCHAR(255)
);

INSERT INTO User (user_name, user_mobile, user_email, user_address) VALUES
('Rishiraj Pathak', '9876543210', 'rishi@gmail.com', 'Nagpur'),
('Amit Sharma', '9123456780', 'amit@gmail.com', 'Mumbai'),
('Priya Verma', '9988776655', 'priya@gmail.com', 'Pune'),
('Neha Singh', '9090909090', 'neha@gmail.com', 'Delhi');

SELECT * FROM User;

CREATE TABLE Roles (
role_id INT PRIMARY KEY AUTO_INCREMENT,
role_name VARCHAR(100) NOT NULL,
role_desc VARCHAR(255) 
);

INSERT INTO Roles (role_name, role_desc) VALUES
('Admin', 'Full system access'),
('Developer', 'Handles issue development'),
('Customer', 'Raises tickets'),
('Support', 'Helpdesk support staff');

SELECT * FROM Roles;

CREATE TABLE Login (
login_id INT PRIMARY KEY AUTO_INCREMENT,
login_username VARCHAR(100) NOT NULL UNIQUE,
user_password VARCHAR(255) NOT NULL,
user_id INT,
login_role_id INT,
FOREIGN KEY (user_id) REFERENCES User(user_id),
FOREIGN KEY (login_role_id) REFERENCES Roles(role_id)
);

INSERT INTO Login (login_username, user_password, user_id, login_role_id) VALUES
('rishi_admin', 'admin123', 1, 1),
('amit_dev', 'dev123', 2, 2),
('priya_user', 'user123', 3, 3),
('neha_support', 'support123', 4, 4);

SELECT * FROM Login;

CREATE TABLE Permission (
per_id INT PRIMARY KEY AUTO_INCREMENT,
per_name VARCHAR(100),
per_module VARCHAR(100),
per_role_id INT,
FOREIGN KEY (per_role_id) REFERENCES Roles(role_id) );

INSERT INTO Permission (per_name, per_module, per_role_id) VALUES
('Create User', 'User Management', 1),
('Delete User', 'User Management', 1),
('Update Issue', 'Issue Module', 2),
('Create Ticket', 'Ticket Module', 3),
('Resolve Ticket', 'Ticket Module', 4);

SELECT * FROM Permission;

CREATE TABLE Issues (
issu_id INT PRIMARY KEY AUTO_INCREMENT,
issu_title VARCHAR(200),
issu_type VARCHAR(100),
issu_desc TEXT,
issu_strt_id INT,
issu_dvlp_id INT,
user_id INT,
FOREIGN KEY (user_id) REFERENCES User(user_id)
);

INSERT INTO Issues (issu_title, issu_type, issu_desc, issu_strt_id, issu_dvlp_id, user_id) VALUES
('Login Bug', 'Bug', 'User unable to login', 1, 2, 3),
('UI Enhancement', 'Feature', 'Improve dashboard layout', 1, 2, 3),
('Payment Error', 'Bug', 'Transaction failing randomly', 1, 2, 3);

SELECT * FROM Issues;

CREATE TABLE Ticket (
tkt_id INT PRIMARY KEY AUTO_INCREMENT,
tkt_desc TEXT,
tkt_type VARCHAR(100),
tkt_date DATE,
tkt_cus_id INT,
FOREIGN KEY (tkt_cus_id) REFERENCES User(user_id) );

INSERT INTO Ticket (tkt_desc, tkt_type, tkt_date, tkt_cus_id) VALUES
('Cannot login to system', 'Technical', '2026-02-20', 3),
('Need password reset', 'Support', '2026-02-22', 3),
('Facing payment issue', 'Technical', '2026-02-25', 2);

SELECT * FROM Ticket;

CREATE TABLE Track (
trk_id INT PRIMARY KEY AUTO_INCREMENT,
trk_type VARCHAR(100),
trk_desc TEXT,
trk_date DATE,
trk_place VARCHAR(100),
tkt_id INT,
FOREIGN KEY (tkt_id) REFERENCES Ticket(tkt_id) );

INSERT INTO Track (trk_type, trk_desc, trk_date, trk_place, tkt_id) VALUES
('Open', 'Ticket created', '2026-02-20', 'Online', 1),
('In Progress', 'Assigned to developer', '2026-02-21', 'Office', 1),
('Resolved', 'Password reset completed', '2026-02-23', 'Support Desk', 2);

SELECT * FROM Track;

CREATE TABLE Helpdesk (
hlpd_id INT PRIMARY KEY AUTO_INCREMENT,
hlpd_desc TEXT,
hlpd_type VARCHAR(100),
trk_id INT,
FOREIGN KEY (trk_id) REFERENCES Track(trk_id) );

INSERT INTO Helpdesk (hlpd_desc, hlpd_type, trk_id) VALUES
('Initial review done', 'Review', 1),
('Work started by developer', 'Processing', 2),
('Issue resolved successfully', 'Closure', 3);

SELECT * FROM Helpdesk;