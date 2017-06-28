CREATE DATABASE  IF NOT EXISTS `grantcalcdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `grantcalcdb`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: grantcalcdb
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.19-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `idPerson` int(11) NOT NULL AUTO_INCREMENT,
  `LastFirstName` varchar(45) DEFAULT NULL,
  `idDepartment` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPerson`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='Stores information about a person''s ID';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `idProject` int(11) NOT NULL AUTO_INCREMENT,
  `ProjectName` varchar(45) DEFAULT NULL,
  `PI` varchar(50) DEFAULT NULL,
  `PrimeSite` varchar(50) DEFAULT NULL,
  `FormalProjectTitle` text,
  `ProjectStartDate` date DEFAULT NULL,
  `ProjectEndDate` date DEFAULT NULL,
  `ProjectStatusCd` int(11) DEFAULT NULL,
  `idDepartment` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProject`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='Information about project ID and start/end dates';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projecteffort`
--

DROP TABLE IF EXISTS `projecteffort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projecteffort` (
  `Project_idProject` int(11) NOT NULL,
  `Person_idPerson` int(11) NOT NULL,
  `PercentEffort` float DEFAULT NULL,
  PRIMARY KEY (`Project_idProject`,`Person_idPerson`),
  KEY `fk_ProjectEffort_Project_idx` (`Project_idProject`),
  KEY `fk_ProjectEffort_Person1_idx` (`Person_idPerson`),
  CONSTRAINT `fk_ProjectEffort_Person1` FOREIGN KEY (`Person_idPerson`) REFERENCES `person` (`idPerson`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProjectEffort_Project` FOREIGN KEY (`Project_idProject`) REFERENCES `project` (`idProject`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `vw_current_total_effort`
--

DROP TABLE IF EXISTS `vw_current_total_effort`;
/*!50001 DROP VIEW IF EXISTS `vw_current_total_effort`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_current_total_effort` AS SELECT 
 1 AS `Last, First Name`,
 1 AS `Cumulative Percent Effort`,
 1 AS `Current Projects`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_currentproject`
--

DROP TABLE IF EXISTS `vw_currentproject`;
/*!50001 DROP VIEW IF EXISTS `vw_currentproject`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vw_currentproject` AS SELECT 
 1 AS `Project ID`,
 1 AS `Project Name`,
 1 AS `Project Start Date`,
 1 AS `Project End Date`,
 1 AS `ProjectStatusCd`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'grantcalcdb'
--
/*!50003 DROP FUNCTION IF EXISTS `get_effort` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` FUNCTION `get_effort`(datecheck VARCHAR(10), person VARCHAR(30)) RETURNS float
BEGIN
DECLARE PercentEffort FLOAT;
 
SELECT SUM(b.PercentEffort)
FROM person a
JOIN projecteffort b
ON a.idPerson = b.Person_idPerson
JOIN (SELECT idProject, ProjectName FROM project
WHERE ProjectStartDate <= STR_TO_DATE(datecheck, '%Y-%m-%d')
AND STR_TO_DATE(datecheck, '%Y-%m-%d') < ProjectEndDate) c
ON b.Project_idProject = c.idProject
WHERE a.LastFirstName LIKE CONCAT('%', person, '%')
GROUP BY b.Person_idPerson INTO PercentEffort;

RETURN PercentEffort;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_effort2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` FUNCTION `get_effort2`(datecheck VARCHAR(10), person VARCHAR(30)) RETURNS float
BEGIN
DECLARE PercentEffort FLOAT;
 
SELECT SUM(b.PercentEffort)
FROM person a
JOIN temp.projecteffort b
ON a.idPerson = b.Person_idPerson
JOIN (SELECT idProject, ProjectName FROM project
WHERE ProjectStartDate <= STR_TO_DATE(datecheck, '%Y-%m-%d')
AND STR_TO_DATE(datecheck, '%Y-%m-%d') < ProjectEndDate
AND ProjectStatusCd = 1) c
ON b.Project_idProject = c.idProject
WHERE a.LastFirstName LIKE CONCAT('%', person, '%')
GROUP BY b.Person_idPerson INTO PercentEffort;

RETURN PercentEffort;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_effort_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` FUNCTION `get_effort_temp`(datecheck VARCHAR(10), person VARCHAR(30)) RETURNS float
BEGIN
DECLARE PercentEffort FLOAT;
 
SELECT SUM(b.PercentEffort)
FROM temp.person a
JOIN temp.projecteffort b
ON a.idPerson = b.Person_idPerson
JOIN (SELECT idProject, ProjectName FROM temp.project
WHERE ProjectStartDate <= STR_TO_DATE(datecheck, '%Y-%m-%d')
AND STR_TO_DATE(datecheck, '%Y-%m-%d') < ProjectEndDate) c
ON b.Project_idProject = c.idProject
WHERE a.LastFirstName LIKE CONCAT('%', person, '%')
GROUP BY b.Person_idPerson INTO PercentEffort;

RETURN PercentEffort;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_projects` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` FUNCTION `get_projects`(datecheck VARCHAR(10), person_id INT) RETURNS varchar(100) CHARSET utf8
BEGIN

DECLARE ProjectString VARCHAR(100);

SELECT GROUP_CONCAT(ProjectName ORDER BY ProjectName ASC SEPARATOR ', ') AS 'Projects'
FROM
(SELECT a.ProjectName, b.Project_idProject, b.Person_idPerson
FROM project a
JOIN temp.projecteffort b
ON a.idProject = b.Project_idProject
WHERE a.ProjectStartDate <= datecheck
AND datecheck
AND ProjectStatusCd = 1) c
GROUP BY c.Person_idPerson
HAVING c.Person_idPerson = person_id
INTO ProjectString;

RETURN ProjectString;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_effort_on` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_get_effort_on`(IN spinput1 VARCHAR(25), IN spinput2 VARCHAR(10))
BEGIN
 /* Stored Procedure sp_get_effort_on
 Author: Ariel Roane
 First Version: 05/18/2017
 Revision: 05/18/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 This stored procedure will generate the information about a specific person's 
 percent effort at a certain date. The person can be identified by last name.
 If the name is left blank, the stored procedure will return all percentage
 efforts for that date. 
 
 Input: Last Name, Date (will be converted from literal to proper format in
 procedure, expecting USA format)
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 -- Create temporary table with correct date range
CREATE TEMPORARY TABLE temp.temp
AS
(SELECT idProject 
	, ProjectName 
	, ProjectStartDate
    , ProjectEndDate
FROM project
WHERE ProjectStartDate <= STR_TO_DATE(spinput2, '%m/%d/%YYYY')
AND ProjectEndDate > STR_TO_DATE(spinput2, '%m/%d/%YYYY'));

-- Select data according to name and created temp table
SELECT a.LastFirstName AS 'Name'
	, SUM(b.PercentEffort) AS 'Percent Effort on Date'
    , GROUP_CONCAT(DISTINCT c.ProjectName ORDER BY c.ProjectName ASC SEPARATOR ',') AS 'Projects'
FROM person a
JOIN projecteffort b
ON a.idPerson = b.Person_idPerson
JOIN temp.temp c
ON b.Project_idProject = c.idProject
WHERE (spinput1 IS NULL OR a.LastFirstName LIKE CONCAT('%', spinput1, '%'))
GROUP BY b.Person_idPerson;

DROP TEMPORARY TABLE IF EXISTS temp.temp;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_effort_range` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_get_effort_range`(IN spinput1 VARCHAR(10), IN spinput2 VARCHAR(10))
BEGIN
 /* Stored Procedure sp_get_effort_range
 Author: Ariel Roane
 First Version: 05/22/2017
 Revision: 05/22/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 This stored procedure is like sp_get_effort_on in that it returns a percent
 effort, but different in that it returns a percent effort within a range of
 dates, and automatically returns all in the database. 
 
 Input: Last Name, DateStart (will be converted from literal to proper format in
 procedure, expecting USA format), DateEnd
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 -- Create temporary table with correct date range
CREATE TEMPORARY TABLE temp.temp
AS
(SELECT idProject 
	, ProjectName 
FROM project
WHERE ProjectStartDate <= STR_TO_DATE(spinput1, '%m/%d/%YYYY')
AND STR_TO_DATE(spinput2, '%m/%d/%YYYY') < ProjectEndDate);

-- SELECT * from temp.temp;

-- Select data according to name and created temp table
SELECT a.LastFirstName AS 'Name'
	, SUM(b.PercentEffort) AS 'Percent Effort on Date Range'
    , GROUP_CONCAT(DISTINCT c.ProjectName ORDER BY c.ProjectName ASC SEPARATOR ',') AS 'Projects'
    , CONCAT(spinput1, ' to ', spinput2) AS 'Range'
FROM person a
JOIN projecteffort b
ON a.idPerson = b.Person_idPerson
JOIN temp.temp c
ON b.Project_idProject = c.idProject
GROUP BY b.Person_idPerson;

DROP TEMPORARY TABLE IF EXISTS temp.temp;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_get_monthly`(IN person VARCHAR(25))
BEGIN
/* Stored Procedure sp_get_monthly
 Author: Ariel Roane
 First Version: 05/22/2017
 Revision: 05/22/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
Gets a monthly view of percent effort for a year from the current
date.
 
 Input: 
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 DECLARE nextdate DATE;
 DECLARE yeardate DATE;
 DECLARE percentef FLOAT;
 
 CREATE TEMPORARY TABLE temp.tablemonthly(
 MonthYear VARCHAR(20) NOT NULL
 , PercentEffort FLOAT);
 
 SET nextdate = CURDATE() + INTERVAL 1 MONTH;
 SET yeardate = CURDATE() + INTERVAL 1 YEAR;

 WHILE nextdate <= yeardate DO
 SET percentef = get_effort((nextdate - INTERVAL 1 MONTH), person);
 IF percentef IS NULL THEN
	SET percentef = 0.0;
 END IF;
 INSERT INTO temp.tablemonthly (MonthYear, PercentEffort)
 VALUES(CONCAT(MONTHNAME(nextdate - INTERVAL 1 MONTH), ' ', YEAR(nextdate - INTERVAL 1 MONTH)), 
 percentef);
 SET nextdate = nextdate + INTERVAL 1 MONTH;
 END WHILE;
 
 SELECT * FROM temp.tablemonthly;
 
 DROP TEMPORARY TABLE temp.tablemonthly;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_monthly_temp` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_get_monthly_temp`(IN person VARCHAR(25))
BEGIN
/* Stored Procedure sp_get_monthly
 Author: Ariel Roane
 First Version: 05/22/2017
 Revision: 05/22/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
Gets a monthly view of percent effort for a year from the current
date.
 
 Input: 
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 DECLARE nextdate DATE;
 DECLARE yeardate DATE;
 DECLARE percentef FLOAT;
 
 CREATE TEMPORARY TABLE temp.tablemonthly(
 MonthYear VARCHAR(20) NOT NULL
 , PercentEffort FLOAT);
 
 SET nextdate = CURDATE() + INTERVAL 1 MONTH;
 SET yeardate = CURDATE() + INTERVAL 1 YEAR;

 WHILE nextdate <= yeardate DO
 SET percentef = get_effort_temp((nextdate - INTERVAL 1 MONTH), person);
 IF percentef IS NULL THEN
	SET percentef = 0.0;
 END IF;
 INSERT INTO temp.tablemonthly (MonthYear, PercentEffort)
 VALUES(CONCAT(MONTHNAME(nextdate - INTERVAL 1 MONTH), ' ', YEAR(nextdate - INTERVAL 1 MONTH)), 
 percentef);
 SET nextdate = nextdate + INTERVAL 1 MONTH;
 END WHILE;
 
 SELECT * FROM temp.tablemonthly;
 
 DROP TEMPORARY TABLE temp.tablemonthly;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_rel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_insert_rel`(IN person_name VARCHAR(30), IN project_name VARCHAR(25), IN percentage FLOAT)
BEGIN
/* Stored Procedure sp_insert_single
 Author: Ariel Roane
 First Version: 06/03/2017
 Revision: 06/03/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 Inserts a relationship between a person and a project.
 
 Input: person (First Last Name), project name, effort percentage
 Output: None
 Algorithm: Look up correspondent person and project ids from parameters,
 insert record into projecteffort
 
TEST CASES:
CASE:

RESULT:
 */
 
 DECLARE personx int;
 DECLARE projectx int;
 
 SET personx = (SELECT idPerson FROM person WHERE LastFirstName = person_name LIMIT 1);
 SET projectx = (SELECT idProject FROM project WHERE ProjectName = project_name LIMIT 1);

 INSERT INTO projecteffort (Project_idProject, Person_idPerson, PercentEffort)
 VALUES (projectx, personx, percentage);
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_single` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_insert_single`(IN person VARCHAR(30), IN project VARCHAR(25), IN startdate VARCHAR(10), 
IN enddate VARCHAR(10), IN percentage FLOAT)
BEGIN
/* Stored Procedure sp_insert_single
 Author: Ariel Roane
 First Version: 05/24/2017
 Revision: 05/24/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
Inserts a record of a name, project, start and end date, and percent effort into the database. Can
be used with both new people and people already in the database. Cannot be used to update old projects.
 
 Input: person (First Last Name), project name, start date, end date, effort percentage
 Output: None
 Algorithm: Conditional to check if person already in database. If he/she is not, person is also 
 added to the person table. Index reference to lookup unique IDs for person and project to insert 
 into the projecteffort table.
 
TEST CASES:
CASE:

RESULT:
 */
 
SET startdate = STR_TO_DATE(startdate, '%m/%d/%Y');
SET enddate = STR_TO_DATE(enddate, '%m/%d/%Y');

IF (SELECT LastFirstName FROM person WHERE LastFirstName = person) IS NULL THEN
	INSERT INTO person (LastFirstName)
	VALUES (person);
END IF;

IF (SELECT ProjectName FROM project WHERE ProjectName = project) IS NULL THEN
	INSERT INTO project (ProjectName, ProjectStartDate, ProjectEndDate)
	VALUES (project, startdate, enddate);
END IF;

IF (SELECT EXISTS(SELECT Project_idProject, Person_idPerson FROM projecteffort 
WHERE Project_idProject = (SELECT idProject FROM project WHERE ProjectName = project) 
AND Person_idPerson = (SELECT idPerson FROM person WHERE LastFirstName = person))) <> 1 THEN
	INSERT INTO projecteffort (Project_idProject, Person_idPerson, PercentEffort)
	VALUES ((SELECT idProject FROM project WHERE ProjectName = project)
			, (SELECT idPerson FROM person WHERE LastFirstName = person)
			, percentage);
	ELSE UPDATE projecteffort SET PercentEffort = percentage 
	WHERE Project_idProject = (SELECT idProject FROM project WHERE ProjectName = project)
	AND Person_idPerson =(SELECT idPerson FROM person WHERE LastFirstName = person); 
END IF; 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_person_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_person_info`(IN personname VARCHAR(30))
BEGIN
/* Stored Procedure sp_insert_single
 Author: Ariel Roane
 First Version: 06/05/2017
 Revision: 06/05/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 Returns a table with all the projects listed under the person. The php server
 will examine the StatusCD to color the specific rows for different colors based
 on active, pending, or inactive. 
 
 Input: person (First Last Name)
 Output: None
 Algorithm:
 
TEST CASES:
CASE:

RESULT:
 */
DECLARE person_id int;
SET person_id = (SELECT idPerson FROM person WHERE LastFirstName = personname LIMIT 1);

SELECT a.ProjectName AS 'Project Name'
		, a.PI AS 'P.I.'
        , a.ProjectStartDate AS 'Start Date'
        , a.ProjectEndDate AS 'End Date'
        , b.PercentEffort AS 'Percent Effort'
        , a.ProjectStatusCd
FROM project a
JOIN projecteffort b
ON a.idProject = b.Project_idProject
AND b.Person_idPerson = person_id;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_project_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_project_info`(IN theproject VARCHAR(30))
BEGIN
/* Stored Procedure sp_insert_single
 Author: Ariel Roane
 First Version: 06/05/2017
 Revision: 06/05/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 Returns a table with all the people assigned to a project, and their current 
 percent effort towards that project.
 
 Input: person (First Last Name)
 Output: None
 Algorithm:
 
TEST CASES:
CASE:

RESULT:
 */
DECLARE projectid int;
SET projectid = (SELECT idProject FROM project WHERE ProjectName = theproject LIMIT 1);

SELECT a.LastFirstName AS 'Name'
	, b.PercentEffort AS 'Percent Effort'
FROM person a
JOIN projecteffort b
ON a.idPerson = b.Person_idPerson
AND b.Project_idProject = projectid;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_remove_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_remove_record`(IN personName VARCHAR(30), IN projectName VARCHAR(50))
BEGIN
/* Stored Procedure sp_remove_record
 Author: Ariel Roane
 First Version: 05/30/2017
 Revision: 05/30/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
Takes in input in the form of a person's name and a project name and deletes the corresponding
records from the projecteffort table. This will check the product against the projecteffort table,
and if it fails to appear again in another record, the stored procedure will delete the project 
from the project table. 

 Input: person and project
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 DECLARE id_person int;
 DECLARE id_project int;
 
 SET id_person = (SELECT idPerson FROM person WHERE LastFirstName = personName LIMIT 1);
 SET id_project = (SELECT idProject FROM project WHERE ProjectName = projectName LIMIT 1);
 
 -- SELECT id_person, id_project;
 
 DELETE FROM projecteffort WHERE Person_idPerson = id_person
 AND Project_idProject = id_project;
 
 IF id_project
 NOT IN (SELECT Project_idProject FROM projecteffort)
 THEN
 DELETE FROM project WHERE idProject = id_project;
 END IF;
 
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_test_input` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dbauser`@`localhost` PROCEDURE `sp_test_input`(IN person VARCHAR(30), IN project VARCHAR(25), IN percentage FLOAT,
IN testdate VARCHAR(10))
BEGIN
 /* Stored Procedure sp_test_input_2
 Author: Ariel Roane
 First Version: 06/06/2017
 Revision: 06/06/2017
 --------------------------------------------------------------------------------
 SPECIFICATIONS AND DESIGN:
 Improves on former testing input design. Takes the values of the projecteffort table 
 and inserts them into a copied temporary table (of all projecteffort values, including
 the input), then calculates monthly percent effort based on this table. 
 
 Input: 
 Output: None
 Algorithm: 
 
TEST CASES:
CASE:

RESULT:
 */
 -- Variables for IDs
 DECLARE personx int;
 DECLARE projectx int;
 
 -- Variables for Dates and Percentage
 DECLARE nextdate DATE;
 DECLARE yeardate DATE;
 DECLARE percentef FLOAT;
 DECLARE projectstr VARCHAR(100);
 
 -- Get person and project IDs
 SET personx = (SELECT idPerson FROM person WHERE LastFirstName = person LIMIT 1);
 SET projectx = (SELECT idProject FROM project WHERE ProjectName = project LIMIT 1);
 
 -- Create temporary projecteffort table
 CREATE TEMPORARY TABLE temp.projecteffort
 AS
 (SELECT * FROM projecteffort);

-- Insert test record into temporary table
 INSERT INTO temp.projecteffort (Project_idProject, Person_idPerson, PercentEffort)
 VALUES (projectx, personx, percentage);
 
 -- Create temporary table for monthly view
 CREATE TEMPORARY TABLE temp.tablemonthly(
 MonthYear VARCHAR(20) NOT NULL
 , PercentEffort FLOAT
 , Projects VARCHAR(100));
 
-- set variables for while looop
 SET nextdate = STR_TO_DATE(testdate, '%m/%d/%Y') + INTERVAL 1 MONTH;
 SET yeardate = STR_TO_DATE(testdate, '%m/%d/%Y') + INTERVAL 1 YEAR;

-- loop and get percentage effort for this day each month
 WHILE nextdate <= yeardate DO
 
 SET percentef = get_effort2((nextdate - INTERVAL 1 MONTH), person);
 IF percentef IS NULL THEN
	SET percentef = 0.0;
 END IF;
 
 SET projectstr = get_projects((nextdate - INTERVAL 1 MONTH), personx);
 IF projectstr IS NULL THEN
	SET projectstr = 'No Projects';
END IF;
 
 INSERT INTO temp.tablemonthly (MonthYear, PercentEffort, Projects)
 VALUES(CONCAT(MONTHNAME(nextdate - INTERVAL 1 MONTH), ' ', YEAR(nextdate - INTERVAL 1 MONTH)), 
 percentef, projectstr);
 SET nextdate = nextdate + INTERVAL 1 MONTH;
 END WHILE;
 
 SELECT * FROM temp.tablemonthly;
 
DROP TEMPORARY TABLE IF EXISTS temp.tablemonthly;
DROP TEMPORARY TABLE IF EXISTS temp.projecteffort;

 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_current_total_effort`
--

/*!50001 DROP VIEW IF EXISTS `vw_current_total_effort`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbauser`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_current_total_effort` AS select `a`.`LastFirstName` AS `Last, First Name`,sum(`b`.`PercentEffort`) AS `Cumulative Percent Effort`,group_concat(distinct `c`.`Project Name` order by `c`.`Project Name` ASC separator ',') AS `Current Projects` from ((`person` `a` join `projecteffort` `b` on((`a`.`idPerson` = `b`.`Person_idPerson`))) join `vw_currentproject` `c` on(((`b`.`Project_idProject` = `c`.`Project ID`) and (`c`.`ProjectStatusCd` = 1)))) group by `b`.`Person_idPerson` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_currentproject`
--

/*!50001 DROP VIEW IF EXISTS `vw_currentproject`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dbauser`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_currentproject` AS select `project`.`idProject` AS `Project ID`,`project`.`ProjectName` AS `Project Name`,date_format(`project`.`ProjectStartDate`,'%m/%d/%Y') AS `Project Start Date`,date_format(`project`.`ProjectEndDate`,'%m/%d/%Y') AS `Project End Date`,`project`.`ProjectStatusCd` AS `ProjectStatusCd` from `project` where ((curdate() >= `project`.`ProjectStartDate`) and (curdate() <= `project`.`ProjectEndDate`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-16  9:50:22
