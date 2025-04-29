CREATE DATABASE UNIEATS_DB;

USE UNIEATS_DB;

CREATE TABLE ROLES(
    ROLE_ID INT PRIMARY KEY AUTO_INCREMENT,
    ROLE_NAME VARCHAR(30) NOT NULL UNIQUE
);

/*
ROLES ASIGNADOS:
    1. Estudiante
    2. Profesor
    3. Administrativo
    4. Colaborador
*/

CREATE TABLE USERS(
    USER_ID INT PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME VARCHAR(50) NOT NULL,
    SECOND_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50) NOT NULL,
    SECOND_LAST_NAME VARCHAR(50) NOT NULL,
    CC_NUMBER VARCHAR(20) NOT NULL UNIQUE,
    INSTITUTIONAL_EMAIL VARCHAR(100) NOT NULL UNIQUE,
    ADDRESS VARCHAR(150),
    PASSWORD VARCHAR(255) NOT NULL,
    ROLE_ID INT NOT NULL,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ROLE_ID) REFERENCES ROLES(ROLE_ID),
    CHECK (CHAR_LENGTH(PASSWORD) >= 8)
);

CREATE TABLE PHONES(
    PHONE_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT NOT NULL,
    PHONE_NUMBER VARCHAR(20) NOT NULL,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
    ON DELETE CASCADE,
    CHECK (CHAR_LENGTH(PHONE_NUMBER) >= 10)
);

CREATE TABLE CAFES(
    CAFE_ID INT PRIMARY KEY AUTO_INCREMENT,
    CAFE_NAME VARCHAR(50) NOT NULL UNIQUE,
    CAFE_LOCATION VARCHAR(100) NOT NULL,
    COMPANY_NAME VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE WORKSTATION(
    WORKSTATION_ID INT PRIMARY KEY AUTO_INCREMENT,
    WORKSTATION_NAME VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE EMPLOYEES_CAFE(
    EMPLOYEES_ID INT PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME VARCHAR(50) NOT NULL,
    SECOND_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50) NOT NULL,
    SECOND_LAST_NAME VARCHAR(50) NOT NULL,
    CC_NUMBER VARCHAR(20) UNIQUE NOT NULL,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    ADDRESS VARCHAR(150),
    PASSWORD VARCHAR(255) NOT NULL,
    CAFE_ID INT NOT NULL,
    WORKSTATION_ID INT NOT NULL,
    HIRED_AT DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FIRED_AT DATETIME DEFAULT NULL,
    IS_ACTIVE BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (CAFE_ID) REFERENCES CAFES(CAFE_ID),
    FOREIGN KEY (WORKSTATION_ID) REFERENCES WORKSTATION(WORKSTATION_ID)
    ON DELETE CASCADE
);

CREATE TABLE CATEGORIES(
    CATEGORY_ID INT PRIMARY KEY AUTO_INCREMENT,
    CATEGORY_NAME VARCHAR(50) NOT NULL UNIQUE,
    CAT_DESCRIPTION TEXT
);

CREATE TABLE PRODUCTS(
    PRODUCT_ID INT PRIMARY KEY AUTO_INCREMENT,
    CATEGORY_ID INT NOT NULL,
    CAFE_ID INT NOT NULL,
    PRODUCT_NAME VARCHAR(100) NOT NULL UNIQUE,
    P_DESCRIPTION TEXT NULL,
    PRICE DECIMAL(10,2) NOT NULL,
    STOCK INT NOT NULL,
    FOREIGN KEY (CATEGORY_ID) REFERENCES CATEGORIES(CATEGORY_ID),
    FOREIGN KEY (CAFE_ID) REFERENCES CAFES(CAFE_ID),
    CHECK (PRICE > 0),
    CHECK (STOCK >= 0)
);

CREATE TABLE ORDERS(
    ORDER_ID INT PRIMARY KEY AUTO_INCREMENT,
    USER_ID INT NOT NULL,
    CAFE_ID INT NOT NULL,
    TAKEN_BY_EMPLOYEE_ID INT NOT NULL,
    DELIVERED_BY_EMPLOYEE_ID INT,
    ORDER_DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ORDER_STATUS ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL,
    TOTAL_AMOUNT DECIMAL(10,2) NOT NULL,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UPDATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID),
    FOREIGN KEY (CAFE_ID) REFERENCES CAFES(CAFE_ID),
    FOREIGN KEY (TAKEN_BY_EMPLOYEE_ID) REFERENCES EMPLOYEES_CAFE(EMPLOYEES_ID),
    FOREIGN KEY (DELIVERED_BY_EMPLOYEE_ID) REFERENCES EMPLOYEES_CAFE(EMPLOYEES_ID),
    CHECK (TOTAL_AMOUNT > 0)
);

