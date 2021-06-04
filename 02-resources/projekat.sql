-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.6.0-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for projekat
DROP DATABASE IF EXISTS `projekat`;
CREATE DATABASE IF NOT EXISTS `projekat` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `projekat`;

-- Dumping structure for table projekat.administrator
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.administrator: ~1 rows (approximately)
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`, `is_active`) VALUES
	(4, 'admin', '$2b$11$wQWBrg5c6EYD0N.iKfUIdOHg5gJAmYlM95D9jvIcptHuJdtnnFatW', 1);
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

-- Dumping structure for table projekat.article
DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Kratak opis',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Dugacak opis',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  `is_promoted` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_id`),
  UNIQUE KEY `uq_article_title` (`title`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.article: ~12 rows (approximately)
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `created_at`, `title`, `excerpt`, `description`, `is_active`, `is_promoted`, `category_id`) VALUES
	(1, '2021-05-28 02:56:02', 'Galeb', 'Kratak opis', 'Dugacak opis', 1, 0, 5),
	(2, '2021-05-28 03:03:46', 'Schogetten', 'Kratak opis', 'Dugacak opis', 1, 0, 5),
	(3, '2021-05-28 03:06:22', 'Toblerone Dark', 'Kratak opis', 'Dugacak opis', 1, 0, 5),
	(4, '2021-05-28 03:10:12', 'Milka bela', 'Kratak opis', 'Dugacak opis', 1, 0, 4),
	(5, '2021-05-28 03:16:19', 'Rochen', 'Kratak opis', 'Dugacak opis', 1, 0, 4),
	(6, '2021-05-28 03:19:57', 'Milka', 'Kratak opis', 'Dugacak opis', 1, 0, 6),
	(7, '2021-05-28 03:24:02', 'Dorina', 'Kratak opis', 'Dugacak opis', 1, 0, 6),
	(8, '2021-05-28 03:26:31', 'Kinder', 'Kratak opis', 'Dugacak opis', 1, 0, 6),
	(9, '2021-05-28 03:28:59', 'YoYo', 'Kratak opis', 'Dugacak opis', 1, 0, 6),
	(11, '2021-06-02 18:45:54', 'Guylian', 'Kratak opis', 'Dugacak opis', 1, 0, 2),
	(12, '2021-06-02 18:50:58', 'Premier', 'Kratak opis', 'Dugacak opis', 1, 0, 2),
	(13, '2021-06-02 18:54:08', 'Haribo', 'Kratak opis', 'Dugacak opis', 1, 0, 7),
	(14, '2021-06-02 18:57:11', 'Negro', 'Kratak opis', 'Dugacak opis', 1, 0, 8);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

-- Dumping structure for table projekat.article_feature
DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `article_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.article_feature: ~79 rows (approximately)
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `value`, `article_id`, `feature_id`) VALUES
	(1, 'Hrvatska', 1, 1),
	(2, '100gr', 11, 5),
	(3, '2021', 1, 10),
	(4, '3 godine', 1, 7),
	(5, '20%', 1, 13),
	(6, '80%', 1, 14),
	(7, 'Nemacka', 2, 1),
	(8, '150gr', 2, 4),
	(9, '2020', 2, 10),
	(11, '2 godine', 2, 7),
	(12, '25%', 2, 13),
	(13, '65%', 2, 14),
	(14, 'Svajcarska', 3, 1),
	(15, '200gr', 3, 4),
	(16, '2020', 3, 10),
	(17, '1 godina', 3, 7),
	(18, '28%', 3, 13),
	(19, '66%', 3, 14),
	(20, 'Lesnik', 2, 15),
	(21, 'Srbija', 4, 1),
	(22, '120gr', 4, 4),
	(23, '2 godine', 4, 7),
	(24, '2020', 4, 10),
	(25, '36%', 4, 13),
	(26, '28%', 4, 14),
	(27, 'Grozdje', 4, 15),
	(28, 'Nemacka', 5, 1),
	(29, '100gr', 5, 4),
	(30, '2 godine', 5, 7),
	(31, '2020', 5, 10),
	(32, '41%', 5, 13),
	(33, '31%', 5, 14),
	(34, 'Srbija', 6, 1),
	(35, '120gr', 6, 4),
	(36, '2 godine', 6, 7),
	(37, '2021', 6, 10),
	(38, '31%', 6, 13),
	(39, '42%', 6, 14),
	(40, 'Keks', 6, 15),
	(41, 'Srbija', 7, 1),
	(42, '135gr', 7, 4),
	(43, '3 godine', 7, 7),
	(44, '2019', 7, 10),
	(45, '38%', 7, 13),
	(47, '37%', 7, 14),
	(48, 'Nemacka', 8, 1),
	(49, '120gr', 8, 4),
	(50, '1 godina', 8, 7),
	(51, '2021', 8, 10),
	(52, '45%', 8, 13),
	(53, '23%', 8, 14),
	(54, 'Hrvatska', 9, 1),
	(55, '200gr', 9, 4),
	(56, '3 godine', 9, 7),
	(57, '2019', 9, 10),
	(58, '32%', 9, 13),
	(59, '26%', 9, 14),
	(60, 'Pirinac', 9, 15),
	(66, 'Poljska', 11, 2),
	(67, '2020', 11, 11),
	(68, '3 godine', 11, 8),
	(69, 'Visnja', 11, 19),
	(70, 'Mlecna', 11, 20),
	(71, 'Makedonija', 12, 2),
	(74, '135gr', 12, 5),
	(75, '2 godine', 12, 8),
	(76, '2020', 12, 12),
	(77, 'Krem', 12, 19),
	(78, 'Crna', 12, 20),
	(79, 'Hrvatska', 13, 3),
	(80, '100gr', 13, 6),
	(81, '2021', 13, 12),
	(82, '3 godine', 13, 9),
	(83, 'Sarene', 13, 17),
	(84, 'Slatke', 13, 16),
	(85, 'Srednje', 13, 18),
	(86, 'Srbija', 14, 3),
	(87, '200gr', 14, 6),
	(88, '2019', 14, 12),
	(89, '3 godine', 14, 9),
	(90, 'Crna', 14, 17),
	(91, 'Mentol', 14, 16),
	(92, 'Velike', 14, 18);
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

-- Dumping structure for table projekat.article_price
DROP TABLE IF EXISTS `article_price`;
CREATE TABLE IF NOT EXISTS `article_price` (
  `article_price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `price` decimal(10,2) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`article_price_id`),
  KEY `fk_article_price_article_id` (`article_id`),
  CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.article_price: ~14 rows (approximately)
