-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: telebe_mysql:3306
-- Generation Time: Jan 03, 2024 at 06:21 AM
-- Server version: 8.0.35
-- PHP Version: 8.2.14

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
(7, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Game'),
(8, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Hóa học'),
(9, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Đồ án tốt nghiệp'),
(10, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Cơ khí'),
(11, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Hàng không'),
(12, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'kinh tế'),
(13, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Ngôn ngữ'),
(14, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Toán tin'),
(15, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Giữa kỳ'),
(16, '2023-12-11 12:25:06.323574', '2023-12-11 12:25:06.323574', 'Cuối kỳ');

-- --------------------------------------------------------

--
-- Table structure for table `comment_entity`
--

CREATE TABLE `comment_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `authorId` int DEFAULT NULL,
  `documentId` int DEFAULT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `comment_entity`
--

INSERT INTO `comment_entity` (`id`, `createdAt`, `updatedAt`, `authorId`, `documentId`, `content`) VALUES
(1, '2024-01-02 16:00:33.413980', '2024-01-02 16:00:33.413980', 2, 13, 'Good '),
(2, '2024-01-02 16:00:55.858384', '2024-01-02 16:00:55.858384', 2, 15, 'Good'),
(3, '2024-01-02 16:02:15.700345', '2024-01-02 16:02:15.700345', 2, 15, 'Good');

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
  `download_count` int NOT NULL DEFAULT '0',
  `is_verified` tinyint NOT NULL DEFAULT '0',
  `uploader_id` int DEFAULT NULL,
  `lecturerId` int DEFAULT NULL,
  `subjectId` int DEFAULT NULL,
  `evidence_url` varchar(255) NOT NULL DEFAULT '0',
  `semesterId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `document_entity`
--

INSERT INTO `document_entity` (`id`, `createdAt`, `updatedAt`, `title`, `description`, `download_count`, `is_verified`, `uploader_id`, `lecturerId`, `subjectId`, `evidence_url`, `semesterId`) VALUES
(13, '2024-01-02 15:28:36.898326', '2024-01-02 15:28:36.898326', 'Lec02-BasicSocket', 'Lec02-BasicSocket', 0, 0, 2, 1, 1, '1704209316593.jpg', 1),
(14, '2024-01-02 15:32:38.261881', '2024-01-02 15:32:38.261881', 'ISD', 'Phát triển phần mềm chuẩn kỹ năng ITSS', 0, 0, 2, 1, 1, '0', 1),
(15, '2024-01-02 15:40:24.281555', '2024-01-02 15:40:24.281555', 'Lec01-Overview', 'Lec01-Overview', 0, 0, 2, 1, 1, '1704210024268.jpg', 1),
(16, '2024-01-03 03:55:24.306323', '2024-01-03 03:55:24.306323', 'chủ nghĩa xã hội khoa học', 'chủ nghĩa xã hội khoa học', 0, 0, 1, 5, 4, '0', 1),
(17, '2024-01-03 03:56:53.662068', '2024-01-03 03:56:53.662068', 'Triết học', 'Triết học', 0, 0, 1, 6, 2, '0', 1),
(18, '2024-01-03 03:57:33.872558', '2024-01-03 03:57:33.872558', 'Kinh tế chính trị', 'Kinh tế chính trị', 0, 0, 1, 5, 3, '0', 1),
(19, '2024-01-03 03:58:21.873483', '2024-01-03 03:58:21.873483', 'Lịch sử Đảng', 'Lịch sử Đảng', 0, 0, 1, 10, 5, '0', 1),
(20, '2024-01-03 03:59:42.534965', '2024-01-03 03:59:42.534965', 'Tư tưởng HCM', 'Tư tưởng HCM', 0, 0, 1, 5, 6, '0', 1),
(21, '2024-01-03 04:05:14.093918', '2024-01-03 04:05:14.093918', 'C cơ bản', 'C cơ bản', 0, 0, 1, 12, 7, '0', 1),
(22, '2024-01-03 04:06:31.695965', '2024-01-03 04:06:31.695965', 'C nâng cao', 'C nâng cao', 0, 0, 1, 13, 8, '0', 1),
(23, '2024-01-03 04:08:39.270514', '2024-01-03 04:08:39.270514', 'Đạo đức máy tính', 'Đạo đức máy tính', 0, 0, 1, 14, 9, '0', 1),
(24, '2024-01-03 04:09:05.401917', '2024-01-03 04:09:05.401917', 'Mạch logic', 'Mạch logic', 0, 0, 1, 12, 10, '0', 1),
(25, '2024-01-03 04:12:19.991818', '2024-01-03 04:12:19.991818', 'Thực hành mạch logic', 'Thực hành mạch logic', 0, 0, 1, 1, 11, '0', 1),
(26, '2024-01-03 04:27:42.002428', '2024-01-03 04:27:42.002428', 'Đồ án tốt nghiệp', 'Đồ án tốt nghiệp', 0, 0, 1, 14, 13, '1704256061987.png', 2);

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
(13, 4),
(13, 7),
(14, 4),
(15, 4),
(15, 7),
(16, 4),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 4);

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
-- Table structure for table `file_entity`
--

CREATE TABLE `file_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `url` varchar(255) NOT NULL,
  `documentId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `file_entity`
--

INSERT INTO `file_entity` (`id`, `createdAt`, `updatedAt`, `url`, `documentId`) VALUES
(1, '2024-01-02 15:28:36.915510', '2024-01-02 15:28:36.915510', '1704209314605.pdf', 13),
(2, '2024-01-02 15:32:38.275407', '2024-01-02 15:32:38.275407', '1704209556994.pdf', 14),
(3, '2024-01-02 15:32:38.277275', '2024-01-02 15:32:38.277275', '1704209558053.pdf', 14),
(4, '2024-01-02 15:32:38.278615', '2024-01-02 15:32:38.278615', '1704209558173.pdf', 14),
(5, '2024-01-02 15:40:24.292942', '2024-01-02 15:40:24.292942', '1704210023305.pdf', 15),
(6, '2024-01-03 03:55:24.321693', '2024-01-03 03:55:24.321693', '1704254122695.pdf', 16),
(7, '2024-01-03 03:56:53.677496', '2024-01-03 03:56:53.677496', '1704254211450.pdf', 17),
(8, '2024-01-03 03:57:33.883733', '2024-01-03 03:57:33.883733', '1704254250335.pdf', 18),
(9, '2024-01-03 03:58:21.886507', '2024-01-03 03:58:21.886507', '1704254299087.pdf', 19),
(10, '2024-01-03 03:59:42.546162', '2024-01-03 03:59:42.546162', '1704254379734.pdf', 20),
(11, '2024-01-03 04:05:14.107272', '2024-01-03 04:05:14.107272', '1704254712610.pdf', 21),
(12, '2024-01-03 04:06:31.709923', '2024-01-03 04:06:31.709923', '1704254790278.pdf', 22),
(13, '2024-01-03 04:08:39.280797', '2024-01-03 04:08:39.280797', '1704254917824.pdf', 23),
(14, '2024-01-03 04:09:05.416516', '2024-01-03 04:09:05.416516', '1704254944324.pdf', 24),
(15, '2024-01-03 04:12:20.006928', '2024-01-03 04:12:20.006928', '1704255138761.pdf', 25),
(16, '2024-01-03 04:27:42.013730', '2024-01-03 04:27:42.013730', '1704256061602.pdf', 26);

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
(4, '2023-12-11 11:58:24.915267', '2023-12-11 11:58:24.915267', 'Andrew Tate', 'https://www.linkedin.com/in/andrew_tate/', 2),
(5, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Trần Việt Thắng	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ts-tran-viet-thang-240784.html', 5),
(6, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Đinh Thanh Xuân	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/pgs-ts-dinh-thanh-xuan-240950.html', 5),
(7, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Mai Thị Thanh	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ts-mai-thi-thanh-240939.html', 5),
(8, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Hoàng Thị Hạnh	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ts-hoang-thi-hanh-240828.html', 5),
(9, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Lê Văn Kiện	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ths-le-van-kien-240806.html', 5),
(10, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Hoàng Thu Hương	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ts-hoang-thu-huong-240844.html', 5),
(11, '2024-01-02 16:09:51.050000', '2024-01-02 16:09:51.050000', 'Vũ Mai Lương	', 'https://fpt.hust.edu.vn/vi/bo-mon/triet-hoc/ths-vu-thi-mai-luong-240961.html', 5),
(12, '2024-01-03 03:47:13.480000', '2024-01-03 03:47:13.480000', 'Vũ Thị Hương Giang', 'https://soict.hust.edu.vn/ts-vu-thi-huong-giang.html', 1),
(13, '2024-01-03 03:47:13.480000', '2024-01-03 03:47:13.480000', 'Lê Thanh Hương', 'https://soict.hust.edu.vn/pgs-ts-le-thanh-huong.html', 1),
(14, '2024-01-03 03:47:49.476000', '2024-01-03 03:47:49.476000', 'Huỳnh Quyết Thắng', 'https://soict.hust.edu.vn/psg-ts-huynh-quyet-thang.html', 1),
(15, '2024-01-03 03:47:49.476000', '2024-01-03 03:47:49.476000', 'PGS. TS. THÂN QUANG KHOÁT', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5171-400x600.jpg', 1),
(16, '2023-12-11 11:58:24.915267', '2023-12-11 11:58:24.915267', 'TS. NGUYỄN PHI LÊ', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/DHP_5245-400x599.jpg', 2),
(17, '2023-12-11 11:58:24.915267', '2023-12-11 11:58:24.915267', 'TS. NGUYỄN BÌNH MINH', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5206-400x599.jpg', 2),
(18, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. NGUYỄN KIÊM HIẾU', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5863-400x599.jpg', 1),
(19, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. TRỊNH THÀNH TRUNG', 'https://soict.hust.edu.vn/wp-content/uploads/trinh-thanh-trung.jpg', 1),
(20, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. ĐỖ BÁ LÂM', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5326-400x600.jpg', 1),
(21, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. ĐINH VIẾT SANG', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/DHP_5925.jpg\r\n', 1),
(22, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. BÙI QUỐC TRUNG', 'https://soict.hust.edu.vn/wp-content/uploads/Bui-Quoc-Trung.jpg', 1),
(23, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'THS. NGÔ VĂN LINH', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5762-400x599.jpg', 1),
(24, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. ĐÀO THÀNH CHUNG', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5942-400x599.jpg', 1),
(25, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. NGUYỄN THỊ THU HƯƠNG', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/DHP_5783-400x599.jpg', 1),
(26, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'PGS.TS. NGUYỄN THỊ KIM ANH', 'https://soict.hust.edu.vn/wp-content/uploads/2018/04/DHP_5901-400x599.jpg', 1),
(27, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. TRẦN THẾ HÙNG', 'https://soict.hust.edu.vn/wp-content/uploads/tran-the-hung.jpg', 1),
(28, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'PGS.TS. HUỲNH THỊ THANH BÌNH', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/DHP_5722-400x599.jpg', 1),
(29, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. VŨ VĂN THIỆU', 'https://soict.hust.edu.vn/wp-content/uploads/2019/06/DHP_5332-400x599.jpg', 1),
(30, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'PGS.TS. CAO TUẤN DŨNG', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/DHP_5196-400x599.jpg', 1),
(31, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'PGS.TS. LÊ THANH HƯƠNG', 'https://soict.hust.edu.vn/wp-content/uploads/2018/01/DHP_5523-400x599.jpg', 1),
(32, '2023-12-11 11:54:00.893414', '2023-12-11 11:54:00.893414', 'TS. TRẦN VĨNH ĐỨC', 'https://soict.hust.edu.vn/wp-content/uploads/2017/03/000379-400x599.jpg', 1);

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
(2, '2023-12-11 11:50:11.400382', '2023-12-11 11:50:11.400382', 'Khoa Điện tử viễn thông', 'ĐTVT'),
(5, '2024-01-02 16:00:48.739177', '2024-01-02 16:00:48.739177', 'Khoa Lý luận chính trị', 'LLCT'),
(6, '2024-01-02 16:00:49.007166', '2024-01-02 16:00:49.007166', 'Khoa Giáo dục quốc phòng', 'GDQP'),
(7, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Viện Cơ khí', 'Cơ khí'),
(8, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Viện Cơ khí Động lực', 'Cơ khí động lực'),
(9, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Viện Ngoại ngữ', 'Ngôn ngữ'),
(10, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Viện Kinh tế và Quản lý', 'Kinh tế'),
(11, '2023-12-11 11:49:49.343896', '2023-12-11 11:49:49.343896', 'Viện Toán ứng dụng và Tin học', 'Toán tin'),
(12, '2024-01-03 00:00:00.000000', '2024-01-03 00:00:00.000000', 'Viện Điện tử - Viễn thông	', 'Viện Điện tử - Viễn thông	'),
(14, '2024-01-03 00:00:00.000000', '2024-01-03 00:00:00.000000', 'Viện Công nghệ Sinh học và Công nghệ Thực phẩm	', 'Viện Công nghệ Sinh học và Công nghệ Thực phẩm	');

-- --------------------------------------------------------

--
-- Table structure for table `semester_entity`
--

CREATE TABLE `semester_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `semester_entity`
--

INSERT INTO `semester_entity` (`id`, `createdAt`, `updatedAt`, `name`) VALUES
(1, '2024-01-02 15:26:21.123812', '2024-01-02 15:26:21.123812', '20221'),
(2, '2024-01-02 15:26:38.701345', '2024-01-02 15:26:38.701345', '20222'),
(3, '2024-01-03 03:37:21.671000', '2024-01-03 03:37:21.671000', '20223'),
(4, '2024-01-03 03:37:21.671000', '2024-01-03 03:37:21.671000', '20231'),
(5, '2024-01-03 03:37:21.671000', '2024-01-03 03:37:21.671000', '20232'),
(6, '2024-01-02 03:57:53.039644', '2024-01-02 03:57:53.039644', '20213'),
(7, '2024-01-02 03:57:53.039644', '2024-01-02 03:57:53.039644', '20203'),
(8, '2024-01-02 03:57:56.889038', '2024-01-02 03:57:56.889038', '20202'),
(9, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20201'),
(10, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20191'),
(11, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20192'),
(12, '2024-01-02 03:57:53.039644', '2024-01-02 03:57:53.039644', '20193'),
(13, '2024-01-02 03:57:53.039644', '2024-01-02 03:57:53.039644', '20183'),
(14, '2024-01-02 03:57:56.889038', '2024-01-02 03:57:56.889038', '20182'),
(15, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20181'),
(16, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20173'),
(17, '2024-01-02 03:58:00.118765', '2024-01-02 03:58:00.118765', '20172'),
(18, '2024-01-02 03:57:53.039644', '2024-01-02 03:57:53.039644', '20171');

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
(1, '2023-12-11 12:09:43.991871', '2023-12-11 12:09:43.991871', 'Lập trình hướng đối tượng', 'OOP', 1),
(2, '2024-01-03 03:43:12.562000', '2024-01-03 03:43:12.562000', 'Triết học Mác - Lênin	', 'SSH1111	', 5),
(3, '2024-01-03 03:43:12.562000', '2024-01-03 03:43:12.562000', 'Kinh tế chính trị Mác - Lênin	', 'SSH1121', 5),
(4, '2024-01-03 03:43:12.562000', '2024-01-03 03:43:12.562000', 'Chủ nghĩa xã hội khoa học	', 'SSH1131	', 5),
(5, '2024-01-03 03:43:12.562000', '2024-01-03 03:43:12.562000', 'Lịch sử Đảng cộng sản Việt Nam	', 'SSH1141	', 5),
(6, '2024-01-03 03:43:12.562000', '2024-01-03 03:43:12.562000', 'Tư tưởng Hồ Chí Minh	', 'SSH1151	', 5),
(7, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Lập trình C cơ bản	', 'IT3230', 1),
(8, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Lập trình C (nâng cao)	', 'IT3240', 1),
(9, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Đạo đức máy tính	', 'IT3250', 1),
(10, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Lý thuyết mạch logic	', 'IT3260	', 1),
(11, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Thực hành mạch logic	', 'IT3270', 1),
(12, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Thực hành kiến trúc máy tính	', 'IT3280', 1),
(13, '2024-01-03 03:45:16.295000', '2024-01-03 03:45:16.295000', 'Đồ án tốt nghiệp ', 'IT4125', 1);

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
(1, '2023-12-10 11:08:58.930672', '2023-12-10 11:45:06.843171', 'admin@gmail.com', 'Admin Chavis', '$2a$10$vM1eUsvuusdnbmefD1e7wuy8MIcp/3RLReLSGPC0rGN/Tov4.QORy', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'admin'),
(2, '2023-12-10 11:45:26.969016', '2023-12-10 11:45:26.969016', 'dungg.nm@gmail.com', 'Dung Nguyen Minh', '$2a$10$v.lit3gT/9Q0mIBVSMHR1ukUpCFNKE5FwWf16zIq.VccaOwLTCn3O', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO7jIuCSwjKtT8HcuxYlET-uBRpexLEJfqyCx8fnxtEw&s', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `user_react_document_entity`
--

CREATE TABLE `user_react_document_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `vote` tinyint NOT NULL,
  `authorId` int DEFAULT NULL,
  `documentId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_react_document_entity`
--

INSERT INTO `user_react_document_entity` (`id`, `createdAt`, `updatedAt`, `vote`, `authorId`, `documentId`) VALUES
(2, '2024-01-02 16:00:26.723836', '2024-01-02 16:00:26.723836', 1, 2, 13),
(3, '2024-01-02 16:00:51.754301', '2024-01-02 16:02:11.000000', 1, 2, 15),
(4, '2024-01-02 16:01:47.357913', '2024-01-02 16:01:47.357913', 1, 2, 14),
(7, '2024-01-03 03:51:21.430513', '2024-01-03 03:51:31.000000', 0, 1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `user_view_document_entity`
--

CREATE TABLE `user_view_document_entity` (
  `id` int NOT NULL,
  `createdAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `documentId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `view_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_view_document_entity`
--

INSERT INTO `user_view_document_entity` (`id`, `createdAt`, `updatedAt`, `documentId`, `userId`, `view_at`) VALUES
(4, '2024-01-02 15:28:51.455996', '2024-01-02 16:09:30.000000', 13, 2, '2024-01-02 16:09:30'),
(5, '2024-01-02 15:34:35.806824', '2024-01-02 16:09:20.000000', 14, 2, '2024-01-02 16:09:20'),
(6, '2024-01-02 15:41:38.698337', '2024-01-03 06:21:04.000000', 15, 2, '2024-01-03 06:21:05'),
(7, '2024-01-03 03:32:30.754663', '2024-01-03 03:54:06.000000', 13, 1, '2024-01-03 03:54:06'),
(8, '2024-01-03 03:32:38.267683', '2024-01-03 03:51:13.000000', 15, 1, '2024-01-03 03:51:14'),
(9, '2024-01-03 03:45:02.488510', '2024-01-03 03:52:29.000000', 14, 1, '2024-01-03 03:52:30'),
(10, '2024-01-03 04:19:28.149922', '2024-01-03 04:19:28.000000', 17, 1, '2024-01-03 04:19:28'),
(11, '2024-01-03 04:27:48.403057', '2024-01-03 04:27:48.000000', 26, 1, '2024-01-03 04:27:49'),
(12, '2024-01-03 05:43:46.748679', '2024-01-03 06:20:24.000000', 26, 2, '2024-01-03 06:20:25'),
(13, '2024-01-03 06:20:39.090619', '2024-01-03 06:20:39.090619', 25, 2, '2024-01-03 06:20:39');

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
  ADD KEY `FK_318121d98f78517a8c1ab575844` (`subjectId`),
  ADD KEY `FK_6bca3f21ac5e6dbddc905962f66` (`semesterId`);

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
-- Indexes for table `file_entity`
--
ALTER TABLE `file_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_e6916cdf804b3af3ba2ef2d3f0` (`url`),
  ADD KEY `FK_0302d71c7fb712a2681105f92fe` (`documentId`);

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
-- Indexes for table `semester_entity`
--
ALTER TABLE `semester_entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `IDX_0e6eacf120c6612663981fb430` (`name`);

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
-- Indexes for table `user_react_document_entity`
--
ALTER TABLE `user_react_document_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_2f32121caddeb4040dc81b5165c` (`authorId`),
  ADD KEY `FK_2d821de0b4b6730b02142384c18` (`documentId`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `comment_entity`
--
ALTER TABLE `comment_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `document_entity`
--
ALTER TABLE `document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `file_entity`
--
ALTER TABLE `file_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `lecturer_entity`
--
ALTER TABLE `lecturer_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `school_entity`
--
ALTER TABLE `school_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `semester_entity`
--
ALTER TABLE `semester_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `subject_entity`
--
ALTER TABLE `subject_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user_model`
--
ALTER TABLE `user_model`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_react_document_entity`
--
ALTER TABLE `user_react_document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_view_document_entity`
--
ALTER TABLE `user_view_document_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

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
  ADD CONSTRAINT `FK_6bca3f21ac5e6dbddc905962f66` FOREIGN KEY (`semesterId`) REFERENCES `semester_entity` (`id`),
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
-- Constraints for table `file_entity`
--
ALTER TABLE `file_entity`
  ADD CONSTRAINT `FK_0302d71c7fb712a2681105f92fe` FOREIGN KEY (`documentId`) REFERENCES `document_entity` (`id`);

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
-- Constraints for table `user_react_document_entity`
--
ALTER TABLE `user_react_document_entity`
  ADD CONSTRAINT `FK_2d821de0b4b6730b02142384c18` FOREIGN KEY (`documentId`) REFERENCES `document_entity` (`id`),
  ADD CONSTRAINT `FK_2f32121caddeb4040dc81b5165c` FOREIGN KEY (`authorId`) REFERENCES `user_model` (`id`);

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
