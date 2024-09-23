CREATE TABLE `JokerArchive`.`QualifierChinesePokerGame` (
  `gameId` CHAR(36) NOT NULL,
  `roomId` CHAR(36) NOT NULL,
  `state` INT UNSIGNED NOT NULL,
  `type` INT UNSIGNED NOT NULL,
  `player1` CHAR(36) NOT NULL,
  `player2` CHAR(36) NOT NULL,
  `player3` CHAR(36) NOT NULL,
  `player4` CHAR(36) NOT NULL,
  `scores` TEXT NOT NULL,
  `endTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`QualifierChinesePokerRoundRecord` (
  `gameId` CHAR(36) NOT NULL,
  `round` INT UNSIGNED NOT NULL,
  `scores` TEXT NOT NULL,
  `jackPotCard` VARCHAR(255) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`, `round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`EliminationChinesePokerGame` (
  `gameId` CHAR(36) NOT NULL,
  `roomId` CHAR(36) NOT NULL,
  `state` INT UNSIGNED NOT NULL,
  `type` INT UNSIGNED NOT NULL,
  `player1` CHAR(36) NOT NULL,
  `player2` CHAR(36) NOT NULL,
  `player3` CHAR(36) NOT NULL,
  `player4` CHAR(36) NOT NULL,
  `scores` TEXT NOT NULL,
  `endTime` DATETIME NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` INT NOT NULL,
  `gameMetaUid` CHAR(36) NOT NULL,
  `gameSetting` TEXT NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `JokerArchive`.`EliminationChinesePokerRoundRecord` (
  `gameId` CHAR(36) NOT NULL,
  `round` INT UNSIGNED NOT NULL,
  `scores` TEXT NOT NULL,
  `jackPotCard` VARCHAR(255) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`, `round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;