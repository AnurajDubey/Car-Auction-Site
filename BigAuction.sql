
UNLOCK TABLES;
DROP DATABASE IF EXISTS `BigAuctionDB`; 
CREATE DATABASE  IF NOT EXISTS `BigAuctionDB` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `BigAuctionDB`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com    Database: BigAuctionDB
-- ------------------------------------------------------
-- Server version	5.6.35-logs

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
SET GLOBAL event_scheduler = ON;
--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`),
  FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add admin to users first, then to admin
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('ggeyts@gmail.com','BigGabe','BigGabeSoCool');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('ggeyts@gmail.com');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep`
--

DROP TABLE IF EXISTS `rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rep` (
  `email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`email`),
  FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Add rep to users first, then to rep
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('hhuerta@gmail.com','BigHenry','BigGabeSoCool');
INSERT INTO `users` VALUES ('bigBuyer@gmail.com','BigBuyer','BigGabeSoCool');
INSERT INTO `users` VALUES ('bigBuyer2@gmail.com','BigBuyer2','BigGabeSoCool');
INSERT INTO `users` VALUES ('bigSeller@gmail.com','BigSeller','BigGabeSoCool');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `rep` WRITE;
/*!40000 ALTER TABLE `rep` DISABLE KEYS */;
INSERT INTO `rep` VALUES ('hhuerta@gmail.com');
/*!40000 ALTER TABLE `rep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES ('FancyYacht',1);
INSERT INTO `item` VALUES ('BeautifulBoat',2);
INSERT INTO `item` VALUES ('CraftyCaravel',3);
INSERT INTO `item` VALUES ('SatisfactorySedan',4);
INSERT INTO `item` VALUES ('ToughTruck',5);
INSERT INTO `item` VALUES ('SupremeSUV',6);
INSERT INTO `item` VALUES ('HeftyHeli',7);
INSERT INTO `item` VALUES ('LuxuryLearJet',8);
INSERT INTO `item` VALUES ('AwesomeAirliner',9);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertID` int(11) AUTO_INCREMENT,
  `vehicleCategory` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `att1` varchar(50) DEFAULT NULL,
  `att2` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`alertID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `notificationID` int(11) AUTO_INCREMENT,
  `email` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  
  `notification_text` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`notificationID`),
  FOREIGN KEY (`email`) REFERENCES `users` (`email`),
  FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid` (
  `amount` int NOT NULL DEFAULT 0,
  `bidID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bidID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
/*INSERT INTO `bid` VALUES (5, 1);*/
INSERT INTO `bid` VALUES (15, 2);
INSERT INTO `bid` VALUES (25, 3);
INSERT INTO `bid` VALUES (35, 4);
INSERT INTO `bid` VALUES (45, 5);
INSERT INTO `bid` VALUES (55, 6);
INSERT INTO `bid` VALUES (65, 7);
INSERT INTO `bid` VALUES (75, 8);
INSERT INTO `bid` VALUES (85, 9);
INSERT INTO `bid` VALUES (100, 10);
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auction` (
  `auctionID` int(11) NOT NULL AUTO_INCREMENT,
  `endDate` dateTime NOT NULL DEFAULT '2009-05-25',
  `valid` boolean NOT NULL DEFAULT true,
  `reserve` int DEFAULT NULL,
  PRIMARY KEY (`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP EVENT IF EXISTS check_if_auction_is_valid;
CREATE EVENT IF NOT EXISTS check_if_auction_is_valid 
    ON SCHEDULE
        EVERY 10 SECOND
    DO
        UPDATE `auction` 
        SET `valid` = FALSE
        WHERE `endDate` < SYSDATE();
        
        
LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES (1, '2022-05-26', true, 40);
INSERT INTO `auction` VALUES (2, '2022-05-27', true, 40);
INSERT INTO `auction` VALUES (3, '2022-05-28', true, 40);
INSERT INTO `auction` VALUES (4, '2022-05-15', true, 40);
INSERT INTO `auction` VALUES (5, '2022-05-16', true, 40);
INSERT INTO `auction` VALUES (6, '2022-05-17', true, 40);
INSERT INTO `auction` VALUES (7, '2022-08-25', true, 40);
INSERT INTO `auction` VALUES (8, '2022-09-25', true, 40);
INSERT INTO `auction` VALUES (9, '2022-01-25', true, 40);
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasAlerts`
--

DROP TABLE IF EXISTS `hasAlerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hasAlerts` (
  `alertID` int(11) DEFAULT 0,
  `email` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`alertID`, `email`),
  FOREIGN KEY (`alertID`) REFERENCES `alerts` (`alertID`),
  FOREIGN KEY (`email`) REFERENCES `users` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyer` (
  `auctionID` int(11) DEFAULT 0,
  `email` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  `automatic` boolean DEFAULT false,
  `increment` int(11) DEFAULT 0,
  `limit` int(11) DEFAULT 0,
  PRIMARY KEY (`auctionID`, `email`, `itemID`),
  FOREIGN KEY (`auctionID`) references `auction` (`auctionID`),
  FOREIGN KEY (`email`) references `users` (`email`),
  FOREIGN KEY (`itemID`) references `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
INSERT INTO `buyer` VALUES (1,'bigBuyer@gmail.com',1, false, 0, 0);
INSERT INTO `buyer` VALUES (2,'bigBuyer@gmail.com',2, false, 0, 0);
INSERT INTO `buyer` VALUES (3,'bigBuyer@gmail.com',3, false, 0, 0);
INSERT INTO `buyer` VALUES (4,'bigBuyer@gmail.com',4, false, 0, 0);
INSERT INTO `buyer` VALUES (5,'bigBuyer@gmail.com',5, false, 0, 0);
INSERT INTO `buyer` VALUES (6,'bigBuyer@gmail.com',6, false, 0, 0);
INSERT INTO `buyer` VALUES (7,'bigBuyer@gmail.com',7, false, 0, 0);
INSERT INTO `buyer` VALUES (8,'bigBuyer@gmail.com',8, false, 0, 0);
INSERT INTO `buyer` VALUES (9,'bigSeller@gmail.com',9, false, 0, 0);
INSERT INTO `buyer` VALUES (9,'bigBuyer2@gmail.com',9, false, 0, 0);
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seller` (
  `auctionID` int(11) DEFAULT 0,
  `email` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  PRIMARY KEY (`auctionID`, `email`, `itemID`),
  FOREIGN KEY (`auctionID`) references `auction` (`auctionID`),
  FOREIGN KEY (`email`) references `users` (`email`),
  FOREIGN KEY (`itemID`) references `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
INSERT INTO `seller` VALUES (1,'bigSeller@gmail.com',1);
INSERT INTO `seller` VALUES (2,'bigSeller@gmail.com',2);
INSERT INTO `seller` VALUES (3,'bigSeller@gmail.com',3);
INSERT INTO `seller` VALUES (4,'bigSeller@gmail.com',4);
INSERT INTO `seller` VALUES (5,'bigSeller@gmail.com',5);
INSERT INTO `seller` VALUES (6,'bigSeller@gmail.com',6);
INSERT INTO `seller` VALUES (7,'bigSeller@gmail.com',7);
INSERT INTO `seller` VALUES (8,'bigSeller@gmail.com',8);
INSERT INTO `seller` VALUES (9,'bigBuyer@gmail.com',9);
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasBid`
--

DROP TABLE IF EXISTS `hasBid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hasBid` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `bidID` int(11) DEFAULT 0,
  PRIMARY KEY (`email`, `bidID`),
  FOREIGN KEY (`email`) references `users` (`email`),
  FOREIGN KEY (`bidID`) references `bid` (`bidID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `hasBid` WRITE;
/*!40000 ALTER TABLE `hasBid` DISABLE KEYS */;
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 1);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 2);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 3);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 4);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 5);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 6);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 7);
INSERT INTO `hasBid` VALUES ('bigBuyer@gmail.com', 8);
INSERT INTO `hasBid` VALUES ('bigSeller@gmail.com', 9);
INSERT INTO `hasBid` VALUES ('bigBuyer2@gmail.com', 10);
/*!40000 ALTER TABLE `hasBid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidFor`
--

DROP TABLE IF EXISTS `bidFor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bidFor` (
  `auctionID` int(11) DEFAULT 0,
  `bidID` int(11) DEFAULT 0,
  `itemID` int(11) DEFAULT 0,
  PRIMARY KEY (`auctionID`, `bidID`, `itemID`),
  FOREIGN KEY (`auctionID`) references `auction` (`auctionID`),
  FOREIGN KEY (`bidID`) references `bid` (`bidID`),
  FOREIGN KEY (`itemID`) references `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `bidFor` WRITE;
/*!40000 ALTER TABLE `bidFor` DISABLE KEYS */;
INSERT INTO `bidFor` VALUES (1,1,1);
INSERT INTO `bidFor` VALUES (2,2,2);
INSERT INTO `bidFor` VALUES (3,3,3);
INSERT INTO `bidFor` VALUES (4,4,4);
INSERT INTO `bidFor` VALUES (5,5,5);
INSERT INTO `bidFor` VALUES (6,6,6);
INSERT INTO `bidFor` VALUES (7,7,7);
INSERT INTO `bidFor` VALUES (8,8,8);
INSERT INTO `bidFor` VALUES (9,9,9);
INSERT INTO `bidFor` VALUES (9,10,9);
/*!40000 ALTER TABLE `bidFor` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `itemsSold`
--

DROP TABLE IF EXISTS `itemsSold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemsSold` (
  `auctionID` int(11) DEFAULT 0,
  `itemID` int(11) DEFAULT 0,
  PRIMARY KEY (`auctionID`, `itemID`),
  FOREIGN KEY (`auctionID`) references `auction` (`auctionID`),
  FOREIGN KEY (`itemID`) references `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `itemsSold` WRITE;
/*!40000 ALTER TABLE `itemsSold` DISABLE KEYS */;
INSERT INTO `itemsSold` VALUES (1,1);
INSERT INTO `itemsSold` VALUES (2,2);
INSERT INTO `itemsSold` VALUES (3,3);
INSERT INTO `itemsSold` VALUES (4,4);
INSERT INTO `itemsSold` VALUES (5,5);
INSERT INTO `itemsSold` VALUES (6,6);
INSERT INTO `itemsSold` VALUES (7,7);
INSERT INTO `itemsSold` VALUES (8,8);
INSERT INTO `itemsSold` VALUES (9,9);
/*!40000 ALTER TABLE `itemsSold` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `car` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `mileage` int DEFAULT 0,
  `drivetrain` varchar(50) NOT NULL DEFAULT '',
  `car_type` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES ('SatisfactorySedan', 10000, '4WD', 'sedan', 4);
INSERT INTO `car` VALUES ('ToughTruck', 60000, '4WD', 'truck', 5);
INSERT INTO `car` VALUES ('SupremeSUV', 90000, '2WD', 'suv', 6);
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `plane`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plane` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `wingspan` int DEFAULT 0,
  `capacity` int DEFAULT 0,
  `plane_type` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `plane` WRITE;
/*!40000 ALTER TABLE `plane` DISABLE KEYS */;
INSERT INTO `plane` VALUES ('HeftyHeli', 20, 4, 'heli', 7);
INSERT INTO `plane` VALUES ('LuxuryLearJet', 60, 25, 'private_jet', 8);
INSERT INTO `plane` VALUES ('AwesomeAirliner', 120, 155, 'airliner', 9);
/*!40000 ALTER TABLE `plane` ENABLE KEYS */;
UNLOCK TABLES;



DROP TABLE IF EXISTS `boat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boat` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `topspeed` int DEFAULT 0,
  `width` int DEFAULT 0,
  `boat_type` varchar(50) NOT NULL DEFAULT '',
  `itemID` int(11) DEFAULT 0,
  FOREIGN KEY (`itemID`) REFERENCES `item` (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `boat` WRITE;
/*!40000 ALTER TABLE `boat` DISABLE KEYS */;
INSERT INTO `boat` VALUES ('FancyYacht', 100, 20, 'yacht', 1);
INSERT INTO `boat` VALUES ('BeautifulBoat', 50, 24, 'yacht', 2);
INSERT INTO `boat` VALUES ('CraftyCaravel', 130, 40, 'caravel', 3);
/*!40000 ALTER TABLE `boat` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (

  `question` varchar(50) NOT NULL DEFAULT '',
  `answer` varchar(50),
  `qID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`qID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES ('Do boats stay afloat?','Yes, boats stay afloat.',0);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;
