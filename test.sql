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

-- Inserting data
INSERT INTO
    Stakeholder (email, name, amount, date)
VALUES
    (
        'johndoe@example.com',
        'John Doe',
        5000.00,
        '2022-01-01'
    ),
    (
        'janedoe@example.com',
        'Jane Doe',
        2500.00,
        '2022-01-05'
    ),
    (
        'bobsmith@example.com',
        'Bob Smith',
        10000.00,
        '2022-01-15'
    ),
    (
        'lisajones@example.com',
        'Lisa Jones',
        7500.00,
        '2022-01-20'
    ),
    (
        'mikebrown@example.com',
        'Mike Brown',
        15000.00,
        '2022-02-01'
    ),
    (
        'emilywilson@example.com',
        'Emily Wilson',
        3000.00,
        '2022-02-05'
    ),
    (
        'davidlee@example.com',
        'David Lee',
        12000.00,
        '2022-02-10'
    ),
    (
        'sarahkim@example.com',
        'Sarah Kim',
        8000.00,
        '2022-03-01'
    ),
    (
        'jameslee@example.com',
        'James Lee',
        6000.00,
        '2022-03-05'
    ),
    (
        'chrisbaker@example.com',
        'Chris Baker',
        9000.00,
        '2022-03-15'
    ),
    (
        'amynguyen@example.com',
        'Amy Nguyen',
        4000.00,
        '2022-03-20'
    );

INSERT INTO
    Visitor (id, first_name, last_name, date_of_birth, gender)
VALUES
    (
        1,
        'Lucie',
        'Navez',
        '2000-07-18',
        'female'
    ),
    (
        2,
        'Justin',
        'Henrotte',
        '2001-01-19',
        'male'
    ),
    (
        3,
        "Florian",
        "Aldeghi",
        "2000-10-27",
        'male'
    );

INSERT INTO
    Zoo (name, address, surface)
VALUES
    (
        'Bronx Zoo',
        '2300 Southern Blvd, Bronx, NY 10460',
        265
    ),
    (
        'Central Park Zoo',
        '830 5th Ave, New York, NY 10065',
        6.5
    ),
    (
        'Queens Zoo',
        '53-51 111th St, Corona, NY 11368',
        80
    ),
    (
        'Brooklyn Zoo',
        '990 Washington Ave, Brooklyn, NY 11225',
        11
    );


INSERT INTO
    Retail (id, name, location, opening_time, closing_time)
VALUES
    (
        1,
        'Bronx Zoo Gift Shop',
        "100°00'00.0 N 100°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        2,
        'Central Park Zoo Gift Shop',
        "120°00'00.0 N 120°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        3,
        'Queens Zoo Gift Shop',
        "110°00'00.0 N 110°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        4,
        'Brooklyn Zoo Gift Shop',
        "130°00'00.0 N 130°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        5,
        'Bronx Zoo Desert delights',
        "100°00'00.0 N 100°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        6,
        'Central Park African corner',
        "120°00'00.0 N 120°00'00.0",
        '09:00:00',
        '17:00:00'
    ),
    (
        7,
        'Queens Zoo Jungle store',
        "110°00'00.0 N 110°00'00.0",
        '09:00:00',
        '17:00:00'
    );


INSERT INTO 
    GiftShop (retail_id)
VALUES
    (
        7
    ),
    (
        4
    ),
    (
        1
    ),
    (
        2
    ),
    (
        3
    );

INSERT INTO
    FoodStand (retail_id)
VALUES  
    (
        5
    ),
    (
        6
    );


INSERT INTO
    Product (id, name, category, price, quantity)
VALUES
    (
        1,
        'Lion T-shirt',
        'clothing',
        20.00,
        100
    ),
    (
        2,
        'Dolphin Sweater',
        'clothing',
        30.00,
        100
    ),
    (
        3,
        'Giraffe Hat',
        'clothing',
        10.00,
        100
    ),
    (
        4,
        'Koala Backpack',
        'clothing',
        40.00,
        100
    ),
    (
        5,
        'Hyena Stuffed animal',
        'toy',
        15.00,
        100
    ),
    (
        6, 
        'Penguin Stuffed animal',
        'toy',
        15.00,
        100
    ),
    (
        7, 
        'Artic Ice Cream',
        'food',
        5.00,
        100
    ),
    (
        8, 
        'Animal shaped cookies',
        'food',
        3.00,
        100
    ),
    (
        9, 
        'Safari trail mix',
        'food',
        4.00,
        100
    ),
    (
        10, 
        'Zoo map',
        'other',
        1.00,
        100
    ),
    (
        11, 
        'Zoo guide',
        'other',
        2.00,
        100
    ),
    (
        12, 
        'Zoo poster',
        'other',
        3.00,
        100
    );

INSERT INTO
    Employee (id, name, date_of_birth, gender)
