
-- 收藏夹数据表

CREATE TABLE `collection`(
  `userID` INT(11) NOT NULL,
  `itemID` INT(11) NOT NULL,
  `isPublic` BOOLEAN NOT NULL DEFAULT TRUE,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userID) REFERENCES users(userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX collectionID ON collection(userID,itemID);

INSERT INTO `collection` (userID, itemID, isPublic) VALUES (1,1,TRUE );
INSERT INTO `collection` (userID, itemID, isPublic) VALUES (1,2,TRUE );
INSERT INTO `collection` (userID, itemID, isPublic) VALUES (1,3,FALSE);