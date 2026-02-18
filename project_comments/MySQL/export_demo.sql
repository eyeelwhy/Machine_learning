-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: demo_shoes
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id_category` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Женская обувь'),(2,'Мужская обувь');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id_manufacturer` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_manufacturer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'Kari'),(2,'Marco Tozzi'),(3,'Рос'),(4,'Rieker'),(5,'Alessio Nesca'),(6,'CROSBY');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_compositions`
--

DROP TABLE IF EXISTS `order_compositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_compositions` (
  `id_order_composition` int NOT NULL,
  `id_order` int NOT NULL,
  `atricul` varchar(10) NOT NULL,
  `nums` int NOT NULL,
  PRIMARY KEY (`id_order_composition`),
  KEY `fk_order_to_order_cm_idx` (`id_order`),
  KEY `fk_articul_to_order_cm_idx` (`atricul`),
  CONSTRAINT `fk_articul_to_order_cm` FOREIGN KEY (`atricul`) REFERENCES `tovars` (`articul`),
  CONSTRAINT `fk_order_to_order_cm` FOREIGN KEY (`id_order`) REFERENCES `orders` (`id_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_compositions`
--

LOCK TABLES `order_compositions` WRITE;
/*!40000 ALTER TABLE `order_compositions` DISABLE KEYS */;
INSERT INTO `order_compositions` VALUES (1,1,'А112Т4',2),(2,1,'F635R4',2),(3,2,'H782T5',1),(4,2,'G783F5',1),(5,3,'J384T6',10),(6,3,'D572U8',10),(7,4,'F572H7',5),(8,4,'D329H3',4),(9,5,'А112Т4',2),(10,5,'F635R4',2),(11,6,'H782T5',1),(12,6,'G783F5',1),(13,7,'J384T6',10),(14,7,'D329H3',4),(15,8,'F572H7',5),(16,8,'D329H3',4),(17,9,'F572H7',5),(18,9,'G432E4',1),(19,10,'S213E3',5),(20,10,'E482R4',5);
/*!40000 ALTER TABLE `order_compositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_statuses`
--

DROP TABLE IF EXISTS `order_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_statuses` (
  `id_order_status` int NOT NULL,
  `name` varchar(55) NOT NULL,
  PRIMARY KEY (`id_order_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_statuses`
--

LOCK TABLES `order_statuses` WRITE;
/*!40000 ALTER TABLE `order_statuses` DISABLE KEYS */;
INSERT INTO `order_statuses` VALUES (1,'Завершен'),(2,'Новый');
/*!40000 ALTER TABLE `order_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id_order` int NOT NULL,
  `date_create` date NOT NULL,
  `date_delivery` date NOT NULL,
  `id_address` int NOT NULL,
  `id_user` int NOT NULL,
  `code_have` int NOT NULL,
  `id_status` int NOT NULL,
  PRIMARY KEY (`id_order`),
  KEY `fk_order_statuses_to_order_idx` (`id_status`),
  KEY `fk_addres_to_order_idx` (`id_address`),
  KEY `fk_user_to_order_idx` (`id_user`),
  CONSTRAINT `fk_addres_to_order` FOREIGN KEY (`id_address`) REFERENCES `pickup_point_addresses` (`id_pickup_point_address`),
  CONSTRAINT `fk_order_statuses_to_order` FOREIGN KEY (`id_status`) REFERENCES `order_statuses` (`id_order_status`),
  CONSTRAINT `fk_user_to_order` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-02-27','2025-04-20',3,4,901,1),(2,'2022-09-28','2025-04-21',11,1,902,1),(3,'2025-03-21','2025-04-22',2,2,903,1),(4,'2025-02-20','2025-04-23',11,3,904,1),(5,'2025-03-17','2025-04-24',2,4,905,1),(6,'2025-03-01','2025-04-25',15,1,906,1),(7,'2025-02-28','2025-04-26',3,2,907,1),(8,'2025-03-31','2025-04-27',19,3,908,2),(9,'2025-04-02','2025-04-28',5,4,909,2),(10,'2025-04-03','2025-04-29',19,4,910,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pickup_point_addresses`
--

DROP TABLE IF EXISTS `pickup_point_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pickup_point_addresses` (
  `id_pickup_point_address` int NOT NULL,
  `index` varchar(6) NOT NULL,
  `city` varchar(85) NOT NULL,
  `street` varchar(85) NOT NULL,
  `num_house` int NOT NULL,
  PRIMARY KEY (`id_pickup_point_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pickup_point_addresses`
--

LOCK TABLES `pickup_point_addresses` WRITE;
/*!40000 ALTER TABLE `pickup_point_addresses` DISABLE KEYS */;
INSERT INTO `pickup_point_addresses` VALUES (1,'420151','г. Лесной','ул. Вишневая',32),(2,'125061','г. Лесной','ул. Подгорная',8),(3,'630370','г. Лесной','ул. Шоссейная',24),(4,'400562','г. Лесной','ул. Зеленая',32),(5,'614510','г. Лесной','ул. Маяковского',47),(6,'410542','г. Лесной','ул. Светлая',46),(7,'620839','г. Лесной','ул. Цветочная',8),(8,'443890','г. Лесной','ул. Коммунистическая',1),(9,'603379','г. Лесной','ул. Спортивная',46),(10,'603721','г. Лесной','ул. Гоголя',41),(11,'410172','г. Лесной','ул. Северная',13),(12,'614611','г. Лесной','ул. Молодежная',50),(13,'454311','г.Лесной','ул. Новая',19),(14,'660007','г.Лесной','ул. Октябрьская',19),(15,'603036','г. Лесной','ул. Садовая',4),(16,'394060','г.Лесной','ул. Фрунзе',43),(17,'410661','г. Лесной','ул. Школьная',50),(18,'625590','г. Лесной','ул. Коммунистическая',20),(19,'625683','г. Лесной','ул. 8 Марта',1),(20,'450983','г.Лесной','ул. Комсомольская',26),(21,'394782','г. Лесной','ул. Чехова',3),(22,'603002','г. Лесной','ул. Дзержинского',28),(23,'450558','г. Лесной','ул. Набережная',30),(24,'344288','г. Лесной','ул. Чехова',1),(25,'614164','г.Лесной','ул. Степная',30),(26,'394242','г. Лесной','ул. Коммунистическая',43),(27,'660540','г. Лесной','ул. Солнечная',25),(28,'125837','г. Лесной','ул. Шоссейная',40),(29,'125703','г. Лесной','ул. Партизанская',49),(30,'625283','г. Лесной','ул. Победы',46),(31,'614753','г. Лесной','ул. Полевая',35),(32,'426030','г. Лесной','ул. Маяковского',44),(33,'450375','г. Лесной','ул. Клубная',44),(34,'625560','г. Лесной','ул. Некрасова',12),(35,'630201','г. Лесной','ул. Комсомольская',17),(36,'190949','г. Лесной','ул. Мичурина',26);
/*!40000 ALTER TABLE `pickup_point_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id_supplier` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (1,'Kari'),(2,'Обувь для вас');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tovars`
--

DROP TABLE IF EXISTS `tovars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tovars` (
  `articul` varchar(10) NOT NULL,
  `name` varchar(65) NOT NULL,
  `coast` int NOT NULL,
  `sale_num` int NOT NULL,
  `name_amount` varchar(10) NOT NULL,
  `num_have` int NOT NULL,
  `describe` varchar(125) NOT NULL,
  `photo_path` varchar(105) DEFAULT NULL,
  `id_supplier` int NOT NULL,
  `id_manafacture` int NOT NULL,
  `id_category` int NOT NULL,
  PRIMARY KEY (`articul`),
  KEY `fk_supplier_to_tovar_idx` (`id_supplier`),
  KEY `fk_manafacture_to_tovar_idx` (`id_manafacture`),
  KEY `fk_category_to_tovar_idx` (`id_category`),
  CONSTRAINT `fk_category_to_tovar` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`),
  CONSTRAINT `fk_manafacture_to_tovar` FOREIGN KEY (`id_manafacture`) REFERENCES `manufacturers` (`id_manufacturer`),
  CONSTRAINT `fk_supplier_to_tovar` FOREIGN KEY (`id_supplier`) REFERENCES `suppliers` (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tovars`
--

LOCK TABLES `tovars` WRITE;
/*!40000 ALTER TABLE `tovars` DISABLE KEYS */;
INSERT INTO `tovars` VALUES ('B320R5','Туфли',4444,2,'шт',6,'Туфли Rieker женские демисезонные, размер 41, цвет коричневый','9.jpg',1,4,1),('B431R5','Ботинки',2700,2,'шт',5,'Мужские кожаные ботинки/мужские ботинки',NULL,2,4,2),('C436G5','Ботинки',10200,15,'шт',9,'Ботинки женские, ARGO, размер 40',NULL,1,5,1),('D268G5','Туфли',4399,3,'шт',12,'Туфли Rieker женские демисезонные, размер 36, цвет коричневый',NULL,2,4,1),('D329H3','Полуботинки',1890,4,'шт',4,'Полуботинки Alessio Nesca женские 3-30797-47, размер 37, цвет: бордовый','8.jpg',2,5,1),('D364R4','Туфли',12400,16,'шт',5,'Туфли Luiza Belly женские Kate-lazo черные из натуральной замши',NULL,1,1,1),('D572U8','Кроссовки',4100,3,'шт',6,'129615-4 Кроссовки мужские','6.jpg',2,3,2),('E482R4','Полуботинки',1800,2,'шт',14,'Полуботинки kari женские MYZ20S-149, размер 41, цвет: черный',NULL,1,1,1),('F427R5','Ботинки',11800,15,'шт',11,'Ботинки на молнии с декоративной пряжкой FRAU',NULL,2,4,1),('F572H7','Туфли',2700,2,'шт',14,'Туфли Marco Tozzi женские летние, размер 39, цвет черный','7.jpg',1,2,1),('F635R4','Ботинки',3244,2,'шт',13,'Ботинки Marco Tozzi женские демисезонные, размер 39, цвет бежевый','2.jpg',2,2,1),('G432E4','Туфли',2800,3,'шт',15,'Туфли kari женские TR-YR-413017, размер 37, цвет: черный','10.jpg',1,1,1),('G531F4','Ботинки',6600,12,'шт',9,'Ботинки женские зимние ROMER арт. 893167-01 Черный',NULL,1,1,1),('G783F5','Ботинки',5900,2,'шт',8,'Мужские ботинки Рос-Обувь кожаные с натуральным мехом','4.jpg',1,3,2),('H535R5','Ботинки',2300,2,'шт',7,'Женские Ботинки демисезонные',NULL,2,4,1),('H782T5','Туфли',4499,4,'шт',5,'Туфли kari мужские классика MYZ21AW-450A, размер 43, цвет: черный','3.jpg',1,1,2),('J384T6','Ботинки',3800,2,'шт',16,'B3430/14 Полуботинки мужские Rieker','5.jpg',2,4,2),('J542F5','Тапочки',500,13,'шт',0,'Тапочки мужские Арт.70701-55-67син р.41',NULL,1,1,2),('K345R4','Полуботинки',2100,2,'шт',3,'407700/01-02 Полуботинки мужские CROSBY',NULL,2,6,2),('K358H6','Тапочки',599,20,'шт',2,'Тапочки мужские син р.41',NULL,1,4,2),('L754R4','Полуботинки',1700,2,'шт',7,'Полуботинки kari женские WB2020SS-26, размер 38, цвет: черный',NULL,1,1,1),('M542T5','Кроссовки',2800,18,'шт',3,'Кроссовки мужские TOFA',NULL,2,4,2),('N457T5','Полуботинки',4600,3,'шт',13,'Полуботинки Ботинки черные зимние, мех',NULL,1,6,1),('O754F4','Туфли',5400,4,'шт',18,'Туфли женские демисезонные Rieker артикул 55073-68/37',NULL,2,4,1),('P764G4','Туфли',6800,15,'шт',15,'Туфли женские, ARGO, размер 38',NULL,1,6,1),('S213E3','Полуботинки',2156,3,'шт',6,'407700/01-01 Полуботинки мужские CROSBY',NULL,2,6,2),('S326R5','Тапочки',9900,17,'шт',15,'Мужские кожаные тапочки \"Профиль С.Дали\" ',NULL,2,6,2),('S634B5','Кеды',5500,3,'шт',0,'Кеды Caprice мужские демисезонные, размер 42, цвет черный',NULL,2,6,2),('T324F5','Сапоги',4699,2,'шт',5,'Сапоги замша Цвет: синий',NULL,1,6,1),('А112Т4','Ботинки',4990,3,'шт',6,'Женские Ботинки демисезонные kari','1.jpg',1,1,1);
/*!40000 ALTER TABLE `tovars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `id_role` int NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,'Администратор'),(2,'Менеджер'),(3,'Авторизированный клиент');
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `id_role` int NOT NULL,
  `surname` varchar(85) NOT NULL,
  `name` varchar(85) NOT NULL,
  `patronomic` varchar(85) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `fk_role_to_user_idx` (`id_role`),
  CONSTRAINT `fk_role_to_user` FOREIGN KEY (`id_role`) REFERENCES `user_roles` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Никифорова','Весения','Николаевна','94d5ous@gmail.com','uzWC67'),(2,1,'Сазонов','Руслан','Германович','uth4iz@mail.com','2L6KZG'),(3,1,'Одинцов','Серафим','Артёмович','yzls62@outlook.com','JlFRCZ'),(4,2,'Степанов','Михаил','Артёмович','1diph5e@tutanota.com','8ntwUp'),(5,2,'Ворсин','Петр','Евгеньевич','tjde7c@yahoo.com','YOyhfR'),(6,2,'Старикова','Елена','Павловна','wpmrc3do@tutanota.com','RSbvHv'),(7,3,'Михайлюк','Анна','Вячеславовна','5d4zbu@tutanota.com','rwVDh9'),(8,3,'Ситдикова','Елена','Анатольевна','ptec8ym@yahoo.com','LdNyos'),(9,3,'Ворсин','Петр','Евгеньевич','1qz4kw@mail.com','gynQMT'),(10,3,'Старикова','Елена','Павловна','4np6se@mail.com','AtnDjr');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-18 19:51:06
