
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
  (1,'安喜宫绣佛像','images/工艺/安喜宫绣佛像.jpg','明·成化·《安喜宫绣佛像》绣品。长93.2cm，宽31cm。作于成化七年。安喜宫，是成化年间万贵妃居住的宫殿。她于成化二年进封皇贵妃时开始居住，一直居住至成化二十三年春。万氏（1430-1487），也叫万贞儿，青州诸城人。明宪宗朱见深之妃，颇得宠爱，世称万贵妃。绣，是我囯特有的一种手工制作工艺，用针将彩色的线缝在绸或布上构成图案、花纹和文字。又指绣成的物品。',
    '明成化七年','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (2,'鲍天成透雕浮槎犀角杯','images/工艺/鲍天成透雕浮槎犀角杯.jpg','犀角杯为一老者坐独木舟，划行在水浪之中，有“天成”篆书印款。艺人采用圆雕、透雕、浮雕和浅刻相结合的技法，使整个作品层次丰富，雕刻精湛。鲍天成，明代吴县（今江苏苏州）人，牙角雕名匠，他的犀角雕被誉为“吴中绝技”。',
    '明末清初','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (3,'缂丝花鸟图','images/工艺/缂丝花鸟图.jpg','缂丝又称刻丝，是中国汉族丝绸艺术品中的精华。这是一种经彩纬显现花纹，形成花纹边界，具有犹如雕琢缕刻的效果，且富双面立体感的丝织工艺品。缂丝的编织方法不同于刺绣和织锦。它采用“通经断纬”的织法，而一般锦的织法皆为“通经通纬”法，即纬线穿通织物的整个幅面。缂丝能自由变换色彩，因而特别适宜制作书画作品。缂织彩纬的织工须有一定的艺术造诣。缂丝织物的结构则遵循“细经粗纬”、“白经彩纬”、“直经曲纬”等原则。即：本色经细，彩色纬粗，以纬缂经，只显彩纬而不露经线等。由于彩纬充分覆盖于织物上部，织后不会因纬线收缩而影响画面花纹的效果。',
    '清 乾隆','上海美术馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (4,'满族平金绣云龙纹朝袍','images/工艺/满族平金绣云龙纹朝袍.jpg','长131.5厘米 宽191厘米,满族历史悠久，文化发达，其服饰高雅华丽。满族服饰源出狩猎和征战需要，大襟无领窄袖，上加披领，袖端加半圆袖口，因形似而称“马蹄袖”，又名箭袖，原为护手实用，后成礼服定制。这件礼服在缎质面料上用金线盘绣成云龙海浪图案，富丽堂皇。披领，又称披肩，是满族独具特色的服饰，呈菱状戴在颈间，披于肩上，是文武百官穿礼服时的一种领饰。',
    '清','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (5,'鸟纹玉璧','images/工艺/鸟纹玉璧.jpg','良渚文化的玉璧通常直径较大，其多数素面无纹，一般用于祭天。此件鸟纹玉璧与美国弗利尔博物馆所藏的玉璧颇为相像。玉璧上方刻画小鸟一只，其作为神使通常为先民崇拜的图腾神。“鸟立高台”的纹样大约与“通天”等意象有所关联，带有此种纹样的同类玉器在至今所见的国内外存世玉器中不过数件，因此具有极高的研究价值。',
   '西汉','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (6,'玉鹿','images/工艺/玉鹿.jpg','宋代玉鹿的雕法有两种：第一种的特点是头部细长，有的上唇略往上翘。或为长角，或为蘑菇状，俗称珍珠盘，阴刻三角形眼。鹿肩与脖子间有较深的凹槽断开，一些鹿的肩部或后肢前上部饰有近似火焰的纹饰，小短尾，后肢的上肢粗大，下段细瘦，尤其近腿弯处更瘦，近足处却略粗；蹄部琢制简练，侧面近似三角形，其上有一道阴刻线，有些鹿的上中还衔有灵芝或蔓草。',
   '宋','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (7,'竹雕提梁卣','images/工艺/竹雕提梁卣.jpg','笔筒一面浮雕三国时东吴名媛大小乔咏读书卷的画面，风鬟雾鬓纤毫毕现，丰肌美姿有不胜绮罗之态。杌、榻、文具、瓶、炉、花、尊等道具也镂刻得一丝不苟，烘托出恬静清雅的书香气息。另一面刻阳文“雀台赋好重江东，车载才人败下风。更有金闺双俊眼，齐称子建是英雄。吴之璠”，阳文印“鲁珍”，阴文起首印“宝”。纹饰之外，悉剔为平地，使花纹微微高起。肌肤润泽的竹丝素地与精雕细刻的纹饰对比明显，相映生色。在吴氏“薄地阳文”样式的作品中，此件浮雕凸起度较高，接近高浮雕，可见吴之璠在技法上并不拘泥于某种特定程式，而是根据艺术需要灵活处理。',
   '清','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (8,'竹根雕蝠桃盂','images/工艺/竹根雕蝠桃盂.jpg','竹根雕刻的历史很久远，仅文献记载可追溯到南北朝时期。明清以来的竹木牙角玉石等各色材料制作的小型工艺雕刻，有着清新活泼的气息。其中尤以竹雕艺术成就最高。自明正、嘉间嘉定朱鹤开创竹雕艺术以来，竹根雕刻一直是其重要组成部分，竹刻名手多能为之，但到清中叶之后，竹根雕刻制者日稀，逐渐衰落。竹雕品主要使用竹茎与竹根部位从事雕刻。竹茎即竹干，圆而中空，适宜制作笔筒、臂搁、香筒等器物，技法多为阴刻、浮雕、皮雕与透雕。如需琢制立体的人物、动物、山水小景或水丞、杯、盒一类的器皿，就必须使用节密内厚的竹根为材。',
   '清','上海博物馆','');
INSERT INTO `item` (itemID, name, imagePath, description, year, address, videoPath) VALUES
  (9,'竹根雕群仙祝寿山','images/工艺/竹根雕群仙祝寿山.jpg','高30cm、最宽19.5cm。 器型为清代盛行的山子摆件，以“群仙祝寿”为题材，作通景圆雕镂刻，整座蓬莱仙山巍峨雄浑，曲径盘绕而上，直通金顶，其间楼台叠翠，洞府藏幽；苍劲松风，隐然似见雾霭祥云，湮湮渺渺，溪涧潜行，虎啸龙吟。各路仙人拾阶而上，或行谈怡然，或亭阁小聚，一片喜庆之声。巧匠将整块竹根雕成山形，构思宏大，又集圆雕、浮雕、阴阳刻、镂透雕诸法，刀法老熟细腻。通体近百个人物，情态各异；诸景物内容丰富而错落有致，生气焕然。尤为竹雕中极珍罕巨作。',
   '清','上海博物馆','');