CREATE TABLE ORDER_DETAILS(
    DETAIL_ID INT PRIMARY KEY AUTO_INCREMENT,
    ORDER_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    QUANTITY INT NOT NULL,
    UNIT_PRICE DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID),
    UNIQUE (ORDER_ID, PRODUCT_ID),
    CHECK (QUANTITY > 0),
    CHECK (UNIT_PRICE > 0)
); 

CREATE TABLE PAYMENT_METHODS(
    PAYMENT_METHOD_ID INT PRIMARY KEY AUTO_INCREMENT,
    METHOD_NAME VARCHAR(50) NOT NULL,
);

CREATE TABLE PAYMENTS(
    PAYMENT_ID INT PRIMARY KEY AUTO_INCREMENT,
    ORDER_ID INT NOT NULL,
    PAYMENT_METHOD_ID INT NOT NULL,
    AMOUNT_PAID DECIMAL(10,2) NOT NULL,
    PAYMENT_DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PAYMENT_STATUS ENUM('PAID', 'PENDING', 'CANCELLED') NOT NULL,
    REFERENCE_CODE VARCHAR(100) UNIQUE,
    IS_REFUNDED BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID),
    FOREIGN KEY (PAYMENT_METHOD_ID) REFERENCES PAYMENT_METHODS(PAYMENT_METHOD_ID)
    ON DELETE CASCADE,
    CHECK (AMOUNT_PAID > 0)
);

-- Insercion de registros en tabla ROLES

INSERT INTO ROLES (ROLE_NAME) VALUES
('Estudiante'),
('Profesor'),
('Administrativo'),
('Colaborador');

-- Inersercion de registros Cafeterias

INSERT INTO CAFES (CAFE_ID, CAFE_NAME, CAFE_LOCATION, COMPANY_NAME) VALUES 
(1, 'Cafeteria Principal', 'EAN Legacy, Piso 1', 'Cafeteria 1'), 
(2, 'Cafeteria 6 Piso', 'EAN Legacy, Piso 6', 'Cafeteria2'), 
(3, 'Cafeteria 4 Piso', 'EAN Legacy, Piso 4', 'Cafeteria 3'), 
(4, 'Cafeteria 4-2 Piso', 'EAN Nogal, Piso 4', 'Cafeteria 4'); 

-- Insercion de registros roles en tabla WORKSTATION

INSERT INTO WORKSTATION (WORKSTATION_NAME) VALUES
('Cajero'),
('Cocinero'),
('Limpieza Cocina'),
('Entregador'),
('Auxiliar de Caja'),
('Repostería'),
('Encargado Bebidas'),
('Plancha'),
('Freidora'),
('Asistente Cocina'),
('Supervisor General'),
('Atención al Cliente');

-- Insercion de registros en tabla USERS

