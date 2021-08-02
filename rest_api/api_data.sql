-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 02, 2021 at 08:04 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `api_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `node`
--

CREATE TABLE `node` (
  `nodeId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT -1,
  `nodeTitle` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `node`
--

INSERT INTO `node` (`nodeId`, `parentId`, `nodeTitle`) VALUES
(58, 0, '   '),
(59, -1, '  Conference planning '),
(60, 0, '   '),
(61, 59, '  Goals '),
(62, 0, '   '),
(63, 59, '  Participants '),
(64, 0, '   '),
(65, 59, '  Lectures '),
(66, 0, '   '),
(67, 59, '  Arrangement '),
(68, 0, '   '),
(69, 59, '  Documents '),
(70, 0, '   '),
(71, 59, '  Arrival '),
(72, 0, '   '),
(73, 61, '  Exchange of information '),
(74, 0, '   '),
(75, 61, '  Finding the descision '),
(76, 0, '   '),
(77, 61, '  Solving The confict '),
(78, 0, '   '),
(79, 61, '  Exchange of knowledge '),
(80, 0, '   '),
(81, 67, '  Rooms '),
(82, 0, '   '),
(83, 67, '  premises ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `node`
--
ALTER TABLE `node`
  ADD PRIMARY KEY (`nodeId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `node`
--
ALTER TABLE `node`
  MODIFY `nodeId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