/*!40000 ALTER TABLE `article_price` DISABLE KEYS */;
INSERT INTO `article_price` (`article_price_id`, `created_at`, `price`, `article_id`) VALUES
	(1, '2021-05-28 03:34:31', 2.14, 1),
	(2, '2021-05-28 03:35:11', 1.30, 2),
	(3, '2021-05-28 03:35:38', 1.79, 3),
	(4, '2021-05-28 03:37:04', 1.05, 4),
	(5, '2021-05-28 03:37:17', 1.11, 5),
	(6, '2021-05-28 03:37:27', 1.40, 6),
	(7, '2021-05-28 03:37:43', 1.22, 7),
	(8, '2021-05-28 03:37:54', 1.90, 8),
	(9, '2021-05-28 03:38:09', 1.52, 9),
	(10, '2021-05-28 03:44:29', 1.00, 10),
	(11, '2021-06-02 18:46:29', 1.32, 11),
	(12, '2021-06-02 18:51:15', 1.67, 12),
	(13, '2021-06-02 18:54:26', 0.76, 13),
	(14, '2021-06-02 18:57:22', 0.58, 14);
/*!40000 ALTER TABLE `article_price` ENABLE KEYS */;

-- Dumping structure for table projekat.cart
DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `fk_cart_user_id` (`user_id`),
  CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.cart: ~5 rows (approximately)
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `created_at`, `user_id`) VALUES
	(1, '2021-06-02 15:54:51', 7),
	(2, '2021-06-02 17:29:42', 7),
	(3, '2021-06-02 18:00:51', 7),
	(4, '2021-06-02 19:46:13', 7),
	(5, '2021-06-03 19:58:30', 7);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

-- Dumping structure for table projekat.cart_article
DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL,
  `cart_id` int(10) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.cart_article: ~12 rows (approximately)
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
INSERT INTO `cart_article` (`cart_article_id`, `quantity`, `cart_id`, `article_id`) VALUES
	(1, 1, 1, 4),
	(2, 1, 1, 5),
	(3, 1, 1, 8),
	(5, 1, 1, 3),
	(7, 1, 2, 2),
	(8, 1, 2, 1),
	(9, 1, 2, 8),
	(10, 6, 3, 4),
	(11, 12, 3, 5),
	(13, 5, 4, 4),
	(14, 2, 4, 13),
	(15, 1, 4, 11);
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

