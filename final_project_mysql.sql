CREATE DATABASE science;
use science;


CREATE TABLE `users` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`first_name` TEXT(20) NOT NULL,
	`last_name` TEXT(20) NOT NULL,
	`job_position` TEXT(15) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `conferences` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(30) NOT NULL,
	`city` varchar(15) NOT NULL,
	`country` varchar(15) NOT NULL,
	`date_start` DATE NOT NULL,
	`date_end` DATE NOT NULL,
	`attendee1` INT UNSIGNED NOT NULL,
	`attendee2` INT UNSIGNED NOT NULL,
	`attendee3` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `q&a` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`topic` TEXT(15) NOT NULL,
	`question` TEXT NOT NULL,
	`answer` TEXT,usersusers
	`clue` TEXT NOT NULL,
	`report_issue` TEXT NOT NULL,
	`difficulty` INT NOT NULL,
	`completed` BOOLEAN NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `samples` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`sample_name` varchar(15) NOT NULL,
	`company_name` varchar(15),
	`sample_weight` DECIMAL(3),
	`arrival_date` DATE,
	`dispatch_date` DATE,
	`nature` varchar(10),
	`mw` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `columns` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	`manufacturer` varchar(20) NOT NULL,
	`dimensions` TEXT(8) NOT NULL,
	`kit_type` varchar(10) NOT NULL,
	`pore_size` DECIMAL(2) NOT NULL,
	`selector` varchar(10) NOT NULL,
	PRIMARY KEY (`id`)
);
drop table `raw_data`;

