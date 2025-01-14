CREATE DATABASE  IF NOT EXISTS `ProgettoWeb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ProgettoWeb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ProgettoWeb
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
-- Table structure for table `carrello`
--

DROP TABLE IF EXISTS `carrello`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrello` (
  `cart_id` bigint NOT NULL AUTO_INCREMENT,
  `Id_utente` bigint NOT NULL,
  `Id_prod` bigint NOT NULL,
  `Quantità` bigint DEFAULT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_id`),
  KEY `prod_id_idx` (`Id_prod`),
  KEY `user_id_idx` (`Id_utente`),
  CONSTRAINT `prod_id` FOREIGN KEY (`Id_prod`) REFERENCES `prodotto` (`Id_prod`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_id` FOREIGN KEY (`Id_utente`) REFERENCES `utente` (`Id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrello`
--

LOCK TABLES `carrello` WRITE;
/*!40000 ALTER TABLE `carrello` DISABLE KEYS */;
INSERT INTO `carrello` VALUES (55,1,2,0,1),(56,1,5,0,1),(57,1,24,0,1),(58,6,4,0,1),(59,6,14,0,1),(60,6,18,0,1),(61,6,5,0,1),(62,6,4,0,1),(63,6,2,0,1),(64,6,3,0,1),(65,6,5,0,1),(66,6,2,0,1),(67,6,3,0,1),(68,6,4,0,1),(69,1,43,0,1),(70,1,24,0,1),(71,1,27,0,1),(72,1,28,0,1),(73,1,26,0,1),(74,1,6,0,1),(75,1,7,0,1),(76,1,8,0,1),(77,1,9,0,1),(78,1,10,0,1),(79,1,11,0,1),(80,1,12,0,1),(81,1,1,0,1),(82,10,17,0,1),(83,10,15,0,1),(84,10,30,0,1),(85,1,3,0,1),(86,1,33,0,1),(87,1,31,0,1),(88,1,25,0,1),(89,1,29,0,1),(90,6,13,0,1),(91,6,35,0,1),(92,1,3,0,1),(93,1,3,0,1),(94,3,3,0,1),(95,11,20,0,1),(96,11,36,0,1),(97,11,34,0,1),(98,3,24,1,0),(99,7,1,0,1),(100,12,24,0,1),(101,12,5,0,1),(102,12,25,1,0),(103,1,1,2,0);
/*!40000 ALTER TABLE `carrello` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `Id_utente` bigint NOT NULL,
  `Id_prod` bigint NOT NULL,
  `Quantità` bigint NOT NULL,
  `Stato` varchar(45) NOT NULL,
  `Timestamp` timestamp NOT NULL,
  `Totale` decimal(10,0) NOT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order_id`),
  KEY `user_id_idx` (`Id_utente`),
  KEY `product_id_idx` (`Id_prod`),
  CONSTRAINT `product_id` FOREIGN KEY (`Id_prod`) REFERENCES `prodotto` (`Id_prod`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utente_id` FOREIGN KEY (`Id_utente`) REFERENCES `utente` (`Id_utente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (19,1,24,1,'Ordine completato','2024-09-06 08:30:47',77,0),(20,1,26,1,'Ordine completato','2024-09-06 12:27:27',66,0),(21,1,6,1,'Ordine completato','2024-09-06 12:52:46',90,0),(22,1,7,1,'Ordine completato','2024-09-06 12:52:46',90,0),(23,1,8,1,'Ordine completato','2024-09-06 12:52:46',90,0),(24,1,9,1,'Ordine completato','2024-09-06 12:52:46',90,0),(25,1,10,1,'Ordine completato','2024-09-06 12:52:46',90,0),(26,1,11,1,'Ordine completato','2024-09-06 12:52:46',90,0),(27,1,12,1,'Ordine completato','2024-09-06 12:52:46',90,0),(28,10,17,2,'Processamento ordine','2024-09-10 08:17:49',209,0),(29,10,15,1,'Processamento ordine','2024-09-10 08:17:49',209,0),(30,10,30,1,'Processamento ordine','2024-09-10 08:17:49',209,0),(31,1,33,1,'Ordine completato','2024-09-24 15:02:05',55,0),(32,1,31,1,'Ordine completato','2024-09-24 15:02:05',55,0),(33,1,25,1,'Ordine completato','2024-09-25 09:10:48',77,0),(34,1,29,1,'Ordine completato','2024-09-25 09:13:07',55,0),(35,6,13,1,'Ordine completato','2024-09-27 07:05:23',66,0),(36,6,35,1,'Ordine completato','2024-09-27 07:05:23',66,0),(37,1,3,2,'Ordine completato','2024-09-27 07:22:19',0,0),(38,1,3,2,'Ordine completato','2024-09-27 09:09:32',0,0),(39,3,3,2,'Ordine completato','2024-09-27 09:16:19',0,0),(40,11,20,1,'Ordine completato','2024-09-27 13:42:24',130,0),(41,11,34,1,'Ordine completato','2024-09-27 13:42:24',130,0),(42,12,24,2,'Ordine completato','2024-09-28 09:36:37',190,0),(43,12,5,1,'Ordine completato','2024-09-28 09:36:37',190,0);
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `Id_prod` bigint NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) NOT NULL,
  `Descrizione` text NOT NULL,
  `Prezzo` decimal(10,2) NOT NULL,
  `Quantità` int NOT NULL,
  `Categoria` varchar(45) NOT NULL,
  `Deleted` tinyint(1) NOT NULL DEFAULT '0',
  `Blocked` tinyint(1) NOT NULL DEFAULT '0',
  `img_path` varchar(255) NOT NULL DEFAULT 'NotAvailable',
  PRIMARY KEY (`Id_prod`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'Omori','Esplora le emozioni di Omori tra il mondo dei sogni e il mondo reale',5.99,1,'Indie',0,0,'https://preview.redd.it/what-really-got-you-into-omori-for-me-it-was-literally-the-v0-rly0j1rz4nca1.jpg?width=640&crop=smart&auto=webp&s=2452e97565988fbf183a3747c279e6d7ffd304c6'),(2,'Dark souls remastered','Il primo vero capolavoro di FromSoftware, che ha ispirato un intero genere. Entra a Lothric e vivi la tua storia nel tentativo di diventare il nuovo Lord dei tizzoni',15.99,30,'Souls',0,0,'https://www.gamerclick.it/prove/img_tmp/201805/Dark-Souls-Remastered-cover.jpg'),(3,'Dark souls II scholar of the first sin','Il capitolo ',9.99,25,'Schifo',0,0,'https://www.codiciprodotto.it/wp-content/uploads/2024/01/DS2-SPTFS-PC-COVER.jpg'),(4,'Dark souls III','L\'ultima parte dei souls, un gioco splendido e che ti porterà a rivivere le emozioni del primo capitolo',29.99,100,'Souls',0,0,'https://image.api.playstation.com/cdn/EP0700/CUSA03365_00/OFMeAw2KhrdaEZAjW1f3tCIXbogkLpTC.png'),(5,'Sekiro','Vesti i panni di uno shinobi che per proteggere il suo padrone è disposto a tutto, anche sacrificare se stesso',49.99,199,'Action RPG',0,0,'https://image.api.playstation.com/vulcan/img/rnd/202010/1700/B66T6RbAfvIGjpEQxPq7k0Mu.png'),(6,'Metal gear','Il gioco che ha creato un genere, il primo successo di Hideo Kojima, immortale opera di immenso game design',5.99,49,'Tactical espionage',0,0,'https://fiu-original.b-cdn.net/fontsinuse.com/use-images/N190/190662/190662.jpeg?filename=5285935'),(7,'Metal gear 2','Il seguito del primo capitolo, Snake torna ancora a fronteggiare il suo nemico numero 1, Big Boss',5.99,49,'Tactical espionage',0,0,'https://preview.redd.it/who-drew-painted-the-cover-for-metal-gear-2-v0-vdeakis2aeeb1.png?width=1600&format=png&auto=webp&s=b673a2396ea39fb799be2391622401626a52ed46'),(8,'Metal gear solid','L\'inizio della storia che passa su playstation, l\'inizio di Solid Snake',9.99,58,'Tactical espionage',0,0,'https://assets-prd.ignimgs.com/2022/08/15/metal-gear-solid-1660604991900.jpg'),(9,'Metal gear solid 2','Il seguito della storia di Solid Snake',9.99,49,'Tactical espionage',0,0,'https://assets-prd.ignimgs.com/2021/12/21/mgs2-1640128915245.jpg?width=300&crop=1%3A1%2Csmart&auto=webp'),(10,'Metal gear solid 3','Capitolo prequel che segue le orme del giovane Big Boss',9.99,49,'Tactical espionage',0,0,'https://e.snmc.io/lk/l/x/85b7eaf75b585ec190f2dafd0d914e8a/6690386'),(11,'Metal gear solid 4','Continuo della storia di Snake invecchiato molto rispetto a dove lo avevamo lasciato',19.99,49,'Tactical espionage',0,0,'https://assets-prd.ignimgs.com/2021/12/14/mgs4-1639513684395.jpg'),(12,'Metal gear solid 5','L\'ultima parte della storia dei Metal Gear, coincisa con l\'addio di Kojima da konami',19.99,49,'Tactical espionage',0,0,'https://upload.wikimedia.org/wikipedia/en/8/8f/Metal_Gear_Solid_V_The_Phantom_Pain_cover.png'),(13,'Dragon age Inquisition','Segui la rinascita dell\'antica inquisizione nei panni di un forestiero che viene trascinato in una guerra secolare suo malgrado',39.99,99,'RPG',0,0,'https://majorspoilers.com/wp-content/uploads/2014/12/DAI-Cover-Image.jpg'),(14,'Call of duty ghost','Vivi la storia dei ghost in uno dei capitoli di minor seguito della famosa saga',19.99,50,'FPS',0,0,'https://i5.walmartimages.com/seo/Call-of-Duty-Ghosts-Cover-Art-Laminated-Poster-Print-24-x-36_97b35fae-ee8e-48d0-8ab5-8837ffa32e5b.a7d7e6416c0b9444997a73b54803d5b8.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF'),(15,'Starfield','Esplora lo spazio profondo alla ricerca della conoscenza astrale, gira sulla tua nave e vivi il più grande universo mai creato',59.99,99,'FPS RPG',0,0,'https://i.redd.it/4r2l5k1zrnpb1.jpg'),(16,'The witcher 3','Ritorna a giocare con Geralt di Rivia nel terzo capitolo della saga e in quello riconosciuto unanimemente come uno dei migliori giochi di tutta la storia',49.99,100,'RPG',0,0,'https://www.nintendo.com/eu/media/images/10_share_images/games_15/nintendo_switch_download_software_1/H2x1_NSwitchDS_TheWitcher3WildHunt_enGB_image1280w.jpg'),(17,'Cassette beasts','Un moderno monster collector ispirato sia al mondo dei pokemon ma che sa regalare tante sorprese gradite e apprezzabili',29.99,98,'JRPG',0,0,'https://rawfury.com/wp-content/uploads/2021/10/CassetteBeasts_BoxArt-1.png'),(18,'Call of duty modern warfare','Vivi l\'epica saga di cod in una remastered moderna e riadattata ai tempi',19.99,100,'FPS',0,0,'https://cdn.mobygames.com/covers/8184635-call-of-duty-modern-warfare-playstation-4-front-cover.jpg'),(19,'Call of duty modern warfare 2','Il capitolo migliore di tutti i cod, rivivi le sue mappe storiche, le armi incredibili e la fantastica storia in campagna',9.99,100,'FPS',0,0,'https://imageio.forbes.com/specials-images/imageserve/628d337e791f9767c05ca2e7/1--2-/960x0.jpg?height=887&width=711&fit=bounds'),(20,'Red Dead Redemption 2','Torna dopo anni il secondo capitolo della saga western amata da tutti, questa volta nei panni di Arthur Morgan che vive gli ultimi anni della banda di Dutch in giro per il west',59.99,199,'FPS adventure',0,0,'https://rocket-chainsaw.b-cdn.net/wp-content/uploads/2018/05/Red-Dead-Redemption-2-New-Logo.jpg'),(21,'Lies of P','Un soul-like che porta in scena la storia del burattino più famoso di tutti, rivisitata in chiave horro',39.99,100,'Souls-like',0,0,'https://upload.wikimedia.org/wikipedia/en/d/de/Lies_of_p_cover_art.jpg'),(22,'Streetfighter 6','L\'ultimo picchiaduro della famosa saga, tantissimi nuovi personaggi, nuove movenze e un sistema di combattimento rivisitato',39.99,100,'Picchiaduro',0,0,'https://upload.wikimedia.org/wikipedia/en/9/94/Street_Fighter_6_box_art.jpg'),(23,'Bloodborne','Entra a Yarnham per scoprire il segreto del sanguesmunto, segui la luna ed esplora un mondo dove la notte non finisce mai e la luce non esiste',39.99,100,'Souls',0,0,'https://image.api.playstation.com/vulcan/img/rnd/202010/2614/Sy5e8DmeKIJVjlAGraPAJYkT.png'),(24,'Elden ring','L\'open world souls di fromsoftware, unico nel suo genere',69.99,75,'RPG',0,0,'https://p325k7wa.twic.pics/high/elden-ring/elden-ring/00-page-setup/elden-ring-new-header-mobile.jpg?twic=v1/resize=760/step=10/quality=80'),(25,'Tekken 8','L\'ultimo picchiaduro di bandai',69.99,4,'Picchiaduro',0,0,'https://www.codiciprodotto.it/wp-content/uploads/2024/03/TEKKEN-8-PC-COVER.jpg'),(26,'Baldur\'s gate 3','Il miglior GDR del mondo',59.99,19,'GDR',0,0,'https://image.api.playstation.com/vulcan/ap/rnd/202302/2321/3098481c9164bb5f33069b37e49fba1a572ea3b89971ee7b.jpg'),(27,'Nba 2k25','Nuovo gioco di basket',67.99,40,'Sport',0,0,'https://www.nbareligion.com/wp-content/uploads/2024/07/nba-2k25-tatum.webp'),(28,'Ea fc 25','Nuovissimo gioco di calcio sviluppato da EA sports, con nuova tecnologia e nuovi miglioramenti',79.99,80,'Sport',0,0,'https://multiplayer.net-cdn.it/thumbs/images/2024/07/17/ea_fc25_standard_keyart_4-5_4000x5000_hypermotion_jpg_800x0_crop_upscale_q85.jpg'),(29,'Pokemon Scarlatto e Violetto','I giochi pokemon di 9a generazione, per la prima volta in open world nella nuova regione di Paldea, gotta catch \'em all',49.99,199,'JRPG',0,0,'https://scarletviolet.pokemon.com/_images/home/header.jpg'),(30,'Final fantasy XVI','L\'ultimo episodio della storica saga di FF, entra in questa nuova avventura seguendo le gesta di ',69.99,54,'JRPG',0,0,'https://i0.wp.com/denjinden.com/wp-content/uploads/2023/07/final-fantasy-xvi-copertina.jpg?fit=1200%2C675&ssl=1'),(31,'Outer wilds','Esplora il sistema solare cercando di scoprirne i suoi misteri',19.99,29,'Avventura dinamico',0,0,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv23Z3h317VKIxw1zfUTQJT8X5j9j-oKO7SA&s'),(32,'Minecraft','Il miglior gioco di sempre.',19.99,1000,'Sandbox',0,0,'https://static.mondoxbox.com/shotsnw/132/132019.jpg'),(33,'Hollow knight','Scopri i segreti di nidosacro e aiuta il regno a tornare in vita',29.99,59,'Metroidvania',0,0,'https://multiplayer.net-cdn.it/thumbs/images/2024/06/06/vh_01_1080pjpg_jpg_1600x900_crop_q85.jpg'),(34,'Call of duty Black ops 6','Torna nel mondo di black ops con il sesto capitolo, nuove armi, nuovi mappe tutte da conoscere',69.99,299,'FPS',0,0,'https://i.ytimg.com/vi/KEahbP6YF0w/maxresdefault.jpg'),(35,'Grand Theft Auto V','Il capitolo di GTA più famoso, longevo e completo di sempre. Entra nei panni di un gangster per compiere la tua scalata al potere',19.99,499,'Avventura dinamico',0,0,'https://www.mondoxbox.com/images/shots/88/88546.jpg'),(36,'Black myth wukong','La storia a cui si è ispirato il creatore di DragonBall, diventa una scimmia calabrese e picchia tutti i nazisti',59.99,250,'Souls-like',0,0,'https://image.api.playstation.com/vulcan/ap/rnd/202405/2117/bd406f42e9352fdb398efcf21a4ffe575b2306ac40089d21.png'),(37,'Ghost of tsushima','Diventa uno shinobi nel giappone feudale per impedire l\'avanzata dei mongoli',39.99,50,'Action RPG',0,0,'https://images.everyeye.it/img-cover/ghost-of-tsushima-v20-37731.jpg'),(38,'Assassin\'s creed','Il primo capitolo della saga di assassini più famosa al mondo, vesti i panni dell\'assassino Altair Ibn-la-ahad nel suo viaggio per diventare maestro',9.99,10,'Action RPG',0,0,'https://i.ebayimg.com/images/g/2MUAAOSwEPxi~QgY/s-l1200.jpg'),(39,'Assassin\'s creed II','Il primo capitolo della saga di Ezio Auditore da Firenze, comincia la tua storia nella penisola italiana con l\'assassino più amato di tutti i tempi',19.99,50,'Action RPG',0,0,'https://cdn1.epicgames.com/salesEvent/salesEvent/AC2_GameName_Store_Portrait_1200x1600_1200x1600-2c5e000213988c5dde375bb2602e9986'),(40,'Assassin\'s creed Brotherhood','Ezio Auditore si sposta a Roma per contrastare il dominio dei Borgia, combatti la chiesa e il Papa per contrastare i templari',19.99,50,'Action RPG',0,0,'https://products.eneba.games/resized-products/BjwMz8G_350x200_3x-0.jpg'),(41,'Assassin\'s creed Revelations','L\'ultima parte della storia di Ezio Auditore, questa volta a Costantinopoli per conoscere tutti i segreti del vecchio maestro assassino Altair',19.99,50,'Action RPG',0,0,'https://cdn2.steamgriddb.com/grid/d7af7b223f926c4137c6d56084cd73e5.jpg'),(42,'Assassin\'s creed III','Vivi un\'avventura nel periodo della rivoluzione americana e il contrasto tra Asssassini e Templari nei panni di Haytham e Connor Kenway',24.99,50,'Action RPG',0,0,'https://static.posters.cz/image/1300/poster/assassin-s-creed-iii-cover-i12703.jpg'),(43,'Assassin\'s creed IV Black Flag','L\'epoca d\'oro della pirateria si apre davanti a te, diventa un pirata e salpa a bordo della tua nave nei panni dell\'assassino Edward Kenway per conoscere la storia degli assassini nei caraibi',29.99,150,'Action RPG',0,0,'https://www.ilvideogioco.com/wp-content/uploads/2013/02/assassins-creed-iv-black-flag-box-art-28022013.jpg'),(44,'Assassin\'s creed unity','Una nuova avventura nel mondo degli assassini, questa volta interpreta Arno Dorian come assassino ai tempi della rivoluzione francese. Gira per Parigi e contrasta l\'ascesa dei Templari',29.99,100,'Action RPG',0,0,'https://static.posters.cz/image/750/poster/assassin-s-creed-unity-cover-i22385.jpg'),(45,'Assassin\'s creed Syndicate','Vivi come i gemelli Frye nella Londra vittoriana patria della rivoluzione industriale. Gira per la città ostacolando il Gran Maestro Templare Crawford Starrick',29.99,100,'Action RPG',0,0,'https://cdn1.epicgames.com/offer/c9be94273fe244c08032ca493ad87434/ACSyndicateStandardPortrait_1200x1600-22c915715dca99edefe87fc9a7470094'),(46,'Assassin\'s creed Origins','L\'inizio della storia degli assassini nell\'Egitto di Cleopatra. Diventa Bayek di Siwa come medjai della regina',39.99,100,'Action RPG',0,0,'https://static.posters.cz/image/750/poster/assassins-creed-origins-cover-i49105.jpg'),(47,'Assassin\'s creed Odissey','Un altro Open World firmato Ubisoft, questa volta nell\'antica Grecia per vivere la tua personale Odissea',39.99,100,'Action RPG',0,0,'https://mir-s3-cdn-cf.behance.net/project_modules/1400/a734c167302871.5ba4cb8948099.jpg'),(48,'Assassin\'s creed valhalla','Viaggia nei panni di Eivor dalla Norvegia fino all\'Inghilterra per conquistare con il tuo clan di vichinghi tutta l\'isola britannica',49.99,100,'Action RPG',0,0,'https://static.posters.cz/image/1300/poster/assassin-s-creed-valhalla-standard-edition-i97796.jpg'),(49,'Rainbow Six Siege','Missioni specializzate nello sparatutto tattico migliore di sempre',19.99,500,'Tactical FPS',0,0,'https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/120072431/original/adc75aa1b934c3375dcb9207ff381401345aea32/make-you-a-rainbow-six-siege-cover-photo.png'),(50,'Undertale','Il videogioco Indie per eccellenza, il capolavoro immortale di Tobie Fox',5.99,200,'Indie ',0,0,'https://upload.wikimedia.org/wikipedia/commons/f/f1/Undertale_cover.jpg');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `showcase`
--

DROP TABLE IF EXISTS `showcase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `showcase` (
  `idshowcase` bigint NOT NULL AUTO_INCREMENT,
  `Id_prod` bigint NOT NULL,
  `Deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`idshowcase`),
  KEY `id_prodotto_idx` (`Id_prod`),
  CONSTRAINT `id_prod` FOREIGN KEY (`Id_prod`) REFERENCES `prodotto` (`Id_prod`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `showcase`
--

LOCK TABLES `showcase` WRITE;
/*!40000 ALTER TABLE `showcase` DISABLE KEYS */;
INSERT INTO `showcase` VALUES (1,24,0),(2,25,0),(3,26,0),(4,27,0),(5,28,0),(6,33,1),(7,31,1),(8,38,1),(9,39,1),(10,40,1),(11,41,1),(12,42,1),(13,43,1),(14,44,1),(15,45,1),(16,46,1),(17,47,1),(18,48,1),(19,36,1);
/*!40000 ALTER TABLE `showcase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utente`
--

DROP TABLE IF EXISTS `utente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utente` (
  `Id_utente` bigint NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) DEFAULT NULL,
  `Cognome` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `Admin` varchar(1) NOT NULL DEFAULT '0',
  `Deleted` varchar(1) NOT NULL DEFAULT '0',
  `Indirizzo` varchar(45) DEFAULT 'non inserito',
  `Stato` varchar(45) DEFAULT 'non inserito',
  `Città` varchar(45) DEFAULT 'non inserito',
  `Blocked` varchar(1) NOT NULL DEFAULT '0',
  `CAP` int DEFAULT '0',
  `Username` varchar(45) NOT NULL,
  `card_n` varchar(45) DEFAULT 'mancante',
  `cvc` bigint DEFAULT '0',
  `exp_date` varchar(45) DEFAULT 'mancante',
  PRIMARY KEY (`Id_utente`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utente`
--

LOCK TABLES `utente` WRITE;
/*!40000 ALTER TABLE `utente` DISABLE KEYS */;
INSERT INTO `utente` VALUES (1,'Alessandro','Fabbri','alexandros.fabbri@gmail.com','password','Y','N','Via Pioppa 68','non inserito','Ferrara','N',44123,'username','123456789',998,'05/2025'),(2,'Stefania','Borini','stefania.borini@libero.it','stefi','N','Y','non inserito','non inserito','non inserito','N',0,'stefi','mancante',0,'mancante'),(3,'Sofia','Zanetti','sofia.zanetti@gmail.com','sofi','Y','N','non inserito','non inserito','non inserito','N',0,'sofi','mancante',0,'mancante'),(4,'Pietro','Scotto','pietro.scotto@gmail.com','pit','N','Y','non inserito','non inserito','non inserito','N',0,'pit','mancante',0,'mancante'),(5,'Gabriele','Franchi','gabriele.franchi@gmail.com','frenk','N','N','non inserito','non inserito','non inserito','N',0,'frenk','mancante',0,'mancante'),(6,'Giovanni','Manfrini','giovanni.manfrini@gmail.com','manfro','N','N',NULL,'non inserito',NULL,'N',NULL,'manfro',NULL,NULL,NULL),(7,'Davide','Brescanzin','davide.brescanzin@gmail.com','bresca','N','N','non inserito','non inserito','non inserito','N',0,'bresca','mancante',0,'mancante'),(8,'Alessandro','Fabbri','alessandrofabbri777@gmail.com','alessandro','Y','Y','non inserito','non inserito','non inserito','N',0,'Ale','mancante',0,'mancante'),(9,'Piero','Zamboni','piero.zamboni@gmail.com','piero','N','Y',NULL,NULL,NULL,'N',NULL,'piero','mancante',0,'mancante'),(10,'Enrico','Ruzzon','enrico.ruzzon@gmail.com','enrico','N','N',NULL,NULL,NULL,'N',NULL,'enrico','mancante',0,'mancante'),(11,'Michael','Scarcella','michael.scarcella@gmail.com','mike','N','Y',NULL,NULL,NULL,'N',NULL,'mike',NULL,NULL,NULL),(12,'mario','rossi','mario.rossi@gmail.com','Rossi','N','N','Via penzale 8',NULL,'Cento','N',440120,'Mario','413741',312,'04/2024');
/*!40000 ALTER TABLE `utente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-14 15:56:30
