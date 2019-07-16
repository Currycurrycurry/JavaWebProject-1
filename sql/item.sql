
-- 创建展品数据表
CREATE TABLE `item`(
  `itemID` INT(11) NOT NULL ,
  `name` VARCHAR(255) NOT NULL,
  `imagePath` VARCHAR(255) NOT NULL,
  `description` longtext NOT NULL,
  `year` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `view` int(11) NOT NULL DEFAULT '0',
  `videoPath`  VARCHAR(255) NOT NULL,
  `timeReleased` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `item`
    ADD PRIMARY KEY (`itemID`);

ALTER TABLE `item`
  MODIFY `itemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1000;

INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (1,'安喜宫绣佛像','工艺/安喜宫绣佛像.jpg','明·成化·《安喜宫绣佛像》绣品。长93.2cm，宽31cm。作于成化七年。安喜宫，是成化年间万贵妃居住的宫殿。她于成化二年进封皇贵妃时开始居住，一直居住至成化二十三年春。万氏（1430-1487），也叫万贞儿，青州诸城人。明宪宗朱见深之妃，颇得宠爱，世称万贵妃。绣，是我囯特有的一种手工制作工艺，用针将彩色的线缝在绸或布上构成图案、花纹和文字。又指绣成的物品。',
    '明成化七年','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (2,'鲍天成透雕浮槎犀角杯','工艺/鲍天成透雕浮槎犀角杯.jpg','犀角杯为一老者坐独木舟，划行在水浪之中，有“天成”篆书印款。艺人采用圆雕、透雕、浮雕和浅刻相结合的技法，使整个作品层次丰富，雕刻精湛。鲍天成，明代吴县（今江苏苏州）人，牙角雕名匠，他的犀角雕被誉为“吴中绝技”。',
    '明末清初','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (3,'缂丝花鸟图','工艺/缂丝花鸟图.jpg','缂丝又称刻丝，是中国汉族丝绸艺术品中的精华。这是一种经彩纬显现花纹，形成花纹边界，具有犹如雕琢缕刻的效果，且富双面立体感的丝织工艺品。缂丝的编织方法不同于刺绣和织锦。它采用“通经断纬”的织法，而一般锦的织法皆为“通经通纬”法，即纬线穿通织物的整个幅面。缂丝能自由变换色彩，因而特别适宜制作书画作品。缂织彩纬的织工须有一定的艺术造诣。缂丝织物的结构则遵循“细经粗纬”、“白经彩纬”、“直经曲纬”等原则。即：本色经细，彩色纬粗，以纬缂经，只显彩纬而不露经线等。由于彩纬充分覆盖于织物上部，织后不会因纬线收缩而影响画面花纹的效果。',
    '清 乾隆','上海美术馆','');