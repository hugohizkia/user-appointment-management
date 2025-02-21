-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2025 at 06:18 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uams_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `title`, `creator_id`, `start`, `end`, `created_at`, `updated_at`) VALUES
(1, 'coba saja', 1, '2025-02-20 21:46:50', '2025-02-21 21:46:50', '2025-02-19 21:47:12', '2025-02-19 21:47:12'),
(2, 'BOOOOMMMM', 1, '2025-02-22 09:00:00', '2025-02-22 10:00:00', '2025-02-20 09:39:12', '2025-02-20 10:57:18'),
(3, 'SGP MEETING', 5, '2025-02-25 10:00:00', '2025-02-25 14:00:00', '2025-02-20 18:24:14', '2025-02-20 18:24:14'),
(4, 'TEST 1', 1, '2025-02-28 16:00:00', '2025-02-28 17:00:00', '2025-02-21 04:47:36', '2025-02-21 04:47:36'),
(5, 'AMERICA', 1, '2025-02-23 22:00:00', '2025-02-23 23:00:00', '2025-02-21 04:54:22', '2025-02-21 04:57:01'),
(6, 'IT Metting', 7, '2025-02-21 16:00:00', '2025-02-21 17:00:00', '2025-02-21 05:00:01', '2025-02-21 05:02:07');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_users`
--

CREATE TABLE `appointment_users` (
  `appointment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_users`
--

INSERT INTO `appointment_users` (`appointment_id`, `user_id`) VALUES
(2, 3),
(2, 6),
(3, 1),
(3, 3),
(5, 2),
(5, 4),
(6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `preferred_timezone` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `preferred_timezone`, `created_at`, `updated_at`) VALUES
(1, 'Hugo Hizkia', 'hugohizkiah', 'Asia/Jakarta', '2025-02-19 07:14:41', '2025-02-19 07:14:41'),
(2, 'NYC', 'admin', 'America/New_York', '2025-02-20 03:05:45', '2025-02-21 04:55:05'),
(3, 'andree', 'andre', 'Asia/Jakarta', '2025-02-20 03:06:16', '2025-02-20 03:06:16'),
(4, 'Chicago', 'vicky', 'America/Chicago', '2025-02-20 03:42:06', '2025-02-21 04:54:57'),
(5, 'sgp', 'sgp', 'Asia/Singapore', '2025-02-20 03:42:54', '2025-02-20 03:42:54'),
(6, 'Honolulu', 'Honolulu', 'Pacific/Honolulu', '2025-02-20 03:56:39', '2025-02-20 03:56:39'),
(7, 'contoh', 'contoh123', 'Asia/Jakarta', '2025-02-20 21:59:13', '2025-02-20 21:59:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`);

--
-- Indexes for table `appointment_users`
--
ALTER TABLE `appointment_users`
  ADD PRIMARY KEY (`appointment_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `appointment_users`
--
ALTER TABLE `appointment_users`
  ADD CONSTRAINT `appointment_users_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `appointment_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
