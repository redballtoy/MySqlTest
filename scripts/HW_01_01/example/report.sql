-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.21
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `help_keyword`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `help_keyword` (
  `help_keyword_id` int unsigned NOT NULL,
  `name` char(64) NOT NULL,
  PRIMARY KEY (`help_keyword_id`),
  UNIQUE KEY `name` (`name`)
) /*!50100 TABLESPACE `mysql` */ ENGINE=InnoDB DEFAULT CHARSET=utf8 STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC COMMENT='help keywords';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help_keyword`
--
-- WHERE:  1 limit 100

INSERT INTO `help_keyword` VALUES (226,'(JSON');
INSERT INTO `help_keyword` VALUES (227,'->');
INSERT INTO `help_keyword` VALUES (229,'->>');
INSERT INTO `help_keyword` VALUES (46,'<>');
INSERT INTO `help_keyword` VALUES (637,'ACCOUNT');
INSERT INTO `help_keyword` VALUES (439,'ACTION');
INSERT INTO `help_keyword` VALUES (40,'ADD');
INSERT INTO `help_keyword` VALUES (663,'ADMIN');
INSERT INTO `help_keyword` VALUES (108,'AES_DECRYPT');
INSERT INTO `help_keyword` VALUES (109,'AES_ENCRYPT');
INSERT INTO `help_keyword` VALUES (358,'AFTER');
INSERT INTO `help_keyword` VALUES (95,'AGAINST');
INSERT INTO `help_keyword` VALUES (684,'AGGREGATE');
INSERT INTO `help_keyword` VALUES (359,'ALGORITHM');
INSERT INTO `help_keyword` VALUES (502,'ALL');
INSERT INTO `help_keyword` VALUES (41,'ALTER');
INSERT INTO `help_keyword` VALUES (360,'ANALYZE');
INSERT INTO `help_keyword` VALUES (47,'AND');
INSERT INTO `help_keyword` VALUES (313,'ANY_VALUE');
INSERT INTO `help_keyword` VALUES (440,'ARCHIVE');
INSERT INTO `help_keyword` VALUES (102,'ARRAY');
INSERT INTO `help_keyword` VALUES (503,'AS');
INSERT INTO `help_keyword` VALUES (261,'ASC');
INSERT INTO `help_keyword` VALUES (421,'AT');
INSERT INTO `help_keyword` VALUES (638,'ATTRIBUTE');
INSERT INTO `help_keyword` VALUES (526,'AUTOCOMMIT');
INSERT INTO `help_keyword` VALUES (462,'AUTOEXTEND_SIZE');
INSERT INTO `help_keyword` VALUES (361,'AUTO_INCREMENT');
INSERT INTO `help_keyword` VALUES (362,'AVG_ROW_LENGTH');
INSERT INTO `help_keyword` VALUES (538,'BACKUP');
INSERT INTO `help_keyword` VALUES (552,'BEFORE');
INSERT INTO `help_keyword` VALUES (527,'BEGIN');
INSERT INTO `help_keyword` VALUES (48,'BETWEEN');
INSERT INTO `help_keyword` VALUES (59,'BIGINT');
INSERT INTO `help_keyword` VALUES (104,'BINARY');
INSERT INTO `help_keyword` VALUES (342,'BINLOG');
INSERT INTO `help_keyword` VALUES (314,'BIN_TO_UUID');
INSERT INTO `help_keyword` VALUES (8,'BOOL');
INSERT INTO `help_keyword` VALUES (9,'BOOLEAN');
INSERT INTO `help_keyword` VALUES (85,'BOTH');
INSERT INTO `help_keyword` VALUES (425,'BTREE');
INSERT INTO `help_keyword` VALUES (262,'BY');
INSERT INTO `help_keyword` VALUES (33,'BYTE');
INSERT INTO `help_keyword` VALUES (720,'CACHE');
INSERT INTO `help_keyword` VALUES (470,'CALL');
INSERT INTO `help_keyword` VALUES (285,'CAN_ACCESS_COLUMN');
INSERT INTO `help_keyword` VALUES (286,'CAN_ACCESS_DATABASE');
INSERT INTO `help_keyword` VALUES (287,'CAN_ACCESS_TABLE');
INSERT INTO `help_keyword` VALUES (288,'CAN_ACCESS_VIEW');
INSERT INTO `help_keyword` VALUES (441,'CASCADE');
INSERT INTO `help_keyword` VALUES (53,'CASE');
INSERT INTO `help_keyword` VALUES (617,'CATALOG_NAME');
INSERT INTO `help_keyword` VALUES (62,'CEIL');
INSERT INTO `help_keyword` VALUES (63,'CEILING');
INSERT INTO `help_keyword` VALUES (528,'CHAIN');
INSERT INTO `help_keyword` VALUES (363,'CHANGE');
INSERT INTO `help_keyword` VALUES (343,'CHANNEL');
INSERT INTO `help_keyword` VALUES (34,'CHAR');
INSERT INTO `help_keyword` VALUES (30,'CHARACTER');
INSERT INTO `help_keyword` VALUES (696,'CHARSET');
INSERT INTO `help_keyword` VALUES (364,'CHECK');
INSERT INTO `help_keyword` VALUES (365,'CHECKSUM');
INSERT INTO `help_keyword` VALUES (639,'CIPHER');
INSERT INTO `help_keyword` VALUES (618,'CLASS_ORIGIN');
INSERT INTO `help_keyword` VALUES (664,'CLIENT');
INSERT INTO `help_keyword` VALUES (692,'CLONE');
INSERT INTO `help_keyword` VALUES (476,'CLOSE');
INSERT INTO `help_keyword` VALUES (366,'COALESCE');
INSERT INTO `help_keyword` VALUES (715,'CODE');
INSERT INTO `help_keyword` VALUES (321,'COLLATE');
INSERT INTO `help_keyword` VALUES (698,'COLLATION');
INSERT INTO `help_keyword` VALUES (367,'COLUMN');
INSERT INTO `help_keyword` VALUES (368,'COLUMNS');
INSERT INTO `help_keyword` VALUES (619,'COLUMN_NAME');
INSERT INTO `help_keyword` VALUES (328,'COMMENT');
INSERT INTO `help_keyword` VALUES (529,'COMMIT');
INSERT INTO `help_keyword` VALUES (541,'COMMITTED');
INSERT INTO `help_keyword` VALUES (442,'COMPACT');
INSERT INTO `help_keyword` VALUES (329,'COMPLETION');
INSERT INTO `help_keyword` VALUES (688,'COMPONENT');
INSERT INTO `help_keyword` VALUES (443,'COMPRESSED');
INSERT INTO `help_keyword` VALUES (369,'COMPRESSION');
INSERT INTO `help_keyword` VALUES (489,'CONCURRENT');
INSERT INTO `help_keyword` VALUES (614,'CONDITION');
INSERT INTO `help_keyword` VALUES (370,'CONNECTION');
INSERT INTO `help_keyword` VALUES (530,'CONSISTENT');
INSERT INTO `help_keyword` VALUES (371,'CONSTRAINT');
INSERT INTO `help_keyword` VALUES (620,'CONSTRAINT_CATALOG');
INSERT INTO `help_keyword` VALUES (621,'CONSTRAINT_NAME');
INSERT INTO `help_keyword` VALUES (622,'CONSTRAINT_SCHEMA');
INSERT INTO `help_keyword` VALUES (615,'CONTINUE');
INSERT INTO `help_keyword` VALUES (103,'CONVERT');
INSERT INTO `help_keyword` VALUES (260,'COUNT');
INSERT INTO `help_keyword` VALUES (42,'CREATE');
INSERT INTO `help_keyword` VALUES (258,'CREATE_DH_PARAMETERS');
INSERT INTO `help_keyword` VALUES (519,'CROSS');
INSERT INTO `help_keyword` VALUES (444,'CSV');
INSERT INTO `help_keyword` VALUES (270,'CUME_DIST');
INSERT INTO `help_keyword` VALUES (640,'CURRENT');
INSERT INTO `help_keyword` VALUES (116,'CURRENT_ROLE');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-14 15:04:38
