-- Create the Database
CREATE DATABASE healthcare_portal;

USE healthcare_portal;

-- Table for Users
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL
);

-- Table for User Roles
CREATE TABLE User_role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name ENUM('patient', 'doctor', 'nurse', 'admin') NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table for Patients
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    age INT NOT NULL,
    address TEXT NOT NULL,
    contact_info VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table for Doctors
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table for Hospitals
CREATE TABLE Hospital (
    h_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_name VARCHAR(150) NOT NULL,
    location TEXT NOT NULL
);

-- Table for Treatment
CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    h_id INT NOT NULL,
    doctor_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (h_id) REFERENCES Hospital(h_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Table for Appointments
CREATE TABLE Appointment (
    appoin_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appoin_info TEXT NOT NULL,
    appoin_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Table for Nurses
CREATE TABLE Nurse (
    nurse_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table for Admins
CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(15) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Table for Prescriptions
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    medi_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Table for Tests
CREATE TABLE Test (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    test_type VARCHAR(100) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Table for Test Results
CREATE TABLE TestResult (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    test_id INT NOT NULL,
    result_info TEXT NOT NULL,
    FOREIGN KEY (test_id) REFERENCES Test(test_id)
);

-- Table for Organ Donation
CREATE TABLE OrganDonation (
    donation_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT NOT NULL,
    organ_type VARCHAR(50) NOT NULL,
    donation_date DATE NOT NULL,
    FOREIGN KEY (donor_id) REFERENCES Patient(patient_id)
);

-- Table for Blood Bank
CREATE TABLE BloodBank (
    bank_id INT AUTO_INCREMENT PRIMARY KEY,
    location TEXT NOT NULL,
    available_blood TEXT NOT NULL
);

-- Table for Ambulances
CREATE TABLE Ambulance (
    ambulance_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_id INT NOT NULL,
    driver_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES Hospital(h_id)
);

-- Table for Emergency Contacts
CREATE TABLE EmergencyContact (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);
