-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: host.docker.internal:3306
-- Generation Time: Dec 10, 2023 at 07:28 AM
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
(1, '2023-12-10 07:12:17.876808', '2023-12-10 07:28:20.748593', 'admin@gmail.com', 'Chavis Nguyen', '$2a$10$stY99i.XHafRocXEkROzkOifmRT7rQNe3WV5ab5MoSF8LpBRMCwtu', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'admin'),
(4, '2023-12-10 07:15:07.093917', '2023-12-10 07:15:07.093917', 'dungg.nm1@gmail.com', 'Dung Nguyen Minh', '$2a$10$eesjjjSzVpvD7x7aq5cBT.Wbz/udGe2M0vnS3oCnJpk688sWRXaca', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'user');

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `user_model`
--
ALTER TABLE `user_model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
