
-- 创建好友消息的数据表
-- 第一个userID为接收消息的用户

CREATE TABLE `message`(
  `userID` INT(11) NOT NULL,
  `friendID` INT(11) NOT NULL,
  `message` longtext NOT NULL,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (userID) REFERENCES users(userID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `message` (userID, friendID, message) VALUES
  (2,1,'33,对于咱们博物馆的建设你有什么好的想法吗?');
INSERT INTO `message` (userID, friendID, message) VALUES
  (1,2,'姐姐,我认为我们的前端还可以做得更酷一点!!');