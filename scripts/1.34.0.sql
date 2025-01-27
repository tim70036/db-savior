CREATE TABLE `JokerArchive`.`BuddyHorseRaceMahjongGame` (
  `gameId` CHAR(36) NOT NULL,
  `roomId` CHAR(36) NOT NULL,
  `state` INT UNSIGNED NOT NULL,
  `player1` CHAR(36) NOT NULL,
  `player2` CHAR(36) NOT NULL,
  `player3` CHAR(36) NOT NULL,
  `player4` CHAR(36) NOT NULL,
  `scores` MEDIUMTEXT NOT NULL,
  `startTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` INT NOT NULL,
  `bankerWind` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`CommonHorseRaceMahjongGame` (
  `gameId` CHAR(36) NOT NULL,
  `roomId` CHAR(36) NOT NULL,
  `state` INT UNSIGNED NOT NULL,
  `player1` CHAR(36) NOT NULL,
  `player2` CHAR(36) NOT NULL,
  `player3` CHAR(36) NOT NULL,
  `player4` CHAR(36) NOT NULL,
  `scores` MEDIUMTEXT NOT NULL,
  `startTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` INT NOT NULL,
  `bankerWind` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`ClubHorseRaceMahjongGame` (
  `gameId` CHAR(36) NOT NULL,
  `roomId` CHAR(36) NOT NULL,
  `state` INT UNSIGNED NOT NULL,
  `player1` CHAR(36) NOT NULL,
  `player2` CHAR(36) NOT NULL,
  `player3` CHAR(36) NOT NULL,
  `player4` CHAR(36) NOT NULL,
  `scores` MEDIUMTEXT NOT NULL,
  `startTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` INT NOT NULL,
  `bankerWind` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `clubId` CHAR(36) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`HorseRaceMahjongRoundRecord` (
  `gameId` CHAR(36) NOT NULL,
  `round` INT UNSIGNED NOT NULL,
  `bankerWind` INT UNSIGNED NOT NULL,
  `scores` TEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`, `round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`CurrencyRecord` (
  `currencyRecordId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` CHAR(36) NOT NULL,
  `amount` INT NOT NULL,
  `type` INT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`currencyRecordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`MoonCardMissionRecord` (
  `moonCardMissionRecordId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `missionId` INT NOT NULL,
  `uid` CHAR(36) NOT NULL,
  `status` INT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`moonCardMissionRecordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`PrizeRecord` (
  `prizeRecordId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` CHAR(36) NOT NULL,
  `prizeType` INT UNSIGNED NOT NULL,
  `commonPrizes` MEDIUMTEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`prizeRecordId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`CampaignScoreboard` (
  `campaignScoreboardId` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campaignId` CHAR(36) NOT NULL,
  `scoreboardId` CHAR(36) NOT NULL,
  `scoreList` LONGTEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`campaignScoreboardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;