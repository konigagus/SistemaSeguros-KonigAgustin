-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: sistemaseguros
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `asegurados`
--

DROP TABLE IF EXISTS `asegurados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asegurados` (
  `id_asegurado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `direccion` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id_asegurado`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asegurados`
--

LOCK TABLES `asegurados` WRITE;
/*!40000 ALTER TABLE `asegurados` DISABLE KEYS */;
INSERT INTO `asegurados` VALUES (1,'Juan Perez','30111222','juan.perez@mail.com','Av Siempre Viva 123','111111111','1985-05-10'),(2,'Maria Gomez','28999888','maria.gomez@mail.com','Calle 25 456','222222222','1990-02-15'),(3,'Carlos Lopez','31555444','carlos.lopez@mail.com','San Martin 789','333333333','1988-08-20'),(4,'Laura Fernandez','29988777','laura.fernandez@mail.com','Belgrano 321','444444444','1992-07-11'),(5,'Pedro Martinez','27666555','pedro.martinez@mail.com','Rivadavia 654','555555555','1983-09-05'),(6,'Ana Rodriguez','32444555','ana.rodriguez@mail.com','Mitre 852','666666666','1995-03-17'),(7,'Diego Sanchez','30123456','diego.sanchez@mail.com','Lavalle 741','777777777','1987-11-23'),(8,'Sofia Ramirez','28900123','sofia.ramirez@mail.com','Urquiza 963','888888888','1993-04-12'),(9,'Lucas Torres','31222333','lucas.torres@mail.com','Moreno 147','999999999','1989-06-28'),(10,'Valentina Diaz','29888999','valentina.diaz@mail.com','Callao 258','101010101','1996-01-30');
/*!40000 ALTER TABLE `asegurados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodos_pago`
--

DROP TABLE IF EXISTS `metodos_pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pago` (
  `id_metodo_pago` int NOT NULL AUTO_INCREMENT,
  `nombre_metodo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_metodo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pago`
--

LOCK TABLES `metodos_pago` WRITE;
/*!40000 ALTER TABLE `metodos_pago` DISABLE KEYS */;
INSERT INTO `metodos_pago` VALUES (1,'Tarjeta de crédito'),(2,'Transferencia bancaria'),(3,'Efectivo');
/*!40000 ALTER TABLE `metodos_pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `fecha_pago` datetime DEFAULT CURRENT_TIMESTAMP,
  `monto` decimal(10,2) NOT NULL,
  `id_metodo_pago` int DEFAULT NULL,
  `id_poliza` int DEFAULT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `FK_Poliza_Pago` (`id_poliza`),
  KEY `FK_Metodo_Pago` (`id_metodo_pago`),
  CONSTRAINT `FK_Metodo_Pago` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodos_pago` (`id_metodo_pago`),
  CONSTRAINT `FK_Poliza_Pago` FOREIGN KEY (`id_poliza`) REFERENCES `polizas` (`id_poliza`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,'2026-03-14 18:56:33',10000.00,1,1),(2,'2026-03-14 18:56:33',12000.00,2,2),(3,'2026-03-14 18:56:33',15000.00,3,3),(4,'2026-03-14 18:56:33',9000.00,1,4),(5,'2026-03-14 18:56:33',11000.00,2,5),(6,'2026-03-14 18:56:33',13000.00,3,6),(7,'2026-03-14 18:56:33',10000.00,1,7),(8,'2026-03-14 18:56:33',12500.00,2,8),(9,'2026-03-14 18:56:33',14000.00,3,9),(10,'2026-03-14 18:56:33',16000.00,1,10);
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `polizas`
--

DROP TABLE IF EXISTS `polizas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `polizas` (
  `id_poliza` int NOT NULL AUTO_INCREMENT,
  `nro_poliza` varchar(50) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `monto_asegurado` decimal(15,2) DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Activa',
  `id_asegurado` int DEFAULT NULL,
  `id_tipo` int DEFAULT NULL,
  PRIMARY KEY (`id_poliza`),
  KEY `FK_Asegurado` (`id_asegurado`),
  KEY `FK_TipoSeguro` (`id_tipo`),
  CONSTRAINT `FK_Asegurado` FOREIGN KEY (`id_asegurado`) REFERENCES `asegurados` (`id_asegurado`) ON DELETE CASCADE,
  CONSTRAINT `FK_TipoSeguro` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_seguro` (`id_tipo`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `polizas`
--

LOCK TABLES `polizas` WRITE;
/*!40000 ALTER TABLE `polizas` DISABLE KEYS */;
INSERT INTO `polizas` VALUES (1,'POL001','2024-01-01','2025-01-01',100000.00,'Con siniestro',1,1),(2,'POL002','2024-01-10','2025-01-10',150000.00,'Con siniestro',2,2),(3,'POL003','2024-02-01','2025-02-01',200000.00,'Activa',3,3),(4,'POL004','2024-02-15','2025-02-15',120000.00,'Con siniestro',4,1),(5,'POL005','2024-03-01','2025-03-01',180000.00,'Con siniestro',5,2),(6,'POL006','2024-03-10','2025-03-10',130000.00,'Activa',6,3),(7,'POL007','2024-04-01','2025-04-01',170000.00,'Activa',7,1),(8,'POL008','2024-04-15','2025-04-15',220000.00,'Con siniestro',8,2),(9,'POL009','2024-05-01','2025-05-01',140000.00,'Activa',9,3),(10,'POL010','2024-05-10','2025-05-10',160000.00,'Activa',10,1);
/*!40000 ALTER TABLE `polizas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siniestros`
--

DROP TABLE IF EXISTS `siniestros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `siniestros` (
  `id_siniestro` int NOT NULL AUTO_INCREMENT,
  `fecha_siniestro` date NOT NULL,
  `monto_reclamado` decimal(15,2) DEFAULT NULL,
  `descripcion_incidente` text,
  `id_poliza` int DEFAULT NULL,
  PRIMARY KEY (`id_siniestro`),
  KEY `FK_Poliza_Siniestro` (`id_poliza`),
  CONSTRAINT `FK_Poliza_Siniestro` FOREIGN KEY (`id_poliza`) REFERENCES `polizas` (`id_poliza`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siniestros`
--

LOCK TABLES `siniestros` WRITE;
/*!40000 ALTER TABLE `siniestros` DISABLE KEYS */;
INSERT INTO `siniestros` VALUES (1,'2024-06-10',50000.00,'Choque leve',1),(2,'2024-06-18',30000.00,'Daño por agua',5),(3,'2024-07-02',70000.00,'Accidente vehicular',4),(4,'2024-07-10',20000.00,'Robo en vivienda',8),(5,'2024-07-20',45000.00,'Incendio parcial',2);
/*!40000 ALTER TABLE `siniestros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_seguro`
--

DROP TABLE IF EXISTS `tipos_seguro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_seguro` (
  `id_tipo` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_seguro`
--

LOCK TABLES `tipos_seguro` WRITE;
/*!40000 ALTER TABLE `tipos_seguro` DISABLE KEYS */;
INSERT INTO `tipos_seguro` VALUES (1,'Automotor','Seguro para vehículos'),(2,'Hogar','Seguro para viviendas'),(3,'Vida','Seguro de vida');
/*!40000 ALTER TABLE `tipos_seguro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vista_pagos_poliza`
--

DROP TABLE IF EXISTS `vista_pagos_poliza`;
/*!50001 DROP VIEW IF EXISTS `vista_pagos_poliza`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_pagos_poliza` AS SELECT 
 1 AS `id_pago`,
 1 AS `fecha_pago`,
 1 AS `monto`,
 1 AS `nro_poliza`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_polizas_asegurados`
--

DROP TABLE IF EXISTS `vista_polizas_asegurados`;
/*!50001 DROP VIEW IF EXISTS `vista_polizas_asegurados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_polizas_asegurados` AS SELECT 
 1 AS `id_poliza`,
 1 AS `nro_poliza`,
 1 AS `nombre`,
 1 AS `dni`,
 1 AS `monto_asegurado`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_siniestros_poliza`
--

DROP TABLE IF EXISTS `vista_siniestros_poliza`;
/*!50001 DROP VIEW IF EXISTS `vista_siniestros_poliza`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_siniestros_poliza` AS SELECT 
 1 AS `id_siniestro`,
 1 AS `fecha_siniestro`,
 1 AS `monto_reclamado`,
 1 AS `nro_poliza`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_pagos_poliza`
--

/*!50001 DROP VIEW IF EXISTS `vista_pagos_poliza`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_pagos_poliza` AS select `pa`.`id_pago` AS `id_pago`,`pa`.`fecha_pago` AS `fecha_pago`,`pa`.`monto` AS `monto`,`p`.`nro_poliza` AS `nro_poliza` from (`pagos` `pa` join `polizas` `p` on((`pa`.`id_poliza` = `p`.`id_poliza`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_polizas_asegurados`
--

/*!50001 DROP VIEW IF EXISTS `vista_polizas_asegurados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_polizas_asegurados` AS select `p`.`id_poliza` AS `id_poliza`,`p`.`nro_poliza` AS `nro_poliza`,`a`.`nombre` AS `nombre`,`a`.`dni` AS `dni`,`p`.`monto_asegurado` AS `monto_asegurado`,`p`.`estado` AS `estado` from (`polizas` `p` join `asegurados` `a` on((`p`.`id_asegurado` = `a`.`id_asegurado`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_siniestros_poliza`
--

/*!50001 DROP VIEW IF EXISTS `vista_siniestros_poliza`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_siniestros_poliza` AS select `s`.`id_siniestro` AS `id_siniestro`,`s`.`fecha_siniestro` AS `fecha_siniestro`,`s`.`monto_reclamado` AS `monto_reclamado`,`p`.`nro_poliza` AS `nro_poliza` from (`siniestros` `s` join `polizas` `p` on((`s`.`id_poliza` = `p`.`id_poliza`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-12 21:25:28
