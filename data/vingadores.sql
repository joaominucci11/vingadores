CREATE DATABASE  IF NOT EXISTS `vingadores` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `vingadores`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: vingadores
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `chip gps`
--

DROP TABLE IF EXISTS `chip gps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chip gps` (
  `id_chip_gps` int NOT NULL AUTO_INCREMENT,
  `localizacao_atual` varchar(100) DEFAULT NULL,
  `ultima_localizacao` varchar(100) DEFAULT NULL,
  `tornozeleira_id` int NOT NULL,
  `heroi_id` int NOT NULL,
  PRIMARY KEY (`id_chip_gps`),
  KEY `fk_tornozeleira_id_idx` (`tornozeleira_id`),
  KEY `fk_heroi__id_idx` (`heroi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chip gps`
--

LOCK TABLES `chip gps` WRITE;
/*!40000 ALTER TABLE `chip gps` DISABLE KEYS */;
/*!40000 ALTER TABLE `chip gps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convocacao`
--

DROP TABLE IF EXISTS `convocacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `convocacao` (
  `id_convocacao` int NOT NULL AUTO_INCREMENT,
  `motivo` text NOT NULL,
  `data_convocacao` datetime NOT NULL,
  `data_comparecimento` datetime DEFAULT NULL,
  `status` enum('Pendente','Comparecido','Ausente') NOT NULL,
  `heroi_id` int NOT NULL,
  PRIMARY KEY (`id_convocacao`),
  KEY `fk_heroi_id_idx` (`heroi_id`),
  CONSTRAINT `fk_heroi_id` FOREIGN KEY (`heroi_id`) REFERENCES `heroi` (`id_heroi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convocacao`
--

LOCK TABLES `convocacao` WRITE;
/*!40000 ALTER TABLE `convocacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `convocacao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `convocacao_AFTER_UPDATE` AFTER UPDATE ON `convocacao` FOR EACH ROW BEGIN

    IF OLD.status != NEW.status THEN
       
        INSERT INTO historico_heroi (heroi_id, data_registro)
        VALUES (NEW.heroi_id, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `fraqueza`
--

DROP TABLE IF EXISTS `fraqueza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fraqueza` (
  `id_fraqueza` int NOT NULL AUTO_INCREMENT,
  `nome_fraqueza` varchar(100) NOT NULL,
  PRIMARY KEY (`id_fraqueza`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fraqueza`
--

LOCK TABLES `fraqueza` WRITE;
/*!40000 ALTER TABLE `fraqueza` DISABLE KEYS */;
/*!40000 ALTER TABLE `fraqueza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `habilidade`
--

DROP TABLE IF EXISTS `habilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `habilidade` (
  `id_habilidade` int NOT NULL AUTO_INCREMENT,
  `nome_habilidade` varchar(100) NOT NULL,
  PRIMARY KEY (`id_habilidade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `habilidade`
--

LOCK TABLES `habilidade` WRITE;
/*!40000 ALTER TABLE `habilidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `habilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heroi`
--

DROP TABLE IF EXISTS `heroi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heroi` (
  `id_heroi` int NOT NULL AUTO_INCREMENT,
  `nome_heroi` varchar(45) DEFAULT NULL,
  `nome_real` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  `poderes` varchar(45) DEFAULT NULL,
  `poder_principal` varchar(45) DEFAULT NULL,
  `fraquezas` varchar(45) DEFAULT NULL,
  `nivel_forca` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_heroi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heroi`
--

LOCK TABLES `heroi` WRITE;
/*!40000 ALTER TABLE `heroi` DISABLE KEYS */;
INSERT INTO `heroi` VALUES (1,'Homem de Ferro','Tony Stark','Humano','Soltar raio,  voar','Soltar raio','Impostos','100'),(2,'Homem Aranha','Peter Parker','Meta-humano','Soltar teia,  aderência','Soltar teia','Amor','7000');
/*!40000 ALTER TABLE `heroi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heroi_fraqueza`
--

DROP TABLE IF EXISTS `heroi_fraqueza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heroi_fraqueza` (
  `id_heroi_fraqueza` int NOT NULL AUTO_INCREMENT,
  `id_heroi` int NOT NULL,
  `id_fraqueza` int NOT NULL,
  PRIMARY KEY (`id_heroi_fraqueza`),
  KEY `fk_id_heroi_idx` (`id_heroi`),
  CONSTRAINT `fk_id_fraqueza` FOREIGN KEY (`id_heroi_fraqueza`) REFERENCES `fraqueza` (`id_fraqueza`),
  CONSTRAINT `fkid_heroi` FOREIGN KEY (`id_heroi`) REFERENCES `heroi` (`id_heroi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heroi_fraqueza`
--

LOCK TABLES `heroi_fraqueza` WRITE;
/*!40000 ALTER TABLE `heroi_fraqueza` DISABLE KEYS */;
/*!40000 ALTER TABLE `heroi_fraqueza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heroi_habilidade`
--

DROP TABLE IF EXISTS `heroi_habilidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heroi_habilidade` (
  `id_heroi_habilidade` int NOT NULL AUTO_INCREMENT,
  `id_heroi` int NOT NULL,
  `id_habilidade` int NOT NULL,
  PRIMARY KEY (`id_heroi_habilidade`),
  KEY `fk_id_heroi_idx` (`id_heroi`),
  CONSTRAINT `fk_id_habilidade` FOREIGN KEY (`id_heroi_habilidade`) REFERENCES `habilidade` (`id_habilidade`),
  CONSTRAINT `fk_id_heroi` FOREIGN KEY (`id_heroi`) REFERENCES `heroi` (`id_heroi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heroi_habilidade`
--

LOCK TABLES `heroi_habilidade` WRITE;
/*!40000 ALTER TABLE `heroi_habilidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `heroi_habilidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_heroi`
--

DROP TABLE IF EXISTS `historico_heroi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_heroi` (
  `id_historico_heroi` int NOT NULL AUTO_INCREMENT,
  `id_heroi` int NOT NULL,
  `id_tornozeleira` int NOT NULL,
  `id_convocacao` int NOT NULL,
  `id_chip_gps` int NOT NULL,
  `id_mandado_prisao` int NOT NULL,
  PRIMARY KEY (`id_historico_heroi`),
  KEY `fk_heroi__id_idx` (`id_heroi`),
  KEY `fk_id_convocacao_idx` (`id_convocacao`),
  KEY `fk_id_tornozeleira_idx` (`id_tornozeleira`),
  KEY `fk_chip_gps_idx` (`id_chip_gps`),
  KEY `fk_id_mandado_prisao_idx` (`id_mandado_prisao`),
  CONSTRAINT `fk__heroi__id` FOREIGN KEY (`id_heroi`) REFERENCES `heroi` (`id_heroi`),
  CONSTRAINT `fk_id_chip_gps` FOREIGN KEY (`id_chip_gps`) REFERENCES `chip gps` (`id_chip_gps`),
  CONSTRAINT `fk_id_convocacao` FOREIGN KEY (`id_convocacao`) REFERENCES `convocacao` (`id_convocacao`),
  CONSTRAINT `fk_id_mandado_prisao` FOREIGN KEY (`id_mandado_prisao`) REFERENCES `mandado_prisao` (`id_mandado_de_prisao`),
  CONSTRAINT `fk_id_tornozeleira` FOREIGN KEY (`id_tornozeleira`) REFERENCES `tornozeleira` (`id_tornozeleira`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_heroi`
--

LOCK TABLES `historico_heroi` WRITE;
/*!40000 ALTER TABLE `historico_heroi` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_heroi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mandado_prisao`
--

DROP TABLE IF EXISTS `mandado_prisao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mandado_prisao` (
  `id_mandado_de_prisao` int NOT NULL AUTO_INCREMENT,
  `motivo` text NOT NULL,
  `data_emissao` datetime NOT NULL,
  `status` enum('Pendente','Cumprido','Cancelado') NOT NULL,
  `heroi_id` int NOT NULL,
  PRIMARY KEY (`id_mandado_de_prisao`),
  KEY `fk_heroi__id_idx` (`heroi_id`),
  CONSTRAINT `fk_heroi__id` FOREIGN KEY (`heroi_id`) REFERENCES `heroi` (`id_heroi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mandado_prisao`
--

LOCK TABLES `mandado_prisao` WRITE;
/*!40000 ALTER TABLE `mandado_prisao` DISABLE KEYS */;
/*!40000 ALTER TABLE `mandado_prisao` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `mandado_prisao_AFTER_UPDATE` AFTER UPDATE ON `mandado_prisao` FOR EACH ROW BEGIN
IF OLD.status != NEW.status THEN
        -- Insere um registro na tabela historico_heroi
        INSERT INTO historico_heroi (heroi_id, data_registro)
        VALUES (NEW.heroi_id, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tornozeleira`
--

DROP TABLE IF EXISTS `tornozeleira`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tornozeleira` (
  `id_tornozeleira` int NOT NULL AUTO_INCREMENT,
  `status` enum('Ativo','Inativo') NOT NULL,
  `data_ativacao` datetime DEFAULT NULL,
  `data_desativacao` datetime DEFAULT NULL,
  `heroi_id` int NOT NULL,
  PRIMARY KEY (`id_tornozeleira`),
  KEY `idheroi_idx` (`heroi_id`),
  CONSTRAINT `idheroi` FOREIGN KEY (`heroi_id`) REFERENCES `heroi` (`id_heroi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tornozeleira`
--

LOCK TABLES `tornozeleira` WRITE;
/*!40000 ALTER TABLE `tornozeleira` DISABLE KEYS */;
/*!40000 ALTER TABLE `tornozeleira` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tornozeleira_AFTER_UPDATE` AFTER UPDATE ON `tornozeleira` FOR EACH ROW BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO historico_heroi (heroi_id, data_registro)
        VALUES (NEW.heroi_id, NOW());
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'vingadores'
--

--
-- Dumping routines for database 'vingadores'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06 13:48:17
