-- Entities: Zoo, Visitor, Retail, GiftShop, FoodStand, Product, Employee, Caretaker, Veterinarian,
-- Animator, Event, Material, Animal, Enclosure, AnimalFood, Disease, Stakeholder
CREATE TABLE Stakeholder (
    email VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    amount DECIMAL(10, 2),
    date DATE
);

CREATE TABLE Zoo(
    name VARCHAR(255) PRIMARY KEY,
    address VARCHAR(255),
    surface DECIMAL(10, 2)
);

CREATE TABLE Visitor(
    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(255)
);

CREATE TABLE Retail(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255),
    opening_time TIME,
    closing_time TIME
);

CREATE TABLE GiftShop(
    retail_id INT NOT NULL AUTO_INCREMENT REFERENCES Retail(id),
    PRIMARY KEY(retail_id)
    -- id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- name VARCHAR(255),
    -- location VARCHAR(255),
    -- opening_time TIME,
    -- closing_time TIME
);

CREATE TABLE FoodStand(
    retail_id INT NOT NULL AUTO_INCREMENT REFERENCES Retail(id),
    PRIMARY KEY(retail_id)
    -- id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- name VARCHAR(255),
    -- location VARCHAR(255),
    -- opening_time TIME,
    -- closing_time TIME
);

CREATE TABLE Product(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INT
);

CREATE TABLE Employee(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(255)
);

CREATE TABLE Caretaker(
    employee_id INT NOT NULL AUTO_INCREMENT REFERENCES Employee(id),
    PRIMARY KEY(employee_id)
    -- id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- name VARCHAR(255),
    -- date_of_birth DATE,
    -- gender VARCHAR(255)
);

CREATE TABLE Veterinarian(
    employee_id INT NOT NULL AUTO_INCREMENT REFERENCES Employee(id),
    specialization VARCHAR(255),
    PRIMARY KEY(employee_id)
    -- id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- name VARCHAR(255),
    -- date_of_birth DATE,
    -- gender VARCHAR(255),
    -- specialization VARCHAR(255)
);

CREATE TABLE Animator(
    employee_id INT NOT NULL AUTO_INCREMENT REFERENCES Employee(id),
    PRIMARY KEY(employee_id)
    -- id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    -- name VARCHAR(255),
    -- date_of_birth DATE,
    -- gender VARCHAR(255)
);

CREATE TABLE Event(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    location VARCHAR(255),
    start_time DATETIME,
    end_time DATETIME
);

CREATE TABLE Material(
    serial_number INT PRIMARY KEY,
    type VARCHAR(255),
    brand VARCHAR(255),
    quantity INT,
    price DECIMAL(10, 2)
);

CREATE TABLE Animal(
    name VARCHAR(255) PRIMARY KEY,
    gender VARCHAR(255),
    date_of_birth DATE,
    child_number INT,
    type VARCHAR(255)
);

CREATE TABLE Enclosure(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    max_capacity INT,
    type VARCHAR(255),
    location VARCHAR(255)
);

CREATE TABLE AnimalFood(
    serial_number INT PRIMARY KEY,
    brand VARCHAR(255),
    calories DECIMAL(10, 2),
    type VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE Disease(
    name VARCHAR(255) PRIMARY KEY,
    transmission VARCHAR(255),
    contagious BOOLEAN,
    vaccines VARCHAR(255)
);

-- Relationships: finances, includes, employs, contains, hosts, visits, attends,
-- buys, is_housed_in, has_a, eats, takes_care_of, treats, presents
CREATE TABLE finances (
    stakeholder_email VARCHAR(255),
    zoo_name VARCHAR(255),
    PRIMARY KEY (stakeholder_email, zoo_name),
    FOREIGN KEY (stakeholder_email) REFERENCES Stakeholder(email),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name)
);

CREATE TABLE includes (
    zoo_name VARCHAR(255),
    retail_id INT,
    PRIMARY KEY (zoo_name, retail_id),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name),
    FOREIGN KEY (retail_id) REFERENCES Retail(id)
);

