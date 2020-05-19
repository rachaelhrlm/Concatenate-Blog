-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2020 at 08:32 AM
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
  `userName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `passwords` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `accessLevel` int(100) NOT NULL DEFAULT '3',
  `firstName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `lastName` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `gender` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`memberID`, `userName`, `passwords`, `email`, `accessLevel`, `firstName`, `lastName`, `gender`) VALUES
(1, 'theoriginal', 'K!ttyCat123', 'theoriginal@wow.com', 2, 'Mary', 'Sue', 1),
(2, 'ladyluck', 'M!55F0rtun3', 'samanthab@yahoo.com', 3, 'Samantha', 'Brookes', 1),
(3, 'KittyKate', 'M30wPurr', 'kitty.meow@gmail.com', 3, 'Kate', 'Smith', 1),
(4, 'DangerDan', 'Ar53n@l', 'dan.gerous@wow.com', 3, 'Dan', 'Vicious', 2),
(5, 'test', 'Password', 'test@test.com', 1, 'Test', 'User', 1);

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
  `excerpt` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `content` longtext COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`postID`, `memberID`, `title`, `category`, `datePosted`, `dateUpdated`, `excerpt`, `content`) VALUES
(1, 1, 'To Code or Not to Code', 1, '2020-05-16', NULL, 'American bobtail bengal siamese', 'British shorthair persian, yet bobcat british shorthair russian blue american shorthair. Ocelot british shorthair birman but tom tomcat. Singapura bombay lynx russian blue himalayan for russian blue. Lion kitty. Panther jaguar. Tom sphynx tabby and cougar scottish fold manx lynx. Thai american shorthair manx so sphynx singapura sphynx havana brown. Bombay lion or tomcat and malkin. Cougar. Panther kitty, so sphynx puma. Cheetah norwegian forest tabby yet scottish fold ocelot. Lynx. Puma tiger so donskoy. Burmese russian blue burmese abyssinian abyssinian burmese puma. British shorthair puma manx yet bobcat or savannah, himalayan, yet maine coon.  American shorthair puma, burmese or scottish fold but lion. Lynx balinese scottish fold tiger for singapura. Grimalkin himalayan siamese. Grimalkin tiger. Bombay ocicat or donskoy maine coon, or cheetah and havana brown so norwegian forest. American bobtail havana brown for manx jaguar mouser. Himalayan american bobtail havana brown. Savannah burmese himalayan yet abyssinian abyssinian but ocelot maine coon. Burmese burmese but puma. Sphynx american bobtail yet cheetah yet puma. Russian blue. Leopard mouser abyssinian lion and tiger. Scottish fold tabby or cougar, yet abyssinian . American shorthair. Abyssinian puma yet tiger kitty siberian. Tiger devonshire rex but manx tabby or norwegian forest or singapura yet sphynx. Norwegian forest american shorthair, puma. Savannah. Ocicat. Cheetah munchkin lion ocelot, or kitty so birman. Malkin cornish rex. Cheetah ocicat. Kitty balinese .  Kitten cheetah malkin, so cougar. Kitty puma, but ocicat. Himalayan savannah and ocicat bobcat. Munchkin puma scottish fold havana brown so cougar for siberian but persian. Kitty cornish rex, leopard for lynx and ocicat. Bombay thai ragdoll burmese cheetah but thai. Jaguar russian blue jaguar so egyptian mau. Cheetah british shorthair. Savannah maine coon. Russian blue norwegian forest, ocelot jaguar, but tom. Maine coon norwegian forest russian blue lion yet cheetah. Russian blue mouser jaguar american bobtail burmese. Ocicat abyssinian but siberian bengal cougar balinese . Ocelot lynx. Bombay tom american shorthair for puma. Lion burmese for cougar leopard. Donskoy havana brown, norwegian forest for jaguar bengal. Leopard. Norwegian forest. Ocicat. Panther bobcat yet tiger norwegian forest and lion.'),
(2, 1, 'Cougar maine coon', 2, '2020-05-19', NULL, 'Mouser thai thai', 'Norwegian forest. American shorthair lynx yet kitty. Cougar bengal bombay. Himalayan. Jaguar tiger grimalkin but russian blue or kitty. Persian siamese for turkish angora so american bobtail. Kitten abyssinian and lynx grimalkin. Bombay.\r\n\r\nGrimalkin norwegian forest for munchkin for tomcat puma cougar munchkin. Panther bengal. Birman thai but munchkin. Tiger havana brown or egyptian mau, ragdoll bobcat. Birman cornish rex, or tabby mouser havana brown yet panther yet himalayan. Manx russian blue. Himalayan ocicat cornish rex, american shorthair and havana brown singapura or abyssinian . Donskoy siamese for donskoy. Sphynx savannah donskoy.\r\n\r\nThai tom but singapura for donskoy yet jaguar tiger. Mouser russian blue manx but egyptian mau. Sphynx. Thai kitty and mouser yet turkish angora burmese for malkin. Siamese ragdoll british shorthair but norwegian forest. Panther ocelot but american bobtail yet maine coon. Balinese lynx donskoy. Puma cornish rex. Abyssinian bombay, norwegian forest panther. Leopard mouser but balinese . Ocicat singapura. Savannah birman so tomcat. Norwegian forest ocicat puma. Singapura puma lion but malkin, tiger yet thai. Persian mouser maine coon cougar so singapura. Thai. Manx grimalkin and kitten. Ragdoll savannah yet egyptian mau british shorthair leopard. Manx ocelot siamese bobcat malkin malkin. Abyssinian kitten tiger so tabby for siamese or mouser or tomcat. Cheetah scottish fold and mouser american bobtail yet donskoy lynx. Jaguar ragdoll for thai british shorthair, abyssinian for manx. Havana brown lion ragdoll cougar for puma. Abyssinian british shorthair. Abyssinian panther savannah.'),
(3, 1, 'Cornish rex', 3, '2020-05-19', NULL, 'Tomcat savannah jaguar', 'Balinese bengal. Cornish rex leopard for lynx munchkin and manx havana brown. British shorthair. Maine coon leopard so russian blue. Scottish fold manx. Himalayan. American shorthair kitty. Malkin. Siamese maine coon. Bombay. Kitty mouser, so scottish fold. American bobtail. Tomcat cheetah but cougar. Sphynx savannah for mouser so cheetah yet siberian american shorthair himalayan. Bombay abyssinian or maine coon. Turkish angora singapura. Singapura.\r\n\r\nAmerican shorthair siberian. Persian lion. Bengal tiger mouser kitten or lynx bobcat for tabby. Persian leopard. Grimalkin abyssinian sphynx. Bobcat.\r\n\r\nMaine coon munchkin cougar for himalayan puma thai siamese. Sphynx thai for leopard. American bobtail birman munchkin bengal british shorthair cornish rex russian blue. Donskoy tomcat donskoy. Scottish fold egyptian mau for munchkin but devonshire rex. Russian blue donskoy so lynx but bobcat. Cornish rex malkin. British shorthair cougar egyptian mau, yet norwegian forest, and ragdoll ocicat. Turkish angora ocicat or lion british shorthair. American shorthair turkish angora so ragdoll for ocicat. Grimalkin norwegian forest. Siamese lion burmese but american shorthair for singapura siberian but jaguar. Egyptian mau russian blue for russian blue sphynx grimalkin yet lynx for kitten. Grimalkin tom, turkish angora. Siamese ocicat cheetah egyptian mau or puma so siamese. Cornish rex havana brown tabby bombay yet mouser so donskoy norwegian forest. Cougar. Siberian kitten. Ragdoll panther, panther. Lion devonshire rex. Devonshire rex tomcat and munchkin, sphynx, sphynx, yet thai so tomcat.'),
(4, 1, 'Panther sphynx thai', 3, '2020-05-19', NULL, 'Manx himalayan', 'Turkish angora american bobtail cougar turkish angora. Havana brown siberian so scottish fold so bobcat and persian. Lion panther. American bobtail cougar singapura cougar or russian blue, devonshire rex singapura. Maine coon. Panther singapura tomcat himalayan american bobtail for bombay. Tiger devonshire rex savannah ocicat yet devonshire rex but cougar. Singapura abyssinian for ragdoll or jaguar or bombay. Tomcat. Lynx lynx ocicat egyptian mau persian cornish rex so donskoy. Tomcat panther cornish rex malkin savannah. Cougar maine coon so cheetah british shorthair. Panther russian blue, puma so lion and lion and turkish angora. British shorthair bombay yet bombay. Havana brown burmese yet grimalkin puma cornish rex american bobtail. Thai abyssinian burmese so jaguar or jaguar himalayan norwegian forest. Sphynx bengal for malkin. Sphynx kitty american shorthair and bengal, sphynx. Mouser cheetah singapura. Grimalkin ocicat burmese.\r\n\r\nJaguar ocelot ocicat for grimalkin. Ocicat siberian or birman thai for mouser, or scottish fold. Bengal mouser yet burmese but tabby devonshire rex american shorthair but tom. Ocelot abyssinian ragdoll bobcat norwegian forest. Cornish rex bengal for russian blue. Ragdoll bengal siberian. Lynx munchkin. Abyssinian balinese for bobcat kitten, so kitty but birman devonshire rex. Cheetah russian blue. Maine coon jaguar lion but havana brown, himalayan. Tiger. Bobcat cheetah. Siamese ragdoll ocicat. Jaguar persian. Thai burmese, thai. American bobtail burmese. Persian. Malkin munchkin yet mouser. Thai birman himalayan malkin or kitten savannah, but singapura. Tiger leopard for tom for malkin for himalayan bombay, or balinese .\r\n\r\nManx siamese. Savannah mouser tomcat for singapura but kitten siamese. Norwegian forest turkish angora but turkish angora, but cheetah yet american shorthair so russian blue. Tiger siberian. British shorthair. Havana brown. Ocicat turkish angora or cornish rex, tom cornish rex. Ocicat malkin singapura kitten or abyssinian or munchkin for himalayan. Leopard american bobtail manx and birman panther, yet bengal tiger. Leopard donskoy turkish angora, or scottish fold for lynx american bobtail but turkish angora. Cornish rex. Bobcat maine coon russian blue. Bengal egyptian mau, tiger, and scottish fold bengal, or bengal. Turkish angora kitty. Scottish fold tabby so puma burmese. American bobtail egyptian mau manx so british shorthair. Bengal lion for bengal yet tom balinese egyptian mau.'),
(5, 1, 'Manx norwegian forest', 1, '2020-05-19', NULL, 'Kitty mouser', 'Tom panther, for tom american bobtail. Tomcat persian cougar cougar siberian so tom. Donskoy savannah turkish angora but american bobtail. Maine coon donskoy cornish rex mouser. Donskoy british shorthair. Siamese ragdoll but manx but singapura. Bombay donskoy yet savannah so tabby. Grimalkin. Birman egyptian mau or malkin for bengal ragdoll himalayan savannah. Abyssinian norwegian forest. Devonshire rex american shorthair for persian but british shorthair. Turkish angora siamese cougar siberian kitten and burmese cheetah. Munchkin russian blue for persian lion, yet egyptian mau, but tom. Siamese russian blue. Tom american shorthair but kitty. Turkish angora.\r\n\r\nMouser mouser leopard cornish rex. Singapura turkish angora. Norwegian forest tiger donskoy cornish rex burmese burmese. Cheetah. Himalayan panther but american shorthair, munchkin, russian blue. Ragdoll. Persian tiger so mouser savannah. Egyptian mau american shorthair. Singapura ocicat for siberian, but kitten. Savannah tom scottish fold and ocicat norwegian forest and turkish angora, jaguar. Malkin malkin for cornish rex bengal. Leopard. Birman bengal for tiger. Panther. Kitty havana brown but cornish rex or burmese bombay tom. Malkin birman but havana brown yet cougar. Turkish angora donskoy or ragdoll.\r\n\r\nAbyssinian maine coon yet mouser yet tom singapura or ragdoll or bobcat. Jaguar siberian, jaguar. Ocicat puma or manx. Sphynx. Sphynx thai maine coon lion yet persian sphynx, but donskoy. Himalayan american bobtail yet kitten. Cheetah panther but kitten so maine coon for grimalkin and manx. Lion birman yet devonshire rex so havana brown lion or devonshire rex but panther. Savannah tom. Mouser russian blue himalayan and siamese. Thai siberian so havana brown. Maine coon thai havana brown yet manx bengal so himalayan.');

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
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `email` (`email`),
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
  MODIFY `memberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `postID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
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
