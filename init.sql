-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: host.docker.internal:3306
-- Generation Time: Dec 10, 2023 at 11:26 AM
-- Server version: 8.0.35
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tele_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `document_entity`
--

CREATE TABLE `document_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `download_url` varchar(255) NOT NULL,
  `download_count` int NOT NULL DEFAULT '0',
  `semester` varchar(255) NOT NULL DEFAULT '',
  `is_verified` tinyint NOT NULL DEFAULT '0',
  `uploader_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document_entity`
--

INSERT INTO `document_entity` (`id`, `createdAt`, `updatedAt`, `title`, `description`, `download_url`, `download_count`, `semester`, `is_verified`, `uploader_id`) VALUES
(1, '2023-12-10 11:11:28.109025', '2023-12-10 11:24:39.000000', 'Hello kitty', NULL, 'https://github.com/dungnguyenBKA/template-react-js', 0, '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_model`
--

CREATE TABLE `user_model` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_model`
--

INSERT INTO `user_model` (`id`, `createdAt`, `updatedAt`, `email`, `full_name`, `password`, `avatar`, `role`) VALUES
(1, '2023-12-10 11:08:58.930672', '2023-12-10 11:21:06.751961', 'dungg.nm@gmail.com', 'Dung Nguyen Minh', '$2a$10$vM1eUsvuusdnbmefD1e7wuy8MIcp/3RLReLSGPC0rGN/Tov4.QORy', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `document_entity`
--
ALTER TABLE `document_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_0c98e58dd42c6ff71afae6f0959` (`uploader_id`);

--
-- Indexes for table `user_model`
--
ALTER TABLE `user_model`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_864bd044bba869304084843358` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `document_entity`
--
ALTER TABLE `document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_model`
--
ALTER TABLE `user_model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `document_entity`
--
ALTER TABLE `document_entity`
  ADD CONSTRAINT `FK_0c98e58dd42c6ff71afae6f0959` FOREIGN KEY (`uploader_id`) REFERENCES `user_model` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