INSERT INTO USERS (USER_ID, FIRST_NAME, SECOND_NAME, LAST_NAME, SECOND_LAST_NAME, CC_NUMBER, INSTITUTIONAL_EMAIL, ADDRESS, PASSWORD, ROLE_ID)
VALUES
(1, 'Luciana', 'Marcela', 'Medina', 'Jiménez', '10000001', 'luciana.medina1@universidadean.edu.co', 'Calle 49 #24-22', 'lucianamedina1#', 2),
(2, 'Juan', 'Beatriz', 'Moreno', 'Rodríguez', '10000002', 'juan.moreno2@universidadean.edu.co', 'Calle 37 #25-2', 'juanmoreno2#', 3),
(3, 'Oscar', 'Isabel', 'Ruiz', 'Cardona', '10000003', 'oscar.ruiz3@universidadean.edu.co', 'Calle 66 #30-10', 'oscarruiz3#', 4),
(4, 'Camilo', 'Josefina', 'Cruz', 'Ruiz', '10000004', 'camilo.cruz4@universidadean.edu.co', 'Calle 2 #5-1', 'camilocruz4#', 1),
(5, 'Felipe', 'Paola', 'Ortiz', 'Galvis', '10000005', 'felipe.ortiz5@universidadean.edu.co', 'Calle 60 #24-18', 'felipeortiz5#', 2),
(6, 'Simón', 'María', 'Luna', 'Rivera', '10000006', 'simón.luna6@universidadean.edu.co', 'Calle 36 #25-23', 'simónluna6#', 3),
(7, 'Kevin', 'Milena', 'Castaño', 'Herrera', '10000007', 'kevin.castaño7@universidadean.edu.co', 'Calle 35 #15-2', 'kevincastaño7#', 4),
(8, 'Francisco', 'Sofía', 'Salazar', 'Cardona', '10000008', 'francisco.salazar8@universidadean.edu.co', 'Calle 34 #20-30', 'franciscosalazar8#', 1),
(9, 'Jorge', 'Santiago', 'Carrillo', 'Holguín', '10000009', 'jorge.carrillo9@universidadean.edu.co', 'Calle 30 #18-30', 'jorgecarrillo9#', 2),
(10, 'Ricardo', 'Mauricio', 'Medina', 'Ramírez', '10000010', 'ricardo.medina10@universidadean.edu.co', 'Calle 25 #5-8', 'ricardomedina10#', 3),
(11, 'Catalina', 'Adrián', 'Hernández', 'Parra', '10000011', 'catalina.hernández11@universidadean.edu.co', 'Calle 23 #8-21', 'catalinahernández11#', 4),
(12, 'Jonathan', 'Hernando', 'Ruiz', 'Cortés', '10000012', 'jonathan.ruiz12@universidadean.edu.co', 'Calle 44 #16-12', 'jonathanruiz12#', 1),
(13, 'Mateo', 'Leonardo', 'Restrepo', 'Cuellar', '10000013', 'mateo.restrepo13@universidadean.edu.co', 'Calle 52 #24-11', 'mateorestrepo13#', 2),
(14, 'Tomás', 'Hernando', 'Mora', 'Quintero', '10000014', 'tomás.mora14@universidadean.edu.co', 'Calle 3 #18-22', 'tomásmora14#', 3),
(15, 'Camilo', 'Lucía', 'Ruiz', 'Zamora', '10000015', 'camilo.ruiz15@universidadean.edu.co', 'Calle 36 #23-16', 'camiloruiz15#', 4),
(16, 'Cristian', 'Victoria', 'Torres', 'Quintero', '10000016', 'cristian.torres16@universidadean.edu.co', 'Calle 59 #20-10', 'cristiantorres16#', 1),
(17, 'Adriana', 'Andrea', 'Vargas', 'Gómez', '10000017', 'adriana.vargas17@universidadean.edu.co', 'Calle 40 #28-3', 'adrianavargas17#', 2),
(18, 'Catalina', 'Angélica', 'Salazar', 'Cortés', '10000018', 'catalina.salazar18@universidadean.edu.co', 'Calle 6 #24-27', 'catalinasalazar18#', 3),
(19, 'Juan', 'Joel', 'Carrillo', 'Quintero', '10000019', 'juan.carrillo19@universidadean.edu.co', 'Calle 60 #4-4', 'juancarrillo19#', 4),
(20, 'Santiago', 'Beatriz', 'Villalba', 'Gómez', '10000020', 'santiago.villalba20@universidadean.edu.co', 'Calle 24 #21-18', 'santiagovillalba20#', 1),
(21, 'Ricardo', 'Hernando', 'Navarro', 'Holguín', '10000021', 'ricardo.navarro21@universidadean.edu.co', 'Calle 68 #21-5', 'ricardonavarro21#', 2),
(22, 'Tomás', 'Mauricio', 'Castañeda', 'Córdoba', '10000022', 'tomás.castañeda22@universidadean.edu.co', 'Calle 69 #22-19', 'tomáscastañeda22#', 3),
(23, 'Laura', 'Angélica', 'Patiño', 'Rivas', '10000023', 'laura.patiño23@universidadean.edu.co', 'Calle 66 #22-21', 'laurapatiño23#', 4),
(24, 'Francisco', 'Lucía', 'Gómez', 'Peña', '10000024', 'francisco.gómez24@universidadean.edu.co', 'Calle 64 #18-21', 'franciscogómez24#', 1),
(25, 'Kevin', 'Hernando', 'Castro', 'Cardona', '10000025', 'kevin.castro25@universidadean.edu.co', 'Calle 34 #3-25', 'kevincastro25#', 2),
(26, 'Gabriela', 'Esteban', 'Castro', 'Guzmán', '10000026', 'gabriela.castro26@universidadean.edu.co', 'Calle 18 #18-17', 'gabrielacastro26#', 3),
(27, 'Ricardo', 'Luis', 'Pérez', 'Quintero', '10000027', 'ricardo.pérez27@universidadean.edu.co', 'Calle 24 #28-5', 'ricardopérez27#', 4),
(28, 'Sara', 'Eduardo', 'Zapata', 'Córdoba', '10000028', 'sara.zapata28@universidadean.edu.co', 'Calle 68 #8-15', 'sarazapata28#', 1),
(29, 'Salomé', 'Santiago', 'Salazar', 'Salinas', '10000029', 'salomé.salazar29@universidadean.edu.co', 'Calle 54 #20-18', 'salomésalazar29#', 2),
(30, 'Camilo', 'José', 'Cruz', 'Rosales', '10000030', 'camilo.cruz30@universidadean.edu.co', 'Calle 11 #10-16', 'camilocruz30#', 3),
(31, 'Catalina', 'David', 'García', 'Padilla', '10000031', 'catalina.garcía31@universidadean.edu.co', 'Calle 7 #26-7', 'catalinagarcía31#', 4),
(32, 'Paula', 'Josefina', 'Gutiérrez', 'Velasco', '10000032', 'paula.gutiérrez32@universidadean.edu.co', 'Calle 68 #4-29', 'paulagutiérrez32#', 1),
(33, 'Francisco', 'Angélica', 'Ramírez', 'Espinosa', '10000033', 'francisco.ramírez33@universidadean.edu.co', 'Calle 62 #10-7', 'franciscoramírez33#', 2),
(34, 'Martín', 'Daniela', 'Gutiérrez', 'Osorio', '10000034', 'martín.gutiérrez34@universidadean.edu.co', 'Calle 66 #12-21', 'martíngutiérrez34#', 3),
(35, 'Diego', 'José', 'Ocampo', 'Herrera', '10000035', 'diego.ocampo35@universidadean.edu.co', 'Calle 25 #13-17', 'diegoocampo35#', 4),
(36, 'Simón', 'María', 'Álvarez', 'Padilla', '10000036', 'simón.álvarez36@universidadean.edu.co', 'Calle 56 #6-22', 'simónálvarez36#', 1),
(37, 'Juan', 'Natalia', 'Mejía', 'Rosales', '10000037', 'juan.mejía37@universidadean.edu.co', 'Calle 18 #2-7', 'juanmejía37#', 2),
(38, 'Brayan', 'Beatriz', 'Pérez', 'Espinosa', '10000038', 'brayan.pérez38@universidadean.edu.co', 'Calle 34 #13-10', 'brayanpérez38#', 3),
(39, 'Jorge', 'Alejandro', 'Gutiérrez', 'Castaño', '10000039', 'jorge.gutiérrez39@universidadean.edu.co', 'Calle 40 #12-14', 'jorgegutiérrez39#', 4),
(40, 'Daniela', 'Mauricio', 'Restrepo', 'Martínez', '10000040', 'daniela.restrepo40@universidadean.edu.co', 'Calle 28 #13-7', 'danielarestrepo40#', 1),
(41, 'Valentina', 'Felipe', 'Montenegro', 'Salazar', '10000041', 'valentina.montenegro41@universidadean.edu.co', 'Calle 7 #9-13', 'valentinamontenegro41#', 2),
(42, 'Martín', 'Paola', 'Rojas', 'Holguín', '10000042', 'martín.rojas42@universidadean.edu.co', 'Calle 18 #25-23', 'martínrojas42#', 3),
(43, 'Felipe', 'Emilio', 'Medina', 'Osorio', '10000043', 'felipe.medina43@universidadean.edu.co', 'Calle 43 #7-9', 'felipemedina43#', 4),
(44, 'Gabriela', 'Angélica', 'Silva', 'González', '10000044', 'gabriela.silva44@universidadean.edu.co', 'Calle 61 #24-10', 'gabrielasilva44#', 1),
(45, 'Sara', 'Andrea', 'Peña', 'Padilla', '10000045', 'sara.peña45@universidadean.edu.co', 'Calle 19 #26-23', 'sarapeña45#', 2),
(46, 'Mariana', 'Lucía', 'Ocampo', 'Arévalo', '10000046', 'mariana.ocampo46@universidadean.edu.co', 'Calle 7 #11-26', 'marianaocampo46#', 3),
(47, 'Mariana', 'Tatiana', 'Ortiz', 'Muñoz', '10000047', 'mariana.ortiz47@universidadean.edu.co', 'Calle 3 #21-11', 'marianaortiz47#', 4),
(48, 'Angela', 'Milena', 'Vargas', 'Velasco', '10000048', 'angela.vargas48@universidadean.edu.co', 'Calle 52 #1-22', 'angelavargas48#', 1),
(49, 'Laura', 'Josefina', 'Luna', 'Solano', '10000049', 'laura.luna49@universidadean.edu.co', 'Calle 7 #28-11', 'lauraluna49#', 2),
(50, 'Diana', 'Daniela', 'Mejía', 'Camacho', '10000050', 'diana.mejía50@universidadean.edu.co', 'Calle 56 #6-16', 'dianamejía50#', 3),
(51, 'Natalia', 'Luis', 'Delgado', 'Ortega', '10000051', 'natalia.delgado51@universidadean.edu.co', 'Calle 40 #5-28', 'nataliadelgado51#', 4),
(52, 'Sara', 'Armando', 'Pérez', 'Galvis', '10000052', 'sara.pérez52@universidadean.edu.co', 'Calle 56 #16-16', 'sarapérez52#', 1),
(53, 'Brayan', 'Angélica', 'Ríos', 'Palacios', '10000053', 'brayan.ríos53@universidadean.edu.co', 'Calle 9 #9-23', 'brayanríos53#', 2),
(54, 'Brayan', 'Paola', 'Ocampo', 'Buitrago', '10000054', 'brayan.ocampo54@universidadean.edu.co', 'Calle 17 #22-28', 'brayanocampo54#', 3),
(55, 'Cristian', 'Felipe', 'Villalba', 'Holguín', '10000055', 'cristian.villalba55@universidadean.edu.co', 'Calle 8 #11-9', 'cristianvillalba55#', 4),
(56, 'Paula', 'Fernanda', 'Navarro', 'Rivas', '10000056', 'paula.navarro56@universidadean.edu.co', 'Calle 16 #9-9', 'paulanavarro56#', 1),
(57, 'Daniela', 'Felipe', 'Aguilar', 'González', '10000057', 'daniela.aguilar57@universidadean.edu.co', 'Calle 6 #8-8', 'danielaaguilar57#', 2),
(58, 'Andrés', 'Antonio', 'Morales', 'Espinosa', '10000058', 'andrés.morales58@universidadean.edu.co', 'Calle 42 #27-19', 'andrésmorales58#', 3),
(59, 'Melissa', 'Sofía', 'Álvarez', 'Gómez', '10000059', 'melissa.álvarez59@universidadean.edu.co', 'Calle 30 #30-20', 'melissaálvarez59#', 4),
(60, 'Julián', 'Alexander', 'Zapata', 'Herrera', '10000060', 'julián.zapata60@universidadean.edu.co', 'Calle 46 #29-1', 'juliánzapata60#', 1),
(61, 'Valentina', 'Daniela', 'Mora', 'Peña', '10000061', 'valentina.mora61@universidadean.edu.co', 'Calle 46 #23-10', 'valentinamora61#', 2),
(62, 'David', 'Leonardo', 'Luna', 'Peña', '10000062', 'david.luna62@universidadean.edu.co', 'Calle 20 #12-27', 'davidluna62#', 3),
(63, 'María', 'Lucía', 'Morales', 'Gómez', '10000063', 'maría.morales63@universidadean.edu.co', 'Calle 59 #2-20', 'maríamorales63#', 4),
(64, 'Juan', 'Antonio', 'Vargas', 'Peña', '10000064', 'juan.vargas64@universidadean.edu.co', 'Calle 31 #22-2', 'juanvargas64#', 1),
(65, 'Cristian', 'Sofía', 'García', 'Buitrago', '10000065', 'cristian.garcía65@universidadean.edu.co', 'Calle 35 #14-6', 'cristiangarcía65#', 2),
(66, 'Simón', 'Isabel', 'López', 'Osorio', '10000066', 'simón.lópez66@universidadean.edu.co', 'Calle 52 #24-19', 'simónlópez66#', 3),
(67, 'Simón', 'Carolina', 'Carrillo', 'Holguín', '10000067', 'simón.carrillo67@universidadean.edu.co', 'Calle 56 #17-28', 'simóncarrillo67#', 4),
(68, 'Santiago', 'David', 'Castaño', 'Padilla', '10000068', 'santiago.castaño68@universidadean.edu.co', 'Calle 60 #30-15', 'santiagocastaño68#', 1),
(69, 'Isabella', 'Alberto', 'Castañeda', 'Holguín', '10000069', 'isabella.castañeda69@universidadean.edu.co', 'Calle 38 #11-2', 'isabellacastañeda69#', 2),
(70, 'Esteban', 'Esteban', 'Zapata', 'Valencia', '10000070', 'esteban.zapata70@universidadean.edu.co', 'Calle 26 #12-19', 'estebanzapata70#', 3);