CREATE TABLE employs (
    employee_id INT,
    zoo_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id, zoo_name),
    FOREIGN KEY (employee_id) REFERENCES Employee(id),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name)
);

CREATE TABLE houses (
    zoo_name VARCHAR(255),
    enclosure_id INT,
    PRIMARY KEY (zoo_name, enclosure_id),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name),
    FOREIGN KEY (enclosure_id) REFERENCES Enclosure(id)
);

CREATE TABLE hosts (
    zoo_name VARCHAR(255),
    event_id INT,
    PRIMARY KEY (zoo_name, event_id),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name),
    FOREIGN KEY (event_id) REFERENCES Event(id)
);

CREATE TABLE visits (
    visitor_id INT,
    zoo_name VARCHAR(255),
    price DECIMAL(10, 2),
    date DATE,
    PRIMARY KEY (visitor_id, zoo_name, date),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(id),
    FOREIGN KEY (zoo_name) REFERENCES Zoo(name)
);

CREATE TABLE attends (
    visitor_id INT,
    event_id INT,
    PRIMARY KEY (visitor_id, event_id),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(id),
    FOREIGN KEY (event_id) REFERENCES Event(id)
);

CREATE TABLE buys (
    visitor_id INT,
    product_id INT,
    retail_id INT,
    PRIMARY KEY (visitor_id, product_id, retail_id),
    FOREIGN KEY (visitor_id) REFERENCES Visitor(id),
    FOREIGN KEY (product_id) REFERENCES Product(id),
    FOREIGN KEY (retail_id) REFERENCES Retail(id)
);

CREATE TABLE is_housed_in (
    animal_name VARCHAR(255),
    enclosure_id INT,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (animal_name, enclosure_id, start_date),
    FOREIGN KEY (animal_name) REFERENCES Animal(name),
    FOREIGN KEY (enclosure_id) REFERENCES Enclosure(id)
);

CREATE TABLE has_a (
    animal_name VARCHAR(255),
    disease_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (animal_name, disease_name, start_date),
    FOREIGN KEY (animal_name) REFERENCES Animal(name),
    FOREIGN KEY (disease_name) REFERENCES Disease(name)
);

CREATE TABLE eats (
    animal_name VARCHAR(255),
    food_serial_number INT,
    time DATETIME,
    quantity INT,
    PRIMARY KEY (animal_name, food_serial_number, time),
    FOREIGN KEY (animal_name) REFERENCES Animal(name),
    FOREIGN KEY (food_serial_number) REFERENCES AnimalFood(serial_number)
);

CREATE TABLE takes_care_of (
    caretaker_id INT,
    animal_name VARCHAR(255),
    material_serial_number INT,
    PRIMARY KEY (
        caretaker_id,
        animal_name,
        material_serial_number
    ),
    FOREIGN KEY (caretaker_id) REFERENCES Caretaker(employee_id),
    FOREIGN KEY (animal_name) REFERENCES Animal(name),
    FOREIGN KEY (material_serial_number) REFERENCES Material(serial_number)
);

CREATE TABLE treats (
    veterinarian_id INT,
    animal_name VARCHAR(255),
    medicine VARCHAR(255),
    PRIMARY KEY (veterinarian_id, animal_name, medicine),
    FOREIGN KEY (veterinarian_id) REFERENCES Veterinarian(employee_id),
    FOREIGN KEY (animal_name) REFERENCES Animal(name)
);

CREATE TABLE presents (
    animator_id INT,
    event_id INT,
    animal_name VARCHAR(255),
    PRIMARY KEY (animator_id, event_id, animal_name),
    FOREIGN KEY (animator_id) REFERENCES Animator(employee_id),
    FOREIGN KEY (event_id) REFERENCES Event(id),
    FOREIGN KEY (animal_name) REFERENCES Animal(name)
);