CREATE TABLE `raw_data` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	`name` INT UNSIGNED NOT NULL,
	`rt1` DECIMAL(2, 1) NOT NULL,
	`rt2` DECIMAL(2, 1) NOT NULL,
	`width1` DECIMAL(2, 1) NOT NULL,
	`width2` DECIMAL(2, 1) NOT NULL,
	`baseline_separation` BOOLEAN NOT NULL,
	`column` INT UNSIGNED NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `calculations` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`sample` INT UNSIGNED NOT NULL,
	`resolution` DECIMAL,
	PRIMARY KEY (`id`)
);
CREATE TABLE `completion_record` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`user` INT UNSIGNED NOT NULL,
	`exercise` INT UNSIGNED NOT NULL,
	`completion` BOOLEAN NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`)
);
-- removed completed colum from q&a as repeated in completion record table
alter table `q&a` drop column completed;

ALTER TABLE `conferences` ADD CONSTRAINT `conferences_fk0` FOREIGN KEY (`attendee1`) REFERENCES `users`(`id`);

ALTER TABLE `conferences` ADD CONSTRAINT `conferences_fk1` FOREIGN KEY (`attendee2`) REFERENCES `users`(`id`);

ALTER TABLE `conferences` ADD CONSTRAINT `conferences_fk2` FOREIGN KEY (`attendee3`) REFERENCES `users`(`id`);

ALTER TABLE `raw_data` ADD CONSTRAINT `raw_data_fk0` FOREIGN KEY (`name`) REFERENCES `samples`(`id`);

ALTER TABLE `raw_data` ADD CONSTRAINT `raw_data_fk1` FOREIGN KEY (`column`) REFERENCES `columns`(`id`);

ALTER TABLE `calculations` ADD CONSTRAINT `calculations_fk0` FOREIGN KEY (`sample`) REFERENCES `raw_data`(`id`);

ALTER TABLE `completion_record` ADD CONSTRAINT `completion_record_fk0` FOREIGN KEY (`user`) REFERENCES `users`(`id`);

ALTER TABLE `completion_record` ADD CONSTRAINT `completion_record_fk1` FOREIGN KEY (`exercise`) REFERENCES `q&a`(`id`);


-- -----------------------------------------------------------------------------------------------------
-- ADDING FIELDS TO TABLES

INSERT INTO users (first_name, last_name, job_position)
VALUES
	('Andy', 'Bernard', 'qca'),
	('Michael', 'Scott', 'sss'),
    ('Jim', 'Halpert', 'ss'),
    ('Dwight', 'Schrute', 'ss'),
    ('Pam', 'Beesly', 'lab_tech'),
    ('Kevin', 'Malone', 'ss'),
    ('Kelly', 'Kapoor', 'ss'),
    ('Ryan', 'Howard', 'lab_tech');
select * from users;

INSERT INTO conferences (name, city, country, date_start, date_end, attendee1, attendee2, attendee3)
VALUES
	('Phenoprep', 'Basel', 'Switzerland', 231022, 251022, 1, 2, 4),
   ('SPICA', 'Lisbon', 'Portugal', 111022, 141022, 6, 7, 3),
    ('PrepUK', 'Nottingham', 'England', 240323, 260323, 2, 4, 5);
select *  from conferences;

INSERT INTO `q&a` (topic, question, answer, clue, report_issue, difficulty, completed)
VALUES
	('chiral', 
    'Which chiral column is known have higher pressure?',
    'Chiralpak C5.',
    0, 0, 1, 0),
    ('qc',
    'Why is prepping in formic acid preferrable over TFA?',
    'Formic acid is easier to remove on drying.',
    0, 0, 1, 0),
    ('chiral',
    'What would you do to the solvent composition in NP to speed up elution?',
    'Increase the percentage of Hexane.',
    0, 0, 1, 0),
    ('qc',
    'What is in the make-up flow on the UPC2 Basic and Acidic?',
    '9:1 Methanol:Water with 0.2% NH3 and 0.1% Formic acid.',
    0, 0, 2, 0);
    select * from `q&a`;
    
    INSERT INTO samples (sample_name, company_name, sample_weight, arrival_date, dispatch_date, nature, mw)
	VALUES
		('TSO', 'Merck', 100, 100822, null, null, 123),
        ('HF41', 'HF', 30, 090822, null, 'acidic', 456),
        ('BF12', 'BASF', 150, 030422, 130422, 'basic', 384),
        ('Ranilic Acid', 'Merck', 120,  070722, 270722, 'basic', 444),
        ('KN33', 'Kantu',555, 110622, null, 'neutral', 101);
select * from samples;

INSERT INTO `columns` (name, manufacturer, dimensions, kit_type, pore_size, selector)
VALUES 
	('C4', 'Lux', 250, 'chiral', 5, 'a'),
    ('C1', 'Lux', 250, 'chiral', 5, 'b'),
    ('CSH', 'Waters', 150, 'achiral', 2.7, 'z'),
    ('BEH', 'Waters', 50, 'achiral', 2.7, 'z'),
    ('BEH', 'Waters', 150, 'achiral', 2.7, 'z'),
    ('IG', 'Chiralpak', 250, 'chiral', 5, 'c'),
    ('iA3', 'Lux', 250, 'chiral', 5, 'c'),
    ('C2', 'Lux', 250, 'chiral', 5, 'd');
select * from columns;

INSERT INTO raw_data (name, rt1, rt2, width1, width2, baseline_separation, `column`)
VALUES
	(6, 1.2, 01.6, 00.5, 00.6, 1, 1),
    (7, 2.6, 3.2, 0.1, 1, 1, 1),
    (8, 1.4, 1.5, 0.5, 0.6, 0, 2),
    (9, 2.7, 3.3, 0.3, 0.3, 1, 2),
    (6, 1.5, 3.5, 0.3, 0.4, 1, 4);
select * from raw_data;

INSERT INTO calculations (sample, resolution)
VALUES
	(7, null),
    (8, null),
    (6, null);
select * from calculations;

INSERT into completion_record (user, exercise, completion)
VALUES
		(2, 1, 0),
        (2, 2, 0),
        (3, 1, 0),
        (3, 2, 1),
        (3, 3, 0),
        (4, 1, 1),
        (4, 2, 1),
        (4, 3, 0),
        (5, 2, 0);
	select * from completion_record;
    
-- --------------------------------------------------------------------------------------------------------------------

-- INNER JOIN: gives column name, manufacturer and id where column used in raw_data
SELECT DISTINCT raw_data.column, columns.manufacturer, columns.name
FROM `columns`
INNER JOIN raw_data ON
columns.id=raw_data.column;

-- STORED FUNCTION: tells you where a sample is based on arrival and dispatch dates
DELIMITER //
CREATE FUNCTION sample_location(
    dispatch_date DATE, arrival_date DATE
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE sample_location VARCHAR(20);
    IF (dispatch_date IS NULL AND arrival_date IS NOT NULL) THEN
        SET sample_location = 'labs';
    ELSEIF arrival_date=null THEN
        SET sample_location = 'not arrived';
	ELSE 
		SET sample_location = 'dispatched';
    END IF;
    RETURN (sample_location);
END//
DELIMITER ;

SELECT s.sample_name, s.company_name, sample_location(dispatch_date, arrival_Date)
FROM samples S;

-- SUB-QUERY: gives you the sample name and MW where baseline separation is observed
 
SELECT s.sample_name, s.mw
FROM samples s
WHERE id = (select r.id FROM raw_data r  WHERE r.baseline_separation=1 LIMIT 1 );

-- STORED PROCEDURE: shows which questions are oustanding per user
DELIMITER //
CREATE PROCEDURE oustanding_questions(in user_id int)
BEGIN 
    SELECT distinct q.id, q.question, q.difficulty, c.user
    from `q&a` q 
	inner join completion_record c ON
    c.exercise=q.id where c.user=user_id;
END//
DELIMITER ;

call oustanding_questions(2);


-- TRIGGER: Remove duplicates in users 

DELIMITER //

CREATE TRIGGER check_dups_after_insert
after UPDATE
ON USERS FOR EACH ROW
BEGIN
    CALL delete_dup_users ();
END//

DELIMITER ;
​-- HOW TRIGGER FUCNTIONS --------------------
SHOW TRIGGERS;

select * from users;
insert into users (first_name, last_name, job_position)
values ('Kevin', 'Malone', 'ss'); 

-- PROCEDURE USED IN TRIGGER------------------------------------
DELIMITER //
CREATE PROCEDURE delete_dup_users ()
BEGIN
delete from users where id in(
SELECT  a.id
from(
SELECT 
	id, first_name, last_name, job_position,
    row_number()
     over (
		partition by first_name, last_name, job_position
        order by id, first_name, last_name, job_position)
	rownumber 
    from users) a 
    where a.rownumber>1);
END//
DELIMITER ;

-- VIEW -------------------------

CREATE OR REPLACE VIEW vw_sample_info AS
    SELECT 
    s.sample_name,
    s.company_name, 
    s.nature, 
    s.mw    
        -- we don't want anyone except from scientist/analysts to see sample info
    FROM
        samples s
	CROSS JOIN users u
    WHERE
        JOB_POSITION LIKE '%SS%' or '%QCA%';
        
	SHOW FULL TABLES 
WHERE table_type = 'VIEW';


	
-- --------------------------------------------------------------
-- PROCEDURE USED IN TRIGGER BUT FOR SAMPLES------------------------------------
DELIMITER //
CREATE PROCEDURE delete_dup_samples ()
BEGIN
delete from samples where id in(
SELECT  a.id
from(
SELECT 
	id, sample_name, company_name, sample_weight, arrival_date, dispatch_date, nature, mw,
    row_number()
     over (
		partition by sample_name, company_name, sample_weight, arrival_date, dispatch_date, nature, mw
        order by id, sample_name, company_name, sample_weight, arrival_date, dispatch_date, nature, mw)
	rownumber 
    from samples) a 
    where a.rownumber>1);
END//
DELIMITER ;

call delete_dup_samples();

    
