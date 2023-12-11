-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: host.docker.internal:3306
-- Generation Time: Dec 11, 2023 at 01:10 PM
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
-- Table structure for table `category_entity`
--

CREATE TABLE `category_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category_entity`
--

INSERT INTO `category_entity` (`id`, `createdAt`, `updatedAt`, `name`) VALUES
(1, '2023-12-11 11:38:04.873504', '2023-12-11 11:38:04.873504', 'Chavis'),
(4, '2023-12-11 11:39:15.534905', '2023-12-11 11:39:15.534905', 'CNTT'),
(7, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Game');

-- --------------------------------------------------------

--
-- Table structure for table `comment_entity`
--

CREATE TABLE `comment_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `content` varchar(255) NOT NULL,
  `authorId` int DEFAULT NULL,
  `documentId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `uploader_id` int DEFAULT NULL,
  `lecturerId` int DEFAULT NULL,
  `subjectId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document_entity`
--

INSERT INTO `document_entity` (`id`, `createdAt`, `updatedAt`, `title`, `description`, `download_url`, `download_count`, `semester`, `is_verified`, `uploader_id`, `lecturerId`, `subjectId`) VALUES
(12, '2023-12-11 13:08:55.966056', '2023-12-11 13:08:55.966056', 'Hello kitty', NULL, 'https://github.com/dungnguyenBKA/template-react-js', 0, '', 0, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `document_entity_categories_category_entity`
--

CREATE TABLE `document_entity_categories_category_entity` (
  `documentEntityId` int NOT NULL,
  `categoryEntityId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document_entity_categories_category_entity`
--

INSERT INTO `document_entity_categories_category_entity` (`documentEntityId`, `categoryEntityId`) VALUES
(12, 1),
(12, 4);

-- --------------------------------------------------------

--
-- Table structure for table `document_entity_liked_users_user_model`
--

CREATE TABLE `document_entity_liked_users_user_model` (
  `documentEntityId` int NOT NULL,
  `userModelId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lecturer_entity`
--

CREATE TABLE `lecturer_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `name` varchar(255) NOT NULL,
  `profile_url` varchar(255) NOT NULL,
  `schoolId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `lecturer_entity`
--

INSERT INTO `lecturer_entity` (`id`, `createdAt`, `updatedAt`, `name`, `profile_url`, `schoolId`) VALUES
(1, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'Chavis Nguyễn', 'https://www.linkedin.com/in/chavisng/', 1),
(4, '2023-12-11 11:58:24.915267', '2023-12-11 11:58:24.915267', 'Andrew Tate', 'https://www.linkedin.com/in/andrew_tate/', 2);

-- --------------------------------------------------------

--
-- Table structure for table `school_entity`
--

CREATE TABLE `school_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `school_entity`
--

INSERT INTO `school_entity` (`id`, `createdAt`, `updatedAt`, `name`, `code`) VALUES
(1, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Trường Công nghệ thông tin', 'CNTT'),
(2, '2023-12-11 11:50:11.400382', '2023-12-11 11:50:11.400382', 'Khoa Điện tử viễn thông', 'ĐTVT');

-- --------------------------------------------------------

--
-- Table structure for table `subject_entity`
--

CREATE TABLE `subject_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `schoolId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `subject_entity`
--

INSERT INTO `subject_entity` (`id`, `createdAt`, `updatedAt`, `name`, `code`, `schoolId`) VALUES
(1, '2023-12-11 12:09:43.991871', '2023-12-11 12:09:43.991871', 'Lập trình hướng đối tượng', 'OOP', 1);

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
(1, '2023-12-10 11:08:58.930672', '2023-12-10 11:45:06.843171', 'admin@gmail.com', 'Chavis Nguyen', '$2a$10$vM1eUsvuusdnbmefD1e7wuy8MIcp/3RLReLSGPC0rGN/Tov4.QORy', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'admin'),
(2, '2023-12-10 11:45:26.969016', '2023-12-10 11:45:26.969016', 'dungg.nm@gmail.com', 'Dung Nguyen Minh', '$2a$10$v.lit3gT/9Q0mIBVSMHR1ukUpCFNKE5FwWf16zIq.VccaOwLTCn3O', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_view_document_entity`
--

CREATE TABLE `user_view_document_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `documentId` int DEFAULT NULL,
  `userId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_view_document_entity`
--

INSERT INTO `user_view_document_entity` (`id`, `createdAt`, `updatedAt`, `documentId`, `userId`) VALUES
(3, '2023-12-11 13:09:40.651688', '2023-12-11 13:09:40.651688', 12, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category_entity`
--
ALTER TABLE `category_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_ecbe8ebc20a3c7cd594d8e445e` (`name`);

--
-- Indexes for table `comment_entity`
--
ALTER TABLE `comment_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_31f70669b3ae650b3335cc02417` (`authorId`),
  ADD KEY `FK_4d3727bb7b22e0f40a3de3a2a22` (`documentId`);

--
-- Indexes for table `document_entity`
--
ALTER TABLE `document_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_0c98e58dd42c6ff71afae6f0959` (`uploader_id`),
  ADD KEY `FK_8d0e93cc90d25a1c28671a88522` (`lecturerId`),
  ADD KEY `FK_318121d98f78517a8c1ab575844` (`subjectId`);

--
-- Indexes for table `document_entity_categories_category_entity`
--
ALTER TABLE `document_entity_categories_category_entity`
  ADD PRIMARY KEY (`documentEntityId`,`categoryEntityId`),
  ADD KEY `IDX_168c713351deae80b85cc41264` (`documentEntityId`),
  ADD KEY `IDX_60c31f25dda0847e7ea53ffb40` (`categoryEntityId`);

--
-- Indexes for table `document_entity_liked_users_user_model`
--
ALTER TABLE `document_entity_liked_users_user_model`
  ADD PRIMARY KEY (`documentEntityId`,`userModelId`),
  ADD KEY `IDX_ee85783b9dc2eccb1da083a708` (`documentEntityId`),
  ADD KEY `IDX_ba263cb4783e27aafbeb8e3424` (`userModelId`);

--
-- Indexes for table `lecturer_entity`
--
ALTER TABLE `lecturer_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_6d1fe2c0a244ab6f1e0d1fc309` (`profile_url`),
  ADD KEY `FK_c7426844b3383b5b251622c6f45` (`schoolId`);

--
-- Indexes for table `school_entity`
--
ALTER TABLE `school_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_c153fa4cf5a2c086bc453a034b` (`name`),
  ADD UNIQUE KEY `IDX_79a86f6c71347c0aebf725dcbe` (`code`);

--
-- Indexes for table `subject_entity`
--
ALTER TABLE `subject_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_701690cc7821d160a7c427bf90` (`name`),
  ADD UNIQUE KEY `IDX_e8dfe82f1cb6c3ac67751a1c67` (`code`),
  ADD KEY `FK_aa984d6609a43704fbd590a4b91` (`schoolId`);

--
-- Indexes for table `user_model`
--
ALTER TABLE `user_model`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_864bd044bba869304084843358` (`email`);

--
-- Indexes for table `user_view_document_entity`
--
ALTER TABLE `user_view_document_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dba8d5cdf31426290653a12789d` (`documentId`),
  ADD KEY `FK_bc28078388cbaa4e5f34b7f80ea` (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category_entity`
--
ALTER TABLE `category_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `comment_entity`
--
ALTER TABLE `comment_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `document_entity`
--
ALTER TABLE `document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `lecturer_entity`
--
ALTER TABLE `lecturer_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `school_entity`
--
ALTER TABLE `school_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subject_entity`
--
ALTER TABLE `subject_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_model`
--
ALTER TABLE `user_model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_view_document_entity`
--
ALTER TABLE `user_view_document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment_entity`
--
ALTER TABLE `comment_entity`
  ADD CONSTRAINT `FK_31f70669b3ae650b3335cc02417` FOREIGN KEY (`authorId`) REFERENCES `user_model` (`id`),
  ADD CONSTRAINT `FK_4d3727bb7b22e0f40a3de3a2a22` FOREIGN KEY (`documentId`) REFERENCES `document_entity` (`id`);

--
-- Constraints for table `document_entity`
--
ALTER TABLE `document_entity`
  ADD CONSTRAINT `FK_0c98e58dd42c6ff71afae6f0959` FOREIGN KEY (`uploader_id`) REFERENCES `user_model` (`id`),
  ADD CONSTRAINT `FK_318121d98f78517a8c1ab575844` FOREIGN KEY (`subjectId`) REFERENCES `subject_entity` (`id`),
  ADD CONSTRAINT `FK_8d0e93cc90d25a1c28671a88522` FOREIGN KEY (`lecturerId`) REFERENCES `lecturer_entity` (`id`);

--
-- Constraints for table `document_entity_categories_category_entity`
--
ALTER TABLE `document_entity_categories_category_entity`
  ADD CONSTRAINT `FK_168c713351deae80b85cc412644` FOREIGN KEY (`documentEntityId`) REFERENCES `document_entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_60c31f25dda0847e7ea53ffb401` FOREIGN KEY (`categoryEntityId`) REFERENCES `category_entity` (`id`);

--
-- Constraints for table `document_entity_liked_users_user_model`
--
ALTER TABLE `document_entity_liked_users_user_model`
  ADD CONSTRAINT `FK_ba263cb4783e27aafbeb8e3424b` FOREIGN KEY (`userModelId`) REFERENCES `user_model` (`id`),
  ADD CONSTRAINT `FK_ee85783b9dc2eccb1da083a7086` FOREIGN KEY (`documentEntityId`) REFERENCES `document_entity` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lecturer_entity`
--
ALTER TABLE `lecturer_entity`
  ADD CONSTRAINT `FK_c7426844b3383b5b251622c6f45` FOREIGN KEY (`schoolId`) REFERENCES `school_entity` (`id`);

--
-- Constraints for table `subject_entity`
--
ALTER TABLE `subject_entity`
  ADD CONSTRAINT `FK_aa984d6609a43704fbd590a4b91` FOREIGN KEY (`schoolId`) REFERENCES `school_entity` (`id`);

--
-- Constraints for table `user_view_document_entity`
--
ALTER TABLE `user_view_document_entity`
  ADD CONSTRAINT `FK_bc28078388cbaa4e5f34b7f80ea` FOREIGN KEY (`userId`) REFERENCES `user_model` (`id`),
  ADD CONSTRAINT `FK_dba8d5cdf31426290653a12789d` FOREIGN KEY (`documentId`) REFERENCES `document_entity` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