VALUES
    (
        1, 
        "Olivier Goffin", 
        "2000-10-30",
        'male'
    ),
    (
        2, 
        "Naelle Navez",
        "2022-04-25",
        "female"
    ),
    (
        3,
        "David Lembry",
        "1973-08-29",
        "male"
    ),
    (
        4,
        "Luca Mousse",
        "1978-05-19",
        "male"
    ),
    (
        5,
        "Elodie Adam",
        "1989-07-04",
        "female"
    ),
    (
        6,
        "Thierry Lamoule",
        "1973-11-19",
        "male"
    ),
    (
        7,
        "Jack Tyre",
        "1971-04-19",
        "male"
    ),
    (
        8,
        "Cindy Crawford",
        "1979-01-14",
        "female"
    ),
    (
        9,
        "Victor Grey",
        "1992-07-05",
        "male"
    ),
    (
        10,
        "Lucy Blint",
        "1982-08-15",
        "female"
    ),
    (
        11,
        "Carl Breny",
        "1995-02-08",
        "male"
    );

INSERT INTO
    Caretaker (employee_id)
VALUES
    (
        1
    ),
    (
        3
    ),
    (
        4
    ),
    (
        5
    );


INSERT INTO
    Veterinarian (employee_id, specialization)
VALUES
    (
        6,
        "lions"
    ),
    (
        7,
        "birds"
    ),
    (
        8,
        "deer"
    );

INSERT INTO
    Animator (employee_id)
VALUES
    (
        9
    ),
    (
        10
    ),
    (
        11
    );

INSERT INTO
    Event (id, name, location, start_time, end_time)
VALUES
    (
        1,
        "magic birds",
        "Amphitheatre",
        '2023-01-01 11:30:00',
        '2023-01-01 12:30:00'
    ),
    (
        2,
        "lion walk",
        "boma",
        '2023-01-02 14:30:00',
        '2023-01-02 15:30:00'
    ),
    (
        3,
        "attrap carrot",
        "rabbit hutch",
        '2023-01-03 16:00:00',
        '2023-01-03 16:45:00'
    );

INSERT INTO
    Material (serial_number, type, brand, quantity, price)
VALUES
    (
        17854695,
        "glove",
        "starlingukpk",
        18,
        39.50
    ),
    (
        14572154,
        "balloon",
        "Palmako",
        10,
        12.99
    ),
    (
        35421834,
        "hoop",
        "leafia",
        25,
        6.10
    );



INSERT INTO
    Animal (name, gender, date_of_birth, child_number, type)
VALUES
    (
        "Simba",
        "male",
        "2004-05-14",
        1,
        "lion"
    ),
    (
        "Nel",
        "female",
        "2013-05-28",
        6,
        "deer"
    ),
    (
        "Tiko",
        "male",
        "2020-07-10",
        0,
        "rabbit"
    ),
    (
        "Benny",
        "male",
        "2016-05-14",
        0,
        "sheep"
    );


INSERT INTO
    Enclosure (id, name, max_capacity, type, location)
VALUES
    (
        1, 
        "sheep dream", 
        8,
        "sheepfold",
        "entry"
    ),
    (
        2, 
        "lion liberty", 
        3,
        "boma",
        "by the lake"
    ),
    (
        3, 
        "deer view", 
        25,
        "hunting pen",
        "next to the parking"
    ),
    (
        4,
        "rabbit fancy",
        4,
        "rabbit hutch",
        "entry"
    );


INSERT INTO
    AnimalFood (serial_number, brand, calories, type, price)
VALUES
    (
        45632012, 
        "chantecler", 
        205.00,
        "chicken carcass",
        12.50
    ),
    (
        45458632, 
        "zolux", 
        385.00,
        "hay",
        25.54
    ),
    (
        49711232, 
        "versele-laga", 
        348.00,
        "crispy muesli",
        24.99
    ),
    (
        74854568,
        "livig",
        175.00,
        "grass",
        12.05
    );


INSERT INTO
    Disease (name, transmission, contagious, vaccines)
VALUES
    (
        "avian influenza", 
        "prolonged contact", 
        true,
        "H5N2"
    ),
    (
        "blue tongue", 
        "no transmission", 
        false,
        "Syvazul BTV"
    ),
    (
        "foot-and-mouth disease", 
        "Contact with respiratory droplets", 
        true,
        "Aftovaxpur DOE"
    );

INSERT INTO
    finances (stakeholder_email, zoo_name)
VALUES
    (
        'johndoe@example.com',
        'Bronx Zoo'
    ),
    (
        'bobsmith@example.com',
        'Bronx Zoo'
    ),
    (
        'lisajones@example.com',
        'Central Park Zoo'
    ),
    (
        'janedoe@example.com',
        'Queens Zoo'
    ),
    (
        'chrisbaker@example.com',
        'Brooklyn Zoo'
    ),
    (
        'amynguyen@example.com',
        'Brooklyn Zoo'
    ),
    (
        'jameslee@example.com',
        'Brooklyn Zoo'
    ),
    (
        'mikebrown@example.com',
        'Brooklyn Zoo'
    ),
    (
        'emilywilson@example.com',
        'Bronx Zoo'
    ),
    (
        'davidlee@example.com',
        'Queens Zoo'
    ),
    (
        'sarahkim@example.com',
        'Central Park Zoo'
    );

