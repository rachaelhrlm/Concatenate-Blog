-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2020 at 07:19 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.0.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `memberID` int(11) NOT NULL,
  `userName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `passwords` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `accessLevelID` int(100) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`memberID`, `userName`, `passwords`, `email`, `accessLevelID`) VALUES
(1, 'theoriginal', '$2y$10$y8/KC/RoDjAcYjMn1IdP8uD4ptibujA1d0N7Km/spxh7kiEVOZVNS', 'kittycat@wow.com', 2),
(2, 'ladyluck', '$2y$10$FWs2F5FxOJCW2q6vKm0YX.tGf5DDUIGliLefjBse66JQ2tAn/WUdK', 'samanthab@yahoo.com', 3),
(3, 'KittyKate', '$2y$10$2c2pct2/MaflCZIgKeDQ7.K.20URD8zyvUlaAbdlJqOQRzmY96vo6', 'kitty.meow@gmail.com', 4),
(4, 'DangerDan', '$2y$10$1vr13/0YeyzGmePWIBBw4u6HLXMb1tJpHiApXkfLJeBzd5/anjMY2', 'dan.gerous@wow.com', 3),
(5, 'test', '$2y$10$mFmtdQApuwsZHB4hxdOUlOjqI.jhjl0JZSwvenCLL2d3H0hyLiWEm', 'test@email.com', 1),
(6, 'mindyLoo', '$2y$10$chN1DJw4/IXvhuBIvrNVLO/K87SxXb9c9w6oQzL8gR8uLk7V2WqDy', 'mindy@loo.com', 3),
(7, 'AllieGator', '$2y$10$.nf5sbgme3SCnriN5rx06OMbwx/ght70QIgM4OZ3Bhn8ieK2G3/wC', 'allie.gator@email.com', 3),
(8, 'rachaelhrlm', '$2y$10$edrkKnDrG6vyWOCBM6.KuOcoth7fH96B2hbkPfYhvVqoDKTdZRXDm', 'rachaelhrm.plays@gmail.com', 4),
(9, 'Sarahjpx', '$2y$10$9L/vElWBmfU6t7lVxlSZNeWYDSvHVeIVRigPMg/.mpdLDHwp/WAEO', 'sarahperrettjpx@gmail.com', 2),
(10, 'TrollMctroller', '$2y$10$Bt0PVBbDYHzg.HCOwVfWsedZrvIQoad3t90K8tGrV8YxGTydCYAHS', 'iamatroll@meow.com', 3),
(11, 'SarahCodes', '$2y$10$ewMVRO7zOw520DkYk93VS.8617Uo63O.zLESk3pMoicPYk/bU3hbq', 'sarahjpx@hotmail.com', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`memberID`),
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `accessLevel` (`accessLevelID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`accessLevelID`) REFERENCES `accesslevel` (`accessLevelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