-- Insercion registro Empleados Cafeterias Universidad EAN

INSERT INTO EMPLOYEES_CAFE (EMPLOYEES_ID, FIRST_NAME, SECOND_NAME, LAST_NAME, SECOND_LAST_NAME, CC_NUMBER, EMAIL, ADDRESS, PASSWORD, CAFE_ID, WORKSTATION_ID)
VALUES
(101, 'Camila', 'Luis', 'García', 'Solano', '0101', 'camila.garcía0101@unieats.com', 'Calle 19 #8-15', 'camilagarcía0101emp#', 1, 10),
(102, 'Diana', 'Margarita', 'Mejía', 'Padilla', '0102', 'diana.mejía0102@unieats.com', 'Calle 46 #24-18', 'dianamejía0102emp#', 1, 9),
(103, 'Tomás', 'Sofía', 'Moreno', 'Muñoz', '0103', 'tomás.moreno0103@unieats.com', 'Calle 54 #15-3', 'tomásmoreno0103emp#', 1, 1),
(104, 'Adriana', 'José', 'Castañeda', 'Ramírez', '0104', 'adriana.castañeda0104@unieats.com', 'Calle 45 #17-11', 'adrianacastañeda0104emp#', 1, 7),
(105, 'Luciana', 'Armando', 'Castaño', 'Arévalo', '0105', 'luciana.castaño0105@unieats.com', 'Calle 38 #21-11', 'lucianacastaño0105emp#', 1, 6),
(106, 'Catalina', 'Paola', 'Cruz', 'Velasco', '0106', 'catalina.cruz0106@unieats.com', 'Calle 64 #24-18', 'catalinacruz0106emp#', 1, 8),
(107, 'Mateo', 'Mauricio', 'Vallejo', 'Ruiz', '0107', 'mateo.vallejo0107@unieats.com', 'Calle 30 #26-19', 'mateovallejo0107emp#', 1, 5),
(108, 'Catalina', 'Andrea', 'Blanco', 'Cardona', '0108', 'catalina.blanco0108@unieats.com', 'Calle 33 #18-9', 'catalinablanco0108emp#', 1, 8),
(109, 'Jorge', 'Eduardo', 'Pérez', 'Rosales', '0109', 'jorge.pérez0109@unieats.com', 'Calle 24 #4-18', 'jorgepérez0109emp#', 1, 3),
(110, 'Melissa', 'Leonardo', 'Gutiérrez', 'Padilla', '0110', 'melissa.gutiérrez0110@unieats.com', 'Calle 55 #11-23', 'melissagutiérrez0110emp#', 1, 12),
(111, 'Esteban', 'Isabel', 'Álvarez', 'Rojas', '0111', 'esteban.álvarez0111@unieats.com', 'Calle 25 #18-17', 'estebanálvarez0111emp#', 1, 2),
(112, 'Camila', 'Esteban', 'Morales', 'Rivas', '0112', 'camila.morales0112@unieats.com', 'Calle 60 #6-11', 'camilamorales0112emp#', 1, 4),
(201, 'Santiago', 'Iván', 'Guerrero', 'Mendoza', '0201', 'santiago.guerrero0201@unieats.com', 'Calle 9 #17-27', 'santiagoguerrero0201emp#', 2, 3),
(202, 'María', 'Carolina', 'Ruiz', 'Palacios', '0202', 'maría.ruiz0202@unieats.com', 'Calle 61 #15-20', 'maríaruiz0202emp#', 2, 5),
(203, 'Francisco', 'Iván', 'Carrillo', 'Paredes', '0203', 'francisco.carrillo0203@unieats.com', 'Calle 56 #15-3', 'franciscocarrillo0203emp#', 2, 10),
(204, 'Valentina', 'Hernando', 'Mejía', 'Holguín', '0204', 'valentina.mejía0204@unieats.com', 'Calle 62 #24-8', 'valentinamejía0204emp#', 2, 9),
(205, 'Laura', 'Alejandro', 'Montenegro', 'Rodríguez', '0205', 'laura.montenegro0205@unieats.com', 'Calle 41 #26-22', 'lauramontenegro0205emp#', 2, 2),
(206, 'Valentina', 'Fernanda', 'Vallejo', 'Osorio', '0206', 'valentina.vallejo0206@unieats.com', 'Calle 5 #9-23', 'valentinavallejo0206emp#', 2, 5),
(207, 'Ricardo', 'Leonardo', 'García', 'Peña', '0207', 'ricardo.garcía0207@unieats.com', 'Calle 65 #27-8', 'ricardogarcía0207emp#', 2, 7),
(208, 'Luciana', 'Marcela', 'Vargas', 'Parra', '0208', 'luciana.vargas0208@unieats.com', 'Calle 22 #14-18', 'lucianavargas0208emp#', 2, 8),
(209, 'Felipe', 'Andrea', 'Acosta', 'Paredes', '0209', 'felipe.acosta0209@unieats.com', 'Calle 18 #29-11', 'felipeacosta0209emp#', 2, 7),
(210, 'Camilo', 'Angélica', 'Vargas', 'Quintero', '0210', 'camilo.vargas0210@unieats.com', 'Calle 24 #8-8', 'camilovargas0210emp#', 2, 7),
(211, 'Ricardo', 'Lucía', 'Quintero', 'Martínez', '0211', 'ricardo.quintero0211@unieats.com', 'Calle 53 #17-3', 'ricardoquintero0211emp#', 2, 2),
(212, 'Juliana', 'Margarita', 'Medina', 'Rojas', '0212', 'juliana.medina0212@unieats.com', 'Calle 13 #28-11', 'julianamedina0212emp#', 2, 10),
(301, 'Ximena', 'Eduardo', 'Moreno', 'Palacios', '0301', 'ximena.moreno0301@unieats.com', 'Calle 39 #6-20', 'ximenamoreno0301emp#', 3, 5),
(302, 'Tomás', 'Hernando', 'Silva', 'Martínez', '0302', 'tomás.silva0302@unieats.com', 'Calle 31 #7-15', 'tomássilva0302emp#', 3, 10),
(303, 'Luciana', 'Felipe', 'Morales', 'Osorio', '0303', 'luciana.morales0303@unieats.com', 'Calle 59 #3-29', 'lucianamorales0303emp#', 3, 11),
(304, 'Brayan', 'Felipe', 'Gómez', 'Parra', '0304', 'brayan.gómez0304@unieats.com', 'Calle 30 #5-13', 'brayangómez0304emp#', 3, 6),
(305, 'Carolina', 'Daniela', 'Salazar', 'Córdoba', '0305', 'carolina.salazar0305@unieats.com', 'Calle 34 #24-4', 'carolinasalazar0305emp#', 3, 8),
(306, 'David', 'Hernando', 'Ramírez', 'Guzmán', '0306', 'david.ramírez0306@unieats.com', 'Calle 11 #9-10', 'davidramírez0306emp#', 3, 9),
(307, 'Gabriela', 'Milena', 'Álvarez', 'Padilla', '0307', 'gabriela.álvarez0307@unieats.com', 'Calle 60 #22-5', 'gabrielaálvarez0307emp#', 3, 4),
(308, 'Paula', 'Tatiana', 'Patiño', 'Ruiz', '0308', 'paula.patiño0308@unieats.com', 'Calle 57 #3-14', 'paulapatiño0308emp#', 3, 11),
(309, 'Isabella', 'Milena', 'Vega', 'Velasco', '0309', 'isabella.vega0309@unieats.com', 'Calle 56 #20-29', 'isabellavega0309emp#', 3, 8),
(310, 'Ximena', 'José', 'Patiño', 'Paredes', '0310', 'ximena.patiño0310@unieats.com', 'Calle 65 #30-26', 'ximenapatiño0310emp#', 3, 3),
(311, 'Kevin', 'José', 'Quintero', 'Quintero', '0311', 'kevin.quintero0311@unieats.com', 'Calle 58 #16-8', 'kevinquintero0311emp#', 3, 10),
(312, 'Natalia', 'Leonardo', 'Castaño', 'Castaño', '0312', 'natalia.castaño0312@unieats.com', 'Calle 31 #30-1', 'nataliacastaño0312emp#', 3, 8),
(401, 'Carolina', 'David', 'Rojas', 'Moreno', '0401', 'carolina.rojas0401@unieats.com', 'Calle 12 #10-11', 'carolinarojas0401emp#', 4, 11),
(402, 'Daniela', 'José', 'Álvarez', 'Paredes', '0402', 'daniela.álvarez0402@unieats.com', 'Calle 39 #18-21', 'danielaálvarez0402emp#', 4, 2),
(403, 'Diana', 'Andrea', 'Salazar', 'Ramírez', '0403', 'diana.salazar0403@unieats.com', 'Calle 48 #6-28', 'dianasalazar0403emp#', 4, 1),
(404, 'Carolina', 'Armando', 'Gutiérrez', 'Ortega', '0404', 'carolina.gutiérrez0404@unieats.com', 'Calle 39 #16-9', 'carolinagutiérrez0404emp#', 4, 6),
(405, 'Francisco', 'Armando', 'Salazar', 'Osorio', '0405', 'francisco.salazar0405@unieats.com', 'Calle 25 #2-29', 'franciscosalazar0405emp#', 4, 3),
(406, 'Carolina', 'Milena', 'Ramírez', 'González', '0406', 'carolina.ramírez0406@unieats.com', 'Calle 69 #22-28', 'carolinaramírez0406emp#', 4, 3),
(407, 'Kevin', 'Mauricio', 'Delgado', 'Padilla', '0407', 'kevin.delgado0407@unieats.com', 'Calle 18 #7-7', 'kevindelgado0407emp#', 4, 12),
(408, 'Mariana', 'Carolina', 'López', 'Guzmán', '0408', 'mariana.lópez0408@unieats.com', 'Calle 8 #22-27', 'marianalópez0408emp#', 4, 8),
(409, 'Alejandro', 'Armando', 'Carrillo', 'Guzmán', '0409', 'alejandro.carrillo0409@unieats.com', 'Calle 11 #16-29', 'alejandrocarrillo0409emp#', 4, 5),
(410, 'Alejandro', 'Luis', 'Torres', 'Rojas', '0410', 'alejandro.torres0410@unieats.com', 'Calle 59 #22-15', 'alejandrotorres0410emp#', 4, 8),
(411, 'Luciana', 'Alexander', 'Castaño', 'González', '0411', 'luciana.castaño0411@unieats.com', 'Calle 12 #21-29', 'lucianacastaño0411emp#', 4, 12),
(412, 'Tomás', 'Eduardo', 'Aguilar', 'Osorio', '0412', 'tomás.aguilar0412@unieats.com', 'Calle 63 #20-20', 'tomásaguilar0412emp#', 4, 3);

-- Insercion registro metodos de pago

INSERT INTO PAYMENT_METHODS (PAYMENT_METHOD_ID, METHOD_NAME) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de Crédito'),
(3, 'Tarjeta Débito'),
(4, 'PSE'),
(5, 'Nequi'),
(6, 'Daviplata'),
(7, 'Bancolombia App');

