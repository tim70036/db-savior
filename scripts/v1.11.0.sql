USE JokerArchive;

CREATE TABLE `MissionGameScoreBoard` (
  `missionGameScoreBoardId` int unsigned NOT NULL AUTO_INCREMENT,
  `scoreList` longtext NOT NULL,
  `startTime` datetime NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`missionGameScoreBoardId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
