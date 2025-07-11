CREATE DATABASE IF NOT EXISTS tv_show_tracker;
USE tv_show_tracker;


-- Drop tables if they already exist (for reset convenience)
DROP TABLE IF EXISTS user_watch_history;
DROP TABLE IF EXISTS show_genres;
DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS tv_shows;
DROP TABLE IF EXISTS users;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(320) NOT NULL UNIQUE,
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE authorities (
    username VARCHAR(100),
    authority VARCHAR(50),
    FOREIGN KEY (username) REFERENCES users(username),
    UNIQUE (username, authority)
);

-- TV Shows Table
CREATE TABLE tv_shows (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    show_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    image_url VARCHAR(2083) NOT NULL,
    num_episodes INT NOT NULL,
    release_year SMALLINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Genres Table
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- User Watch History Table
CREATE TABLE user_watch_history (
    user_id INT NOT NULL,
    show_id INT NOT NULL,
    status ENUM('Not Watched', 'Want to Watch', 'Currently Watching', 'Already Watched') NOT NULL,
    episodes_watched INT DEFAULT 0,
    rating INT DEFAULT NULL CHECK (rating IS NULL OR rating BETWEEN 1 AND 5),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    favorite BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (user_id, show_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (show_id) REFERENCES tv_shows(show_id) ON DELETE CASCADE
);

-- Show Genres Table
CREATE TABLE show_genres (
    show_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (show_id, genre_id),
    FOREIGN KEY (show_id) REFERENCES tv_shows(show_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- Seed 10 TV Shows
INSERT INTO tv_shows (show_name, description, image_url, num_episodes, release_year) VALUES
(
    'Breaking Bad', 'A high school chemistry teacher turned methamphetamine producer.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/breakingbad.jpg', 62, 2008
    ),
(
    'Stranger Things', 'Mystery and supernatural events unfold in a small town.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/strangerthings.jpg', 34, 2016
    ),
(
    'Game of Thrones', 'Noble families vie for control of the Iron Throne.', 
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/gameofthrones.jpg', 73, 2011
    ),
(
    'The Office', 'A mockumentary on a group of typical office workers.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/theoffice.jpg', 201, 2005
    ),
(
    'The Mandalorian', 'A bounty hunter travels through the Star Wars galaxy.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/mandalorian.jpg', 24, 2019
    ),
(
    'Friends', 'Follows the personal and professional lives of six friends in NYC.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/friends.jpg', 236, 1994
    ),
(
    'The Witcher', 'A monster hunter struggles to find his place in a world of beasts and men.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/thewitcher.jpg', 24, 2019
    ),
(
    'Severance', 'Employees at a biotech company undergo memory-severing surgery.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/severance.jpg', 19, 2022
    ),
(
    'Attack on Titan', 'Humans fight for survival against man-eating giants.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/attackontitan.jpg', 94, 2013
    ),
(
    'Avatar: The Last Airbender', 'A young boy must master all four elements and save the world.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/avatar.jpg', 61, 2005
    ),
(
    'The Big Bang Theory', 'A group of socially awkward scientists navigate life, love, and geek culture in this quirky sitcom.',
    'https://cognixia-capstone-resources.s3.us-east-1.amazonaws.com/bigbangtheory.jpg', 279, 2007
    );

    
-- Seed genres
INSERT INTO genres (name) VALUES
('Comedy'), ('Drama'), ('Thriller'), ('Science Fiction'),
('Horror'), ('Mystery'), ('Action'), ('Adventure'), ('Fantasy');

-- Seed show_genres
INSERT INTO show_genres (show_id, genre_id) VALUES 
(1, 1), (1, 2), (1, 3),
(2, 2), (2, 4), (2, 5), (2, 6),
(3, 2), (3, 7), (3, 8), (3, 9),
(4, 1),
(5, 7), (5, 8),
(6, 1),
(7, 2), (7, 7), (7, 8), (7, 9),
(8, 1), (8, 2), (8, 3), (8, 4), (8, 6),
(9, 7), (9, 9),
(10, 1), (10, 2), (10, 7), (10, 8), (10, 9),
(11, 1);

-- Seed users Table with 1 user (default user)
INSERT INTO users (name, username, password, email)
VALUES ('default', 'user', '$2a$10$bP/Xi10wMBZJhrkaR5jrSeER4lGpvZfxTR6PBfDc5lRSIm29ZjIpa', 'default@email.com');

-- Seed authorities table - assign default user a role
INSERT INTO authorities (username, authority)
VALUES ('user', 'ROLE_USER');

-- Seed user_watch_history for default user (user_id = 1)
INSERT INTO user_watch_history (user_id, show_id, status, episodes_watched, rating, favorite)
VALUES
(1, 1, 'Already Watched', 62, 5, TRUE),   -- Breaking Bad
(1, 2, 'Want to Watch', 0, NULL, FALSE), -- Stranger Things
(1, 3, 'Currently Watching', 28, NULL, TRUE), -- Game of Thrones
(1, 4, 'Already Watched', 201, 4, FALSE), -- The Office
(1, 5, 'Not Watched', 0, NULL, FALSE), -- The Mandalorian
(1, 6, 'Already Watched', 236, 4, FALSE), -- Friends
(1, 7, 'Want to Watch', 0, NULL, FALSE), -- The Witcher
(1, 8, 'Currently Watching', 9, NULL, FALSE), -- Severance
(1, 9, 'Not Watched', 0, NULL, FALSE), -- Attack on Titan
(1, 10, 'Already Watched', 61, 5, TRUE); -- Avatar: The Last Airbender
