
use messenger;
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username varchar(30) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks for username longer than 3 symbols
    CONSTRAINT chk_user_length CHECK (LENGTH(username) >= 3),

    #checks for password longer than 5 symbols
    CONSTRAINT chk_password_length CHECK (LENGTH(password) >= 4),
    
    #checks for at least 1 number
    CONSTRAINT chk_password_number CHECK (password REGEXP '[0-9]'),

    #checks for at least 1 uppercase
    CONSTRAINT chk_password_uppercase CHECK (password REGEXP '[A-Z]')
);

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks that the room name is actually all lowercases
    CONSTRAINT chk_room_name_lowercase CHECK (CAST(name AS BINARY) = CAST(LOWER(name) AS BINARY))
);
INSERT INTO rooms (name) VALUES ('general');

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    room_id INT NULL,
    receiver_id INT NULL,
    text VARCHAR(500) NOT NULL,
    sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks that the message destination is either a room or another user
    CONSTRAINT chk_message_destination CHECK ((room_id IS NULL) <> (receiver_id IS NULL)),
    
    #when a user gets deleted, messages get deleted aswell
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    #messages in deleted rooms aren't useful
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    #private message to a deleted user is not needed.
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE DATABASE IF NOT EXISTS messenger_test;
USE messenger_test;
CREATE TABLE users(
    id INT PRIMARY KEY AUTO_INCREMENT,
    username varchar(30) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks for username longer than 3 symbols
    CONSTRAINT chk_user_length CHECK (LENGTH(username) >= 3),

    #checks for password longer than 5 symbols
    CONSTRAINT chk_password_length CHECK (LENGTH(password) >= 4),
    
    #checks for at least 1 number
    CONSTRAINT chk_password_number CHECK (password REGEXP '[0-9]'),

    #checks for at least 1 uppercase
    CONSTRAINT chk_password_uppercase CHECK (password REGEXP '[A-Z]')
);

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks that the room name is actually all lowercases
    CONSTRAINT chk_room_name_lowercase CHECK (CAST(name AS BINARY) = CAST(LOWER(name) AS BINARY))
);

INSERT INTO rooms (name) VALUES ('general');

CREATE TABLE messages (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    room_id INT NULL,
    receiver_id INT NULL,
    text VARCHAR(500) NOT NULL,
    sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    #checks that the message destination is either a room or another user
    CONSTRAINT chk_message_destination CHECK ((room_id IS NULL) <> (receiver_id IS NULL)),
    #when a user gets deleted, messages get deleted aswell
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    #messages in deleted rooms aren't useful
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE,
    #private message to a deleted user is not needed.
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);






