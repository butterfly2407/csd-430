-- 
-- Katie Hilliard
-- 06/27/2025
-- Module 5 & 6 Assignment
-- The purpose of this SQL file is to create 'katie_states_data'
-- and have it populate with data for project
--

-- Create database
CREATE DATABASE IF NOT EXISTS CSD430;
USE CSD430;

-- Create table
CREATE TABLE IF NOT EXISTS katie_states_data (
    state_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(50),
    capital VARCHAR(50),
    population_millions DECIMAL(5,2),
    abbreviation CHAR(2)
);

-- Insert data
INSERT INTO katie_states_data (state_name, capital, population_millions, abbreviation) VALUES
('California', 'Sacramento', 39.24, 'CA'),
('Texas', 'Austin', 29.53, 'TX'),
('Florida', 'Tallahassee', 21.78, 'FL'),
('New York', 'Albany', 19.84, 'NY'),
('New Jersey', 'Trenton', 8.88, 'NJ'),
('Georgia', 'Atlanta', 10.62, 'GA'),
('Illinois', 'Springfield', 12.59, 'IL'),
('Pennsylvania', 'Harrisburg', 12.80, 'PA'),
('Ohio', 'Columbus', 11.69, 'OH'),
('North Carolina', 'Raleigh', 10.44, 'NC');
