
-- 发送好友请求的表

CREATE TABLE `friendRequest`(
  `sendFrom_ID` INT(11) NOT NULL,
  `sendTo_ID` INT(11) NOT NULL,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE UNIQUE INDEX friendRequestID ON friendRequest(sendFrom_ID,sendTo_ID);

