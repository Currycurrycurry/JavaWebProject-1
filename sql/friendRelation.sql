
-- 好友关系的表

CREATE TABLE `friendRelation`(
  `userID` INT(11) NOT NULL,
  `friendID` INT(11) NOT NULL,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userID) REFERENCES users(userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX friendRelationID ON friendRelation(userID,friendID);

INSERT INTO `friendRelation` (userID, friendID) VALUES (1,2);
INSERT INTO `friendRelation` (userID, friendID) VALUES (2,1);