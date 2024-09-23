USE JokerArchive;

CREATE TABLE `JokerArchive`.`NewClubMahjongGame` (
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
  `prevailWind` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `clubId` CHAR(36) NOT NULL,
  `waterPct` INT UNSIGNED NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;