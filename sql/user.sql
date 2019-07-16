
-- 创建user 数据表
CREATE TABLE `users` (
  `userID` INT(11) NOT NULL,
  `account` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `isAdmin` BOOLEAN NOT NULL DEFAULT FALSE ,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `signature` VARCHAR(255) NOT NULL,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `account` (`account`);

ALTER TABLE `users`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

INSERT INTO `users` (userID, account, password,isAdmin, name, email, signature) VALUES
  (1,'Admin22','123456',TRUE ,'22娘','22@2233museum.com','这里是博物馆的管理员22娘,请多指教!');
INSERT INTO `users` (userID, account, password,isAdmin, name, email, signature) VALUES
  (2,'Admin33','123456',TRUE ,'33娘','33@2233museum.com','这里是博物馆的管理员33娘,请多指教!');