-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2026 at 03:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edu_game`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `option_a` varchar(100) DEFAULT NULL,
  `option_b` varchar(100) DEFAULT NULL,
  `option_c` varchar(100) DEFAULT NULL,
  `option_d` varchar(100) DEFAULT NULL,
  `correct_answer` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `room_id`, `question`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`) VALUES
(12, 11, 'what color is an apple', 'red', 'green', 'blue', 'orange', 'A'),
(13, 30, 'spell red', 'lster', 'r e d', 'd i c k', 'p u s s y', 'B'),
(14, 32, 'asedf', 'asdf', 'asdf', 'asdf', 'asdf', 'A'),
(15, 34, 'fasdfasdf', 'asdfas', 'asdfa', 'asdf', 'asdf', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_code` varchar(10) DEFAULT NULL,
  `teacher_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_code`, `teacher_name`) VALUES
(11, '31YBZ', 'luke'),
(12, 'XY2C1', ''),
(13, 'C2XAY', ''),
(14, 'XB23A', ''),
(15, '1B3CY', ''),
(16, '31BAZ', ''),
(17, 'C13AX', ''),
(18, 'C2AY3', ''),
(19, 'YZ23B', ''),
(20, '2XA1Y', ''),
(21, '1YA2C', ''),
(22, '2XCBY', ''),
(23, 'A32ZB', ''),
(24, '2YA1X', ''),
(25, '3Z2YA', ''),
(26, 'C13YB', ''),
(27, 'XA13B', ''),
(28, 'C1X23', ''),
(29, 'BA213', ''),
(30, 'ABZ31', ''),
(35, 'YAB1Z', ''),
(36, '12YA3', ''),
(37, 'AYCBX', ''),
(38, 'CZ2Y3', ''),
(39, 'CXZ31', ''),
(40, 'Z23AY', ''),
(41, 'A13Z2', ''),
(42, 'Y1C2X', ''),
(43, 'ACBXZ', ''),
(44, 'CX231', ''),
(45, '1YXC3', ''),
(46, 'YZ2CX', ''),
(47, '1B3ZY', ''),
(48, '13CZX', ''),
(49, '12ZX3', ''),
(50, '3Z2AC', ''),
(51, 'A3X2C', ''),
(52, 'Bf2CA', ''),
(53, '3Y2CB', ''),
(54, 'fadXs', ''),
(55, 'B2Y3a', ''),
(56, 'aCdAs', ''),
(57, 'Y3Z1B', '');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `room_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `room_id`, `name`, `score`) VALUES
(10, 11, 'matt', 0),
(11, 32, 'lester', 0),
(12, 34, 'afsdf', 0),
(13, 34, 'asdf', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'jonathan', '$2y$10$7XAL7CzsWA.i/94dVNWq.OqwJ/CS5uYQlSkJa/jTFMqXVNCN32nLi');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
