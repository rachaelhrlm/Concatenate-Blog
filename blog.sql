-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2020 at 10:11 PM
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
CREATE DATABASE IF NOT EXISTS `blog` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `blog`;

-- --------------------------------------------------------

--
-- Table structure for table `accesslevel`
--

CREATE TABLE `accesslevel` (
  `accessLevelID` int(11) NOT NULL,
  `accessLevel` varchar(100) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `accesslevel`
--

INSERT INTO `accesslevel` (`accessLevelID`, `accessLevel`) VALUES
(1, 'Admin'),
(2, 'Blogger'),
(3, 'Member');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryID` int(11) NOT NULL,
  `category` varchar(100) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryID`, `category`) VALUES
(1, 'Lifestyle'),
(2, 'Resources'),
(3, 'Career'),
(4, 'Events');

-- --------------------------------------------------------

--
-- Table structure for table `gender`
--

CREATE TABLE `gender` (
  `genderID` int(11) NOT NULL,
  `gender` varchar(100) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`genderID`, `gender`) VALUES
(1, 'Female'),
(2, 'Male'),
(3, 'Non-Binary'),
(4, 'Unspecified');

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `memberID` int(11) NOT NULL,
  `userName` varchar(100) COLLATE latin1_general_ci NOT NULL UNIQUE,
  `passwords` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL UNIQUE,
  `accessLevel` int(100) NOT NULL DEFAULT '3',
  `firstName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `lastName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `gender` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`memberID`, `userName`, `passwords`, `email`, `accessLevel`, `firstName`, `lastName`, `gender`) VALUES
(1, 'theoriginal', 'K!ttyCat123', 'theoriginal@wow.com', 2, 'Mary', 'Sue', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `postID` int(11) NOT NULL,
  `memberID` int(100) NOT NULL,
  `title` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `category` int(11) NOT NULL,
  `datePosted` date NOT NULL,
  `dateUpdated` date DEFAULT NULL,
  `excerpt` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`postID`, `memberID`, `title`, `category`, `datePosted`, `dateUpdated`, `excerpt`) VALUES
(1, 1, 'To Code or Not to Code', 1, '2020-05-16', NULL, 'American bobtail bengal siamese');

-- --------------------------------------------------------

--
-- Table structure for table `subscriber`
--

CREATE TABLE `subscriber` (
  `subscriberID` int(11) NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `activity` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `surveyID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `ageRange` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `sexualOrientationID` int(11) DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `operatingSystem` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `programmingLanguage` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `optOut` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesslevel`
--
ALTER TABLE `accesslevel`
  ADD PRIMARY KEY (`accessLevelID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`genderID`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`memberID`),
  ADD KEY `accessLevel` (`accessLevel`),
  ADD KEY `gender` (`gender`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`postID`),
  ADD KEY `memberID` (`memberID`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `subscriber`
--
ALTER TABLE `subscriber`
  ADD PRIMARY KEY (`subscriberID`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`surveyID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesslevel`
--
ALTER TABLE `accesslevel`
  MODIFY `accessLevelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `gender`
--
ALTER TABLE `gender`
  MODIFY `genderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `member`
--
ALTER TABLE `member`
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `postID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `subscriber`
--
ALTER TABLE `subscriber`
  MODIFY `subscriberID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`accessLevel`) REFERENCES `accesslevel` (`accessLevelID`),
  ADD CONSTRAINT `member_ibfk_2` FOREIGN KEY (`gender`) REFERENCES `gender` (`genderID`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`),
  ADD CONSTRAINT `post_ibfk_2` FOREIGN KEY (`category`) REFERENCES `category` (`categoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