-- Dumping structure for table projekat.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent__category_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  KEY `fk_category_parent__category_id` (`parent__category_id`),
  CONSTRAINT `fk_category_parent__category_id` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.category: ~8 rows (approximately)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(1, 'Cokolada', 'cokolada.jpg', NULL),
	(2, 'Praline', 'praline.jpg', NULL),
	(3, 'Bombone', 'bombone.jpg', NULL),
	(4, 'Bela cokolada', 'belacoko.png', 1),
	(5, 'Crna cokolada', 'crnacoko.jpg', 1),
	(6, 'Mlecna Cokolada', 'mlecnacoko.jpg', 1),
	(7, 'Gumene bombone', 'gumbom.jpg', 3),
	(8, 'Tvrde bombone', 'tvrdbom.jpg', 3);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table projekat.feature
DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.feature: ~20 rows (approximately)
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(17, 'Boja', 3),
	(10, 'Godina proizvodnje', 1),
	(11, 'Godina proizvodnje', 2),
	(12, 'Godina proizvodnje', 3),
	(4, 'Gramaza', 1),
	(5, 'Gramaza', 2),
	(6, 'Gramaza', 3),
	(14, 'Kolicina kakaa', 1),
	(13, 'Kolicina secera', 1),
	(15, 'Komadici', 1),
	(19, 'Punjenje', 2),
	(7, 'Rok trajanja', 1),
	(8, 'Rok trajanja', 2),
	(9, 'Rok trajanja', 3),
	(16, 'Ukus', 3),
	(18, 'Velicina komada', 3),
	(20, 'Vrsta cokolade', 2),
	(1, 'Zemlja porekla', 1),
	(2, 'Zemlja porekla', 2),
	(3, 'Zemlja porekla', 3);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

-- Dumping structure for table projekat.order
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','rejected','accepted','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `cart_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.order: ~3 rows (approximately)
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`order_id`, `created_at`, `status`, `cart_id`) VALUES
	(7, '2021-06-02 17:29:42', 'pending', 1),
	(8, '2021-06-02 18:00:50', 'pending', 2),
	(9, '2021-06-02 19:46:13', 'pending', 3),
	(10, '2021-06-03 19:58:30', 'pending', 4);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

-- Dumping structure for table projekat.photo
DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`photo_id`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.photo: ~11 rows (approximately)
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `image_path`, `article_id`) VALUES
	(2, 'static/uploads/2021/05/7f9ef535-8a96-4a74-bf33-91e7521a7a39-8927674925086.jpg', 1),
	(3, 'static/uploads/2021/05/55d9e745-4155-443c-b43a-37cfb4e36466-schogetten_crna.jpg', 2),
	(4, 'static/uploads/2021/06/152987ce-c00d-4189-84f2-01faf4ada97f-8895809290270.jpg', 8),
	(5, 'static/uploads/2021/06/8c778003-dd70-4324-8a3c-3def75f2094e-YoYo-150gjpgw.ebp', 9),
	(6, 'static/uploads/2021/06/29aa6586-584b-49b4-897d-494a01de7c06-8822971957278.png', 6),
	(7, 'static/uploads/2021/06/0225bf1b-5e96-4ab9-aec2-c46e7926871f-cokdornoisse220g-27953-637414285006742535_708_7082xj.peg', 7),
	(8, 'static/uploads/2021/06/3e4c95a4-09da-4de4-8596-db3bdcf8f33c-8882913968158.jpg', 4),
	(9, 'static/uploads/2021/06/c2de3106-751b-4797-bb61-817fe6b34a61-download.jpg', 5),
	(11, 'static/uploads/2021/06/03521ca4-711b-44ed-b012-cfb1b603e2b5-42642_toblerone_dark_360g.jpg', 3),
	(12, 'static/uploads/2021/06/dd49a2e7-149c-49f2-aaa8-cadff70c7fc2-015095019_1l.jpg', 11),
	(13, 'static/uploads/2021/06/4b5c001f-68bb-46ba-8f0a-1d6a1a7cec09-bombonjera-paleta.jpg', 12),
	(14, 'static/uploads/2021/06/f3a3dae2-036b-4fc8-886a-af497f1e1b72-haribo_goldbren_klein.jpg', 13),
	(15, 'static/uploads/2021/06/010d8635-e69c-496f-ba3e-5089880dcec8-8927693930526.jpg', 14);
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

-- Dumping structure for table projekat.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_reset_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `forename` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uq_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table projekat.user: ~1 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `created_at`, `email`, `password_hash`, `password_reset_code`, `forename`, `surname`, `phone_number`, `postal_address`, `is_active`) VALUES
	(7, '2021-05-22 02:41:12', 'cadjo6@gmail.com', '$2b$11$ORsGsAIMu1bL8s291gpBPOPoIkhUp9rdWC0EP7CrPJMLsuO6iQ9tu', NULL, 'Aleksa', 'Cadjo', '0692172676', 'Borivoja Stevanovica 5', 1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
