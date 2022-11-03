USE JokerArchive;
CREATE TABLE `GachaRecord` (
  `recordId` char(36) NOT NULL,
  `round` int NOT NULL,
  `poolId` char(36) NOT NULL,
  `uid` char(36) NOT NULL,
  `itemId` int NOT NULL,
  `amount` int NOT NULL,
  `durationType` int NOT NULL,
  `isTransformed` tinyint(1) NOT NULL,
  `rarity` int NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`recordId`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `ItemExchangeRecord` (
  `itemExchangeRecordId` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `itemId` int NOT NULL,
  `durationType` int NOT NULL,
  `amount` int NOT NULL,
  `consumedItemId` int NOT NULL,
  `consumedAmount` int NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`itemExchangeRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `CarnivalMahjongGame` (
  `gameId` char(36) NOT NULL,
  `roomId` char(36) NOT NULL,
  `state` int unsigned NOT NULL,
  `player1` char(36) NOT NULL,
  `player2` char(36) NOT NULL,
  `player3` char(36) NOT NULL,
  `player4` char(36) NOT NULL,
  `scores` mediumtext NOT NULL,
  `gameSettingType` int unsigned NOT NULL,
  `gameSetting` mediumtext NOT NULL,
  `startTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `type` int unsigned NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `BuddyChinesePokerGame` (
  `gameId` char(36) NOT NULL,
  `roomId` char(36) NOT NULL,
  `state` int unsigned NOT NULL,
  `type` int unsigned NOT NULL,
  `player1` char(36) NOT NULL,
  `player2` char(36) NOT NULL,
  `player3` char(36) NOT NULL,
  `player4` char(36) NOT NULL,
  `scores` text NOT NULL,
  `endTime` datetime NOT NULL DEFAULT '2037-01-01 00:00:00',
  `round` int NOT NULL,
  `gameMetaUid` char(36) NOT NULL,
  `gameSetting` text NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `BuddyChinesePokerRoundRecord` (
  `gameId` char(36) NOT NULL,
  `round` int unsigned NOT NULL,
  `scores` text NOT NULL,
  `jackPotCard` varchar(255) NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameId`,`round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `BuddyDualMahjongGame` (
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

CREATE TABLE `AchievementShopPurchaseRecord` (
  `achievementShopPurchaseRecordId` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `itemId` int NOT NULL,
  `durationType` int NOT NULL,
  `itemAmount` int NOT NULL,
  `price` int NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`achievementShopPurchaseRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `CarnivalShopPurchaseRecord` (
  `carnivalShopPurchaseRecordId` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` char(36) NOT NULL,
  `itemId` int NOT NULL,
  `durationType` int NOT NULL,
  `itemAmount` int NOT NULL,
  `price` int NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`carnivalShopPurchaseRecordId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `RankRecord` 
CHANGE COLUMN `increaseRankPoint` `pointChanged` INT NOT NULL,
CHANGE COLUMN `increaseRate` `rateChanged` DOUBLE NOT NULL ;

ALTER TABLE `RankRecord` 
ADD COLUMN `extraPointChanged` INT NOT NULL AFTER `pointChanged`;
