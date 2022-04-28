CREATE DATABASE  IF NOT EXISTS `JokerArchive` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `JokerArchive`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: lom-snapshot-0329.cqkuwpenkdlx.ap-east-1.rds.amazonaws.com    Database: JokerArchive
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BuddyMahjongGame`
--

DROP TABLE IF EXISTS `BuddyMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BuddyMahjongGame` (
  `gameId` varchar(45) NOT NULL,
  `roomId` varchar(45) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` varchar(45) NOT NULL DEFAULT '',
  `player2` varchar(45) NOT NULL DEFAULT '',
  `player3` varchar(45) NOT NULL DEFAULT '',
  `player4` varchar(45) NOT NULL DEFAULT '',
  `scores` mediumtext NOT NULL,
  `gameSettingType` int unsigned NOT NULL DEFAULT '0',
  `gameSetting` mediumtext NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `type` int unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CashRecord`
--

DROP TABLE IF EXISTS `CashRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CashRecord` (
  `cashRecordId` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(45) NOT NULL,
  `type` int NOT NULL DEFAULT '0',
  `beforeCash` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `water` int NOT NULL DEFAULT '0',
  `createTime` datetime NOT NULL DEFAULT '3000-01-01 00:00:00',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cashRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=10226933 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CashScoreBoard`
--

DROP TABLE IF EXISTS `CashScoreBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CashScoreBoard` (
  `cashScoreBoardId` int NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cashScoreBoardId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ClubDualMahjongGame`
--

DROP TABLE IF EXISTS `ClubDualMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ClubDualMahjongGame` (
  `gameId` char(36) NOT NULL,
  `roomId` char(36) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` char(36) NOT NULL,
  `player2` char(36) NOT NULL,
  `scores` text NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `game` int unsigned NOT NULL,
  `mode` int unsigned NOT NULL,
  `round` int unsigned NOT NULL,
  `bankerWind` int unsigned NOT NULL,
  `prevailWind` int unsigned NOT NULL,
  `gameMetaUid` char(36) NOT NULL,
  `gameSetting` text NOT NULL,
  `clubId` char(36) NOT NULL,
  `gameSettingId` char(36) NOT NULL,
  `waterPct` int NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ClubMahjongGame`
--

DROP TABLE IF EXISTS `ClubMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ClubMahjongGame` (
  `gameId` varchar(45) NOT NULL,
  `roomId` varchar(45) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` varchar(45) NOT NULL DEFAULT '',
  `player2` varchar(45) NOT NULL DEFAULT '',
  `player3` varchar(45) NOT NULL DEFAULT '',
  `player4` varchar(45) NOT NULL DEFAULT '',
  `scores` mediumtext NOT NULL,
  `gameSettingType` int unsigned NOT NULL DEFAULT '0',
  `gameSetting` mediumtext NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `type` int unsigned NOT NULL DEFAULT '0',
  `clubId` varchar(45) NOT NULL,
  `gameSettingId` varchar(45) DEFAULT NULL,
  `waterPct` int unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CommonDualMahjongGame`
--

DROP TABLE IF EXISTS `CommonDualMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CommonDualMahjongGame` (
  `gameId` char(36) NOT NULL,
  `roomId` char(36) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` char(36) NOT NULL,
  `player2` char(36) NOT NULL,
  `scores` text NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `game` int NOT NULL,
  `mode` int NOT NULL,
  `round` int NOT NULL,
  `bankerWind` int NOT NULL,
  `prevailWind` int NOT NULL,
  `gameMetaUid` char(36) NOT NULL,
  `gameSetting` text NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CommonMahjongGame`
--

DROP TABLE IF EXISTS `CommonMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CommonMahjongGame` (
  `gameId` varchar(45) NOT NULL,
  `roomId` varchar(45) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` varchar(45) NOT NULL DEFAULT '',
  `player2` varchar(45) NOT NULL DEFAULT '',
  `player3` varchar(45) NOT NULL DEFAULT '',
  `player4` varchar(45) NOT NULL DEFAULT '',
  `scores` mediumtext NOT NULL,
  `gameSettingType` int unsigned NOT NULL DEFAULT '0',
  `gameSetting` mediumtext NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `type` int unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DualMahjongRoundRecord`
--

DROP TABLE IF EXISTS `DualMahjongRoundRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DualMahjongRoundRecord` (
  `gameId` char(36) NOT NULL,
  `round` int unsigned NOT NULL,
  `bankerWind` int unsigned NOT NULL,
  `prevailWind` int unsigned NOT NULL,
  `scores` text NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ExpRecord`
--

DROP TABLE IF EXISTS `ExpRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExpRecord` (
  `expRecordId` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(45) NOT NULL,
  `type` int NOT NULL DEFAULT '0',
  `refId` varchar(45) DEFAULT '',
  `beforeLevel` int NOT NULL DEFAULT '1',
  `beforeExp` int NOT NULL DEFAULT '0',
  `increaseExp` int NOT NULL DEFAULT '0',
  `createTime` datetime NOT NULL DEFAULT '3000-01-01 00:00:00',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=2152725 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ExpScoreBoard`
--

DROP TABLE IF EXISTS `ExpScoreBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ExpScoreBoard` (
  `expScoreBoardId` int NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`expScoreBoardId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GoldRecord`
--

DROP TABLE IF EXISTS `GoldRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GoldRecord` (
  `goldRecordId` int NOT NULL AUTO_INCREMENT,
  `memberId` varchar(45) NOT NULL,
  `beforeGold` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `water` int NOT NULL DEFAULT '0',
  `rewardGold` decimal(8,1) NOT NULL DEFAULT '0.0',
  `createTime` datetime NOT NULL DEFAULT '3000-01-01 00:00:00',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gameType` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`goldRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=7174163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MahjongRoundRecord`
--

DROP TABLE IF EXISTS `MahjongRoundRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MahjongRoundRecord` (
  `gameId` char(45) NOT NULL,
  `round` int unsigned NOT NULL,
  `bankerWind` int unsigned NOT NULL,
  `prevailWind` int unsigned NOT NULL,
  `scores` text NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MissionGame`
--

DROP TABLE IF EXISTS `MissionGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MissionGame` (
  `missionGameId` varchar(45) NOT NULL,
  `uid` varchar(45) NOT NULL,
  `missions` mediumtext NOT NULL,
  `rewardPoints` int unsigned NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RankMahjongGame`
--

DROP TABLE IF EXISTS `RankMahjongGame`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RankMahjongGame` (
  `gameId` varchar(45) NOT NULL,
  `roomId` varchar(45) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` varchar(45) NOT NULL DEFAULT '',
  `player2` varchar(45) NOT NULL DEFAULT '',
  `player3` varchar(45) NOT NULL DEFAULT '',
  `player4` varchar(45) NOT NULL DEFAULT '',
  `scores` mediumtext NOT NULL,
  `gameSettingType` int unsigned NOT NULL DEFAULT '0',
  `gameSetting` mediumtext NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `type` int unsigned NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RankRecord`
--

DROP TABLE IF EXISTS `RankRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RankRecord` (
  `rankRecordId` varchar(45) NOT NULL,
  `uid` varchar(45) NOT NULL,
  `refId` varchar(45) DEFAULT NULL,
  `beforeRank` int unsigned NOT NULL,
  `afterRank` int unsigned NOT NULL,
  `beforeRankPoint` int unsigned NOT NULL,
  `increaseRankPoint` int DEFAULT NULL,
  `afterRankPoint` int unsigned NOT NULL,
  `beforeRate` double NOT NULL,
  `increaseRate` double DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rankRecordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RankScoreBoard`
--

DROP TABLE IF EXISTS `RankScoreBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RankScoreBoard` (
  `rankScoreBoardId` int NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rankScoreBoardId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RichManScoreBoard`
--

DROP TABLE IF EXISTS `RichManScoreBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RichManScoreBoard` (
  `richManScoreBoardId` int NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`richManScoreBoardId`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TicketRecord`
--

DROP TABLE IF EXISTS `TicketRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TicketRecord` (
  `ticketRecordId` int NOT NULL AUTO_INCREMENT,
  `memberId` varchar(45) NOT NULL,
  `beforeTicket` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `createTime` datetime NOT NULL DEFAULT '3000-01-01 00:00:00',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gameType` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ticketRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=497869 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `TransactionRecord`
--

DROP TABLE IF EXISTS `TransactionRecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TransactionRecord` (
  `transactionRecordId` varchar(45) NOT NULL,
  `fromMemberId` varchar(45) NOT NULL,
  `toMemberId` varchar(45) NOT NULL,
  `transactionType` int NOT NULL,
  `gold` int NOT NULL,
  `ticket` int NOT NULL,
  `status` int NOT NULL,
  `createTime` datetime NOT NULL DEFAULT '3000-01-01 00:00:00',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`transactionRecordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WinRateScoreBoard`
--

DROP TABLE IF EXISTS `WinRateScoreBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WinRateScoreBoard` (
  `winRateScoreBoardId` int NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`winRateScoreBoardId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-26 13:53:53
