-- students_marks.sql

CREATE DATABASE IF NOT EXISTS school_db;
USE school_db;

-- Students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    class VARCHAR(20),
    section VARCHAR(10),
    date_of_birth DATE
);

-- Marks table
CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR(50) NOT NULL,
    marks INT NOT NULL,
    max_marks INT NOT NULL DEFAULT 100,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE
);

-- Sample students
INSERT INTO students
    (roll_no, name, class, section, date_of_birth)
VALUES
    ('S001', 'Rahul Kumar', '10', 'A', '2010-05-12'),
    ('S002', 'Priya Sharma', '10', 'A', '2010-08-20'),
    ('S003', 'Arjun Reddy', '10', 'B', '2010-03-15'),
    ('S004', 'Sneha Patel', '10', 'B', '2010-11-05'),
    ('S005', 'Vikram Singh', '10', 'A', '2010-01-25');

-- Sample marks
INSERT INTO marks
    (student_id, subject, marks, max_marks)
VALUES
    (1, 'Mathematics', 85, 100),
    (1, 'Science', 78, 100),
    (1, 'English', 88, 100),

    (2, 'Mathematics', 92, 100),
    (2, 'Science', 89, 100),
    (2, 'English', 95, 100),

    (3, 'Mathematics', 76, 100),
    (3, 'Science', 82, 100),
    (3, 'English', 74, 100),

    (4, 'Mathematics', 90, 100),
    (4, 'Science', 94, 100),
    (4, 'English', 87, 100),

    (5, 'Mathematics', 68, 100),
    (5, 'Science', 73, 100),
    (5, 'English', 79, 100);

-- View all students and their marks
SELECT
    s.student_id,
    s.roll_no,
    s.name,
    s.class,
    s.section,
    m.subject,
    m.marks,
    m.max_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
ORDER BY s.student_id, m.subject;

-- Calculate total and percentage for each student
SELECT
    s.student_id,
    s.roll_no,
    s.name,
    SUM(m.marks) AS total_marks,
    SUM(m.max_marks) AS total_max_marks,
    ROUND(SUM(m.marks) * 100.0 / SUM(m.max_marks), 2) AS percentage
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.roll_no, s.name
ORDER BY s.student_id;