INSERT INTO
    includes (zoo_name, retail_id)
VALUES
    (
        'Bronx Zoo',
        1
    ),
    (
        'Bronx Zoo',
        5
    ),
    (
        'Central Park Zoo',
        2
    ),
    (
        'Central Park Zoo',
        6
    ),
    (
        'Queens Zoo',
        3
    ),
    (
        'Queens Zoo',
        7
    ),
    (
        'Brooklyn Zoo',
        4
    );

INSERT INTO
    employs (employee_id, zoo_name, salary)
VALUES
    (
        1,
        'Brooklyn Zoo',
        2000.00
    ),
    (
        2,
        'Queens Zoo',
        2000.00
    ),
    (
        3,
        'Bronx Zoo',
        2000.00
    ),
    (
        4,
        'Central Park Zoo',
        2000.00
    ),
    (
        5,
        'Queens Zoo',
        2000.00
    ),
    (
        6,
        'Queens Zoo',
        2000.00
    ),
    (
        7,
        'Queens Zoo',
        2000.00
    ),
    (
        8,
        'Queens Zoo',
        2000.00
    ),
    (
        9,
        'Bronx Zoo',
        2000.00
    ),
    (
        10,
        'Queens Zoo',
        2000.00
    ),
    (
        11,
        'Brooklyn Zoo',
        2000.00
    );

INSERT INTO 
    houses (zoo_name, enclosure_id)
VALUES
    (
        'Bronx Zoo',
        1
    ),
    (
        'Queens Zoo',
        2
    ),
    (
        'Central Park Zoo',
        3
    ),
    (
        'Brooklyn Zoo',
        4
    );

INSERT INTO
    hosts (zoo_name, event_id)
VALUES
    (
        "Bronx Zoo",
        1
    ),
    (
        "Queens Zoo",
        2
    ),
    (
        "Brooklyn Zoo",
        3
    );

INSERT INTO
    visits (visitor_id, zoo_name, price, date)
VALUES
    (
        1,
        "Bronx Zoo",
        25.00,
        "2023-02-25"
    ),
    (
        2,
        "Queens Zoo",
        30.00,
        "2023-01-02"
    ),
    (
        3,
        "Brooklyn Zoo",
        17.50,
        "2023-01-03"
    );

INSERT INTO
    attends (visitor_id, event_id)
VALUES
    (
        2,
        2
    ),
    (
        3,
        3
    );

INSERT INTO
    buys (visitor_id, product_id, retail_id)
VALUES
    (
        1,
        8,
        5
    ),
    (
        2,
        1,
        3
    );

INSERT INTO 
    is_housed_in (animal_name, enclosure_id, start_date, end_date)
VALUES
    (
        "Simba",
        2,
        "2023-01-01",
        "2023-12-31"
    ),
    (
        "Nel",
        3,
        "2023-01-01",
        NULL
    ),
    (
        "Tiko",
        4,
        "2023-01-01",
        NULL
    ),
    (
        "Benny",
        1,
        "2023-01-01",
        NULL
    );

INSERT INTO
    has_a (animal_name, disease_name, start_date, end_date)
VALUES
    (
        "Simba",
        "avian influenza",
        "2023-02-15",
        NULL
    );

INSERT INTO
    eats (animal_name, food_serial_number, time, quantity)
VALUES
    (
        "Simba",
        45632012,
        "2023-01-01 11:00:00",
        4
    ),
    (
        "Nel",
        45458632,
        "2023-01-01 13:00:00",
        100
    ),
    (
        "Tiko",
        49711232,
        "2023-01-01 12:00:00",
        50
    ),
    (
        "Benny",
        74854568,
        "2023-01-01 15:00:00",
        150
    );

INSERT INTO
    takes_care_of (caretaker_id, animal_name, material_serial_number)
VALUES
    (
        1,
        "Tiko",
        17854695
    ),
    (
        3,
        "Benny",
        17854695
    ),
    (
        4,
        "Nel",
        17854695
    ),
    (
        5,
        "Simba",
        17854695
    );

INSERT INTO
    treats (veterinarian_id, animal_name, medicine)
VALUES
    (
        6,
        "Simba",
        "Dafalgan"
    );

INSERT INTO
    presents (animator_id, event_id, animal_name)
VALUES
    (
        9,
        1,
        "Benny"
    ),
    (
        10,
        2,
        "Simba"
    ),
    (
        11,
        3,
        "Tiko"
    );