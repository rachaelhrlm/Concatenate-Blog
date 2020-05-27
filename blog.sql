-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2020 at 06:51 PM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createPost` (IN `newMemberID` INT(11), IN `newTitle` VARCHAR(100), IN `newCategoryID` INT(11), IN `newExcerpt` VARCHAR(100), IN `newContent` LONGTEXT)  BEGIN
	INSERT INTO post (memberID, title, categoryID, datePosted, excerpt, content)
	VALUES (newMemberID, newTitle, newCategoryID, CURDATE(), newExcerpt, newContent);

	SELECT postID
	FROM post
	ORDER BY postID DESC LIMIT 1;
	
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editPost` (IN `chosenPostID` INT(11), IN `newTitle` VARCHAR(100), IN `newCategoryID` INT(11), IN `newExcerpt` VARCHAR(255), IN `newContent` LONGTEXT)  BEGIN
UPDATE post
SET title = newTitle,  categoryID = newCategoryID, dateUpdated=CURDATE(), excerpt = newExcerpt, content = newContent
WHERE postID = chosenPostID;
                
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchComment` (IN `ChosenPostID` INT(11))  BEGIN
SELECT 
	username,
    postcomment.memberID,
    name,
    message,
    dateCommented  
FROM postcomment
	INNER JOIN member 
	ON postcomment.memberID = member.memberID
    INNER JOIN bio
    on postcomment.memberID = bio.memberID
WHERE 
    postID = chosenPostID
    
    ORDER BY commentID ASC;
                   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `searchPost` (IN `keyword` VARCHAR(100))  BEGIN
SELECT *
FROM postinfo
WHERE 
	visibility = 1 AND 
    (title LIKE concat('%',keyword,'%') OR
    author LIKE concat('%',keyword,'%') OR
    category LIKE concat('%',keyword,'%') OR
    excerpt LIKE concat('%',keyword,'%') OR
	content LIKE concat('%',keyword,'%'))
ORDER BY postID DESC;                   
END$$

DELIMITER ;

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
(3, 'Member'),
(4, 'Inactive');

-- --------------------------------------------------------

--
-- Table structure for table `bio`
--

CREATE TABLE `bio` (
  `bioID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `name` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `about` varchar(200) COLLATE latin1_general_ci DEFAULT 'Proud writer for Concatenate. Loves coding, coffee, and cats. Meow.'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `bio`
--

INSERT INTO `bio` (`bioID`, `memberID`, `name`, `about`) VALUES
(1, 1, 'June Bug', 'Proud writer for Concatenate. Loves coding, coffee, and cats. Meow.'),
(2, 2, 'Jane Doe', 'Proud writer for Concatenate. Loves coding, coffee, and cats. Meow.'),
(3, 3, 'Any Mouse', 'Proud writer for Concatenate. Loves coding, coffee, and cats. Meow.'),
(4, 4, 'Miss Fortune', 'Proud writer for Concatenate. Loves coding, coffee, and cats. Meow.'),
(5, 5, 'Admin', 'I&#39;m the boss. Meow. ');

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
-- Stand-in structure for view `commentview`
-- (See below for the actual view)
--
CREATE TABLE `commentview` (
`postID` int(11)
,`memberID` int(11)
,`author` varchar(100)
,`userName` varchar(100)
,`dateCommented` date
,`message` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `favourite`
--

CREATE TABLE `favourite` (
  `favID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `postID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `favourite`
--

INSERT INTO `favourite` (`favID`, `memberID`, `postID`) VALUES
(8, 5, 10),
(9, 5, 8),
(10, 5, 9),
(12, 1, 11),
(13, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `featuredpost`
--

CREATE TABLE `featuredpost` (
  `featuredPostID` int(11) NOT NULL,
  `postID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `featuredpost`
--

INSERT INTO `featuredpost` (`featuredPostID`, `postID`) VALUES
(1, 6),
(3, 9),
(2, 10);

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
  `accessLevelID` int(100) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`memberID`, `userName`, `passwords`, `email`, `accessLevelID`) VALUES
(1, 'theoriginal', '$2y$10$pz4nx6SaQjR2YT8yx4GDyuYDJaddEVF1O2PsY8cFxzfWFXr6Wy3KW', 'theoriginal@wow.com', 2),
(2, 'ladyluck', '$2y$10$FWs2F5FxOJCW2q6vKm0YX.tGf5DDUIGliLefjBse66JQ2tAn/WUdK', 'samanthab@yahoo.com', 3),
(3, 'KittyKate', '$2y$10$2c2pct2/MaflCZIgKeDQ7.K.20URD8zyvUlaAbdlJqOQRzmY96vo6', 'kitty.meow@gmail.com', 3),
(4, 'DangerDan', '$2y$10$1vr13/0YeyzGmePWIBBw4u6HLXMb1tJpHiApXkfLJeBzd5/anjMY2', 'dan.gerous@wow.com', 3),
(5, 'test', '$2y$10$mFmtdQApuwsZHB4hxdOUlOjqI.jhjl0JZSwvenCLL2d3H0hyLiWEm', 'test@email.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `postID` int(11) NOT NULL,
  `memberID` int(100) NOT NULL,
  `title` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `categoryID` int(11) NOT NULL,
  `datePosted` date NOT NULL,
  `dateUpdated` date DEFAULT NULL,
  `excerpt` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `content` longtext COLLATE latin1_general_ci NOT NULL,
  `visibility` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`postID`, `memberID`, `title`, `categoryID`, `datePosted`, `dateUpdated`, `excerpt`, `content`, `visibility`) VALUES
(1, 1, 'To Code or Not to Code', 1, '2020-05-16', NULL, 'American bobtail bengal siamese', '&#60;h2&#62;British shorthair persian, yet bobcat british shorthair russian blue american shorthair.&#60;/h2&#62;&#60;p&#62;Ocelot british shorthair birman but tom tomcat. Singapura bombay lynx russian blue himalayan for russian blue. Lion kitty. Panther jaguar. Tom sphynx tabby and cougar scottish fold manx lynx. Thai american shorthair manx so sphynx singapura sphynx havana brown. Bombay lion or tomcat and malkin. Cougar. Panther kitty, so sphynx puma. Cheetah norwegian forest tabby yet scottish fold ocelot. Lynx. Puma tiger so donskoy.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Burmese russian blue burmese abyssinian abyssinian burmese puma.&#60;/h2&#62;&#60;p&#62;British shorthair puma manx yet bobcat or savannah, himalayan, yet maine coon. American shorthair puma, burmese or scottish fold but lion. Lynx balinese scottish fold tiger for singapura. Grimalkin himalayan siamese. Grimalkin tiger. Bombay ocicat or donskoy maine coon, or cheetah and havana brown so norwegian forest. American bobtail havana brown for manx jaguar mouser. Himalayan american bobtail havana brown. Savannah burmese himalayan yet abyssinian abyssinian but ocelot maine coon. Burmese burmese but puma. Sphynx american bobtail yet cheetah yet puma. Russian blue. Leopard mouser abyssinian lion and tiger. Scottish fold tabby or cougar, yet abyssinian . American shorthair. Abyssinian puma yet tiger kitty siberian.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Tiger devonshire rex but manx tabby or norwegian forest or singapura yet sphynx.&#60;/h2&#62;&#60;p&#62;Norwegian forest american shorthair, puma. Savannah. Ocicat. Cheetah munchkin lion ocelot, or kitty so birman. Malkin cornish rex. Cheetah ocicat. Kitty balinese . Kitten cheetah malkin, so cougar. Kitty puma, but ocicat. Himalayan savannah and ocicat bobcat. Munchkin puma scottish fold havana brown so cougar for siberian but persian.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Kitty cornish rex, leopard for lynx and ocicat.&#60;/h2&#62;&#60;p&#62;Bombay thai ragdoll burmese cheetah but thai. Jaguar russian blue jaguar so egyptian mau. Cheetah british shorthair. Savannah maine coon. Russian blue norwegian forest, ocelot jaguar, but tom. Maine coon norwegian forest russian blue lion yet cheetah. Russian blue mouser jaguar american bobtail burmese. Ocicat abyssinian but siberian bengal cougar balinese .&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Ocelot lynx.&#60;/h2&#62;&#60;p&#62;Bombay tom american shorthair for puma. Lion burmese for cougar leopard. Donskoy havana brown, norwegian forest for jaguar bengal. Leopard. Norwegian forest. Ocicat. Panther bobcat yet tiger norwegian forest and lion.&#60;/p&#62;', 1),
(2, 1, 'Cougar maine coon', 2, '2020-05-19', NULL, 'Mouser thai thai', '&#60;h2&#62;Norwegian forest.&#60;/h2&#62;&#60;p&#62;American shorthair lynx yet kitty. Cougar bengal bombay. Himalayan. Jaguar tiger grimalkin but russian blue or kitty. Persian siamese for turkish angora so american bobtail. Kitten abyssinian and lynx grimalkin. Bombay.Grimalkin norwegian forest for munchkin for tomcat puma cougar munchkin. Panther bengal. Birman thai but munchkin. Tiger havana brown or egyptian mau, ragdoll bobcat. Birman cornish rex, or tabby mouser havana brown yet panther yet himalayan. Manx russian blue.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#60;img src=&#34;https://images.pexels.com/photos/2653752/pexels-photo-2653752.jpeg?auto=compress&#38;amp;cs=tinysrgb&#38;amp;h=750&#38;amp;w=1260&#34; alt=&#34;Photo of Cat Yawning&#34; /&#62;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Himalayan ocicat cornish rex, american shorthair and havana brown singapura or abyssinian .&#60;/h2&#62;&#60;p&#62;Donskoy siamese for donskoy. Sphynx savannah donskoy.Thai tom but singapura for donskoy yet jaguar tiger. Mouser russian blue manx but egyptian mau. Sphynx. Thai kitty and mouser yet turkish angora burmese for malkin. Siamese ragdoll british shorthair but norwegian forest. Panther ocelot but american bobtail yet maine coon. Balinese lynx donskoy. Puma cornish rex. Abyssinian bombay, norwegian forest panther.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#60;img src=&#34;https://images.pexels.com/photos/57416/cat-sweet-kitty-animals-57416.jpeg?auto=compress&#38;amp;cs=tinysrgb&#38;amp;h=750&#38;amp;w=1260&#34; alt=&#34;Yellow and White Cat&#34; /&#62;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Leopard mouser but balinese .&#60;/h2&#62;&#60;p&#62;Ocicat singapura. Savannah birman so tomcat. Norwegian forest ocicat puma. Singapura puma lion but malkin, tiger yet thai. Persian mouser maine coon cougar so singapura. Thai. Manx grimalkin and kitten. Ragdoll savannah yet egyptian mau british shorthair leopard. Manx ocelot siamese bobcat malkin malkin. Abyssinian kitten tiger so tabby for siamese or mouser or tomcat. Cheetah scottish fold and mouser american bobtail yet donskoy lynx.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#60;img src=&#34;https://images.pexels.com/photos/1331821/cat-eyes-angry-suspicious-1331821.jpeg?auto=compress&#38;amp;cs=tinysrgb&#38;amp;h=750&#38;amp;w=1260&#34; alt=&#34;Closeup Photo of Gray Cat&#34; /&#62;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Jaguar ragdoll for thai british shorthair, abyssinian for manx.&#60;/h2&#62;&#60;p&#62;Havana brown lion ragdoll cougar for puma. Abyssinian british shorthair. Abyssinian panther savannah.&#60;/p&#62;', 1),
(3, 1, 'Cornish rex', 3, '2020-05-19', NULL, 'Tomcat savannah jaguar', '&#60;h2&#62;Balinese bengal.&#60;/h2&#62;&#60;p&#62;Cornish rex leopard for lynx munchkin and manx havana brown. British shorthair. Maine coon leopard so russian blue. Scottish fold manx. Himalayan. American shorthair kitty. Malkin. Siamese maine coon. Bombay. Kitty mouser, so scottish fold. American bobtail. Tomcat cheetah but cougar. Sphynx savannah for mouser so cheetah yet siberian american shorthair himalayan. Bombay abyssinian or maine coon. Turkish angora singapura. Singapura.American shorthair siberian. Persian lion.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#60;img src=&#34;https://images.pexels.com/photos/1440387/pexels-photo-1440387.jpeg?auto=compress&#38;amp;cs=tinysrgb&#38;amp;h=750&#38;amp;w=1260&#34; alt=&#34;Orange Cat Foot on Laptop Keyboard&#34; /&#62;&#60;/p&#62;&#60;h2&#62;&#38;nbsp;&#60;/h2&#62;&#60;h2&#62;Bengal tiger mouser kitten or lynx bobcat for tabby.&#60;/h2&#62;&#60;p&#62;Persian leopard. Grimalkin abyssinian sphynx. Bobcat.Maine coon munchkin cougar for himalayan puma thai siamese. Sphynx thai for leopard. American bobtail birman munchkin bengal british shorthair cornish rex russian blue. Donskoy tomcat donskoy. Scottish fold egyptian mau for munchkin but devonshire rex. Russian blue donskoy so lynx but bobcat. Cornish rex malkin. British shorthair cougar egyptian mau, yet norwegian forest, and ragdoll ocicat. Turkish angora ocicat or lion british shorthair.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;American shorthair turkish angora so ragdoll for ocicat.&#60;/h2&#62;&#60;p&#62;Grimalkin norwegian forest. Siamese lion burmese but american shorthair for singapura siberian but jaguar. Egyptian mau russian blue for russian blue sphynx grimalkin yet lynx for kitten. Grimalkin tom, turkish angora. Siamese ocicat cheetah egyptian mau or puma so siamese. Cornish rex havana brown tabby bombay yet mouser so donskoy norwegian forest.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Cougar.&#60;/h2&#62;&#60;p&#62;Siberian kitten. Ragdoll panther, panther. Lion devonshire rex. Devonshire rex tomcat and munchkin, sphynx, sphynx, yet thai so tomcat.&#60;/p&#62;', 1),
(4, 1, 'Panther sphynx thai', 3, '2020-05-19', NULL, 'Manx himalayan', '&#60;h2&#62;Turkish angora american bobtail cougar turkish angora.&#60;/h2&#62;&#60;p&#62;Havana brown siberian so scottish fold so bobcat and persian. Lion panther. American bobtail cougar singapura cougar or russian blue, devonshire rex singapura. Maine coon. Panther singapura tomcat himalayan american bobtail for bombay. Tiger devonshire rex savannah ocicat yet devonshire rex but cougar. Singapura abyssinian for ragdoll or jaguar or bombay. Tomcat. Lynx lynx ocicat egyptian mau persian cornish rex so donskoy.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;&#38;nbsp;&#60;/h2&#62;&#60;h2&#62;Tomcat panther cornish rex malkin savannah.&#60;/h2&#62;&#60;p&#62;Cougar maine coon so cheetah british shorthair. Panther russian blue, puma so lion and lion and turkish angora. British shorthair bombay yet bombay. Havana brown burmese yet grimalkin puma cornish rex american bobtail. Thai abyssinian burmese so jaguar or jaguar himalayan norwegian forest. Sphynx bengal for malkin. Sphynx kitty american shorthair and bengal, sphynx. Mouser cheetah singapura. Grimalkin ocicat burmese.Jaguar ocelot ocicat for grimalkin. Ocicat siberian or birman thai for mouser, or scottish fold.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Bengal mouser yet burmese but tabby devonshire rex american shorthair but tom.&#60;/h2&#62;&#60;p&#62;Ocelot abyssinian ragdoll bobcat norwegian forest. Cornish rex bengal for russian blue. Ragdoll bengal siberian. Lynx munchkin. Abyssinian balinese for bobcat kitten, so kitty but birman devonshire rex. Cheetah russian blue. Maine coon jaguar lion but havana brown, himalayan. Tiger. Bobcat cheetah. Siamese ragdoll ocicat. Jaguar persian. Thai burmese, thai. American bobtail burmese. Persian. Malkin munchkin yet mouser. Thai birman himalayan malkin or kitten savannah, but singapura. Tiger leopard for tom for malkin for himalayan bombay, or balinese .Manx siamese.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Savannah mouser tomcat for singapura but kitten siamese.&#60;/h2&#62;&#60;p&#62;Norwegian forest turkish angora but turkish angora, but cheetah yet american shorthair so russian blue. Tiger siberian. British shorthair. Havana brown. Ocicat turkish angora or cornish rex, tom cornish rex. Ocicat malkin singapura kitten or abyssinian or munchkin for himalayan. Leopard american bobtail manx and birman panther, yet bengal tiger. Leopard donskoy turkish angora, or scottish fold for lynx american bobtail but turkish angora. Cornish rex. Bobcat maine coon russian blue. Bengal egyptian mau, tiger, and scottish fold bengal, or bengal. Turkish angora kitty. Scottish fold tabby so puma burmese. American bobtail egyptian mau manx so british shorthair. Bengal lion for bengal yet tom balinese egyptian mau.&#60;/p&#62;', 1),
(5, 1, 'Manx', 1, '2020-05-19', '2020-05-23', 'Kitty mouser', '&#60;h2&#62;Tom panther, for tom american bobtail.&#60;/h2&#62;&#60;p&#62;Tomcat persian cougar cougar siberian so tom. Donskoy savannah turkish angora but american bobtail. Maine coon donskoy cornish rex mouser. Donskoy british shorthair. Siamese ragdoll but manx but singapura. Bombay donskoy yet savannah so tabby. Grimalkin. Birman egyptian mau or malkin for bengal ragdoll himalayan savannah. Abyssinian norwegian forest. Devonshire rex american shorthair for persian but british shorthair. Turkish angora siamese cougar siberian kitten and burmese cheetah. Munchkin russian blue for persian lion, yet egyptian mau, but tom.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Siamese russian blue.&#60;/h2&#62;&#60;p&#62;Tom american shorthair but kitty. Turkish angora.Mouser mouser leopard cornish rex. Singapura turkish angora. Norwegian forest tiger donskoy cornish rex burmese burmese. Cheetah. Himalayan panther but american shorthair, munchkin, russian blue. Ragdoll. Persian tiger so mouser savannah. Egyptian mau american shorthair. Singapura ocicat for siberian, but kitten. Savannah tom scottish fold and ocicat norwegian forest and turkish angora, jaguar. Malkin malkin for cornish rex bengal. Leopard. Birman bengal for tiger. Panther. Kitty havana brown but cornish rex or burmese bombay tom. Malkin birman but havana brown yet cougar. Turkish angora donskoy or ragdoll.Abyssinian maine coon yet mouser yet tom singapura or ragdoll or bobcat. Jaguar siberian, jaguar. Ocicat puma or manx. Sphynx.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;Sphynx thai maine coon lion yet persian sphynx, but donskoy.&#60;/h2&#62;&#60;p&#62;Himalayan american bobtail yet kitten. Cheetah panther but kitten so maine coon for grimalkin and manx. Lion birman yet devonshire rex so havana brown lion or devonshire rex but panther. Savannah tom. Mouser russian blue himalayan and siamese. Thai siberian so havana brown. Maine coon thai havana brown yet manx bengal so himalayan.&#60;/p&#62;', 1),
(6, 5, 'Lion', 2, '2020-05-23', '2020-05-23', 'Lynx tiger manx ocelot', '&#60;h2&#62;&#60;span title=&#34;By:&#34;&#62;Persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;, so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#60;/p&#62;&#60;h2&#62;&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Cheetah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;, or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tomcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;British shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;.&#60;/p&#62;', 1),
(7, 5, 'Persian siberian puma', 4, '2020-05-23', '2020-05-23', 'Singapura russian blue tom bengal', '&#60;h2&#62;&#60;span title=&#34;By:&#34;&#62;Norwegian forest&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;British shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;, yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Egyptian mau&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;, so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;, or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Norwegian forest&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;h2&#62;&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;.&#38;nbsp;&#60;/h2&#62;&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;British shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;, for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;.&#60;/p&#62;', 1);
INSERT INTO `post` (`postID`, `memberID`, `title`, `categoryID`, `datePosted`, `dateUpdated`, `excerpt`, `content`, `visibility`) VALUES
(8, 5, 'Donskoy ragdoll scottish fold', 4, '2020-05-23', '2020-05-23', 'Devonshire rex american shorthair', '&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;British shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;, so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cornish rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;, yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;, yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bombay&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tomcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lion&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;/p&#62;&#60;p&#62;&#38;nbsp;&#60;/p&#62;&#60;p&#62;&#60;span id=&#34;selectable&#34;&#62;&#60;/span&#62;&#60;/p&#62;&#60;div&#62;&#38;nbsp;&#60;/div&#62;', 1),
(9, 5, 'Turkish angora puma bobcat', 3, '2020-05-23', NULL, 'Jaguar malkin', '&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;, yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tomcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American bobtail&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cougar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Norwegian forest&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;, but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tom&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;.&#60;/p&#62;', 1),
(10, 5, 'Grimalkin puma panther', 4, '2020-05-23', NULL, 'Jaguar kitty', '&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cougar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lion&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;, so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bengal&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Devonshire rex&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tiger&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;, or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bobcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;havana brown&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Cougar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;.&#60;/p&#62;', 1);
INSERT INTO `post` (`postID`, `memberID`, `title`, `categoryID`, `datePosted`, `dateUpdated`, `excerpt`, `content`, `visibility`) VALUES
(11, 5, 'Leopard tom', 2, '2020-05-23', '2020-05-25', 'Bengal savannah singapura', '&#60;p&#62;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;panther&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;, and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;siberian&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bobcat&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocelot&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siamese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Tom&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;burmese&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;leopard&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;birman&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Grimalkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Puma&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;donskoy&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tiger&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tomcat&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Siberian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;mouser&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Lion&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;American shorthair&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;grimalkin&#60;/span&#62;.&#60;br /&#62;&#60;br /&#62;&#60;span title=&#34;By:&#34;&#62;Egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american bobtail&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitty&#60;/span&#62;, for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;savannah&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Kitten&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;malkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Donskoy&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ragdoll&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;russian blue&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Egyptian mau&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;tabby&#60;/span&#62;&#38;nbsp;for&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;american shorthair&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;jaguar&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Savannah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cougar&#60;/span&#62;&#38;nbsp;or&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;cornish rex&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;british shorthair&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;persian&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;cheetah&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;puma&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Ocelot&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;scottish fold&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;egyptian mau&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Thai&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;sphynx&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;lion&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;ocicat&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;kitten&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;turkish angora&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Scottish fold&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bombay&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;maine coon&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;bengal&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Jaguar&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;devonshire rex&#60;/span&#62;&#38;nbsp;but&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;norwegian forest&#60;/span&#62;,&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;himalayan&#60;/span&#62;&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;thai&#60;/span&#62;&#38;nbsp;so&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;munchkin&#60;/span&#62;.&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;Balinese&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;abyssinian&#38;nbsp;&#60;/span&#62;&#60;span title=&#34;By:&#34;&#62;lynx&#60;/span&#62;&#38;nbsp;yet&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;manx&#60;/span&#62;&#38;nbsp;and&#38;nbsp;&#60;span title=&#34;By:&#34;&#62;singapura&#60;/span&#62;.&#60;/p&#62;', 1);

-- --------------------------------------------------------

--
-- Table structure for table `postcomment`
--

CREATE TABLE `postcomment` (
  `commentID` int(11) NOT NULL,
  `postID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `message` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `dateCommented` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `postcomment`
--

INSERT INTO `postcomment` (`commentID`, `postID`, `memberID`, `message`, `dateCommented`) VALUES
(1, 5, 3, 'Love this shit, man!', '2020-05-25'),
(2, 5, 2, 'This is nonesense.', '2020-05-25'),
(3, 5, 1, 'What did I just read?', '2020-05-25'),
(4, 5, 5, 'Hello!', '2020-05-25'),
(5, 4, 5, 'What is this about?', '2020-05-25'),
(6, 8, 5, 'It works!', '2020-05-25'),
(7, 5, 5, 'Fuckity fuck fuck shit', '2020-05-25'),
(8, 5, 5, 'Shit fuck ', '2020-05-26'),
(9, 9, 5, 'Comment', '2020-05-27'),
(10, 9, 5, 'Comment', '2020-05-27');

-- --------------------------------------------------------

--
-- Stand-in structure for view `postinfo`
-- (See below for the actual view)
--
CREATE TABLE `postinfo` (
`postID` int(11)
,`memberID` int(100)
,`categoryID` int(11)
,`title` varchar(100)
,`category` varchar(100)
,`datePosted` date
,`dateUpdated` date
,`excerpt` varchar(255)
,`content` longtext
,`visibility` int(11)
,`author` varchar(100)
,`about` varchar(200)
);

-- --------------------------------------------------------

--
-- Table structure for table `security`
--

CREATE TABLE `security` (
  `memberID` int(11) NOT NULL,
  `securityID` int(11) NOT NULL,
  `securityanswer` varchar(55) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `security`
--

INSERT INTO `security` (`memberID`, `securityID`, `securityanswer`) VALUES
(1, 1, 'smith'),
(2, 2, 'mittens'),
(3, 3, 'london'),
(4, 1, 'james'),
(5, 2, 'eggy');

-- --------------------------------------------------------

--
-- Table structure for table `securityquestions`
--

CREATE TABLE `securityquestions` (
  `securityID` int(11) NOT NULL,
  `securityquestion` varchar(55) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `securityquestions`
--

INSERT INTO `securityquestions` (`securityID`, `securityquestion`) VALUES
(1, 'What is your mothers maiden name?'),
(2, 'What is the name of your favourite cat?'),
(3, 'What is the name of the city you were born in?');

-- --------------------------------------------------------

--
-- Table structure for table `social`
--

CREATE TABLE `social` (
  `socialID` int(11) NOT NULL,
  `social` varchar(100) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `social`
--

INSERT INTO `social` (`socialID`, `social`) VALUES
(1, 'Twitter'),
(2, 'Facebook'),
(3, 'Github'),
(4, 'Instagram'),
(5, 'LinkedIn');

-- --------------------------------------------------------

--
-- Table structure for table `sociallink`
--

CREATE TABLE `sociallink` (
  `socialLinkID` int(11) NOT NULL,
  `socialID` int(11) NOT NULL,
  `memberID` int(11) NOT NULL,
  `url` varchar(255) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `sociallink`
--

INSERT INTO `sociallink` (`socialLinkID`, `socialID`, `memberID`, `url`) VALUES
(1, 1, 1, 'https://twitter.com/MarySue'),
(2, 4, 1, 'https://www.instagram.com/mary_sue/'),
(3, 5, 1, 'https://www.linkedin.com/in/marysue');

-- --------------------------------------------------------

--
-- Table structure for table `subscriber`
--

CREATE TABLE `subscriber` (
  `subscriberID` int(11) NOT NULL,
  `email` varchar(100) COLLATE latin1_general_ci NOT NULL,
  `activity` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `subscriber`
--

INSERT INTO `subscriber` (`subscriberID`, `email`, `activity`) VALUES
(1, 'sarahjpx@hotmail.com', 0),
(2, 'feline@paws.com', 0),
(3, 'theoriginal@email.com', 0),
(4, 'theoriginal@email.com', 0);

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

-- --------------------------------------------------------

--
-- Structure for view `commentview`
--
DROP TABLE IF EXISTS `commentview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `commentview`  AS  select `postcomment`.`commentID` AS `postID`,`postcomment`.`memberID` AS `memberID`,`bio`.`name` AS `author`,`member`.`userName` AS `userName`,`postcomment`.`dateCommented` AS `dateCommented`,`postcomment`.`message` AS `message` from ((`postcomment` join `member` on((`postcomment`.`memberID` = `member`.`memberID`))) join `bio` on((`postcomment`.`memberID` = `bio`.`memberID`))) ;

-- --------------------------------------------------------

--
-- Structure for view `postinfo`
--
DROP TABLE IF EXISTS `postinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `postinfo`  AS  select `post`.`postID` AS `postID`,`post`.`memberID` AS `memberID`,`post`.`categoryID` AS `categoryID`,`post`.`title` AS `title`,`category`.`category` AS `category`,`post`.`datePosted` AS `datePosted`,`post`.`dateUpdated` AS `dateUpdated`,`post`.`excerpt` AS `excerpt`,`post`.`content` AS `content`,`post`.`visibility` AS `visibility`,`bio`.`name` AS `author`,`bio`.`about` AS `about` from (((`post` join `member` on((`post`.`memberID` = `member`.`memberID`))) join `category` on((`post`.`categoryID` = `category`.`categoryID`))) join `bio` on((`post`.`memberID` = `bio`.`memberID`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesslevel`
--
ALTER TABLE `accesslevel`
  ADD PRIMARY KEY (`accessLevelID`);

--
-- Indexes for table `bio`
--
ALTER TABLE `bio`
  ADD PRIMARY KEY (`bioID`),
  ADD KEY `memberID` (`memberID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `favourite`
--
ALTER TABLE `favourite`
  ADD PRIMARY KEY (`favID`),
  ADD KEY `memberID` (`memberID`),
  ADD KEY `postID` (`postID`);

--
-- Indexes for table `featuredpost`
--
ALTER TABLE `featuredpost`
  ADD PRIMARY KEY (`featuredPostID`),
  ADD KEY `postID` (`postID`);

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
  ADD KEY `accessLevel` (`accessLevelID`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`postID`),
  ADD KEY `memberID` (`memberID`),
  ADD KEY `category` (`categoryID`);

--
-- Indexes for table `postcomment`
--
ALTER TABLE `postcomment`
  ADD PRIMARY KEY (`commentID`),
  ADD KEY `postID` (`postID`),
  ADD KEY `memberID` (`memberID`);

--
-- Indexes for table `security`
--
ALTER TABLE `security`
  ADD PRIMARY KEY (`memberID`),
  ADD KEY `securityID` (`securityID`);

--
-- Indexes for table `securityquestions`
--
ALTER TABLE `securityquestions`
  ADD PRIMARY KEY (`securityID`);

--
-- Indexes for table `social`
--
ALTER TABLE `social`
  ADD PRIMARY KEY (`socialID`);

--
-- Indexes for table `sociallink`
--
ALTER TABLE `sociallink`
  ADD PRIMARY KEY (`socialLinkID`),
  ADD KEY `socialID` (`socialID`),
  ADD KEY `memberID` (`memberID`);

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
  MODIFY `accessLevelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `bio`
--
ALTER TABLE `bio`
  MODIFY `bioID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `favourite`
--
ALTER TABLE `favourite`
  MODIFY `favID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `featuredpost`
--
ALTER TABLE `featuredpost`
  MODIFY `featuredPostID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
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
  MODIFY `postID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `postcomment`
--
ALTER TABLE `postcomment`
  MODIFY `commentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `securityquestions`
--
ALTER TABLE `securityquestions`
  MODIFY `securityID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `social`
--
ALTER TABLE `social`
  MODIFY `socialID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `sociallink`
--
ALTER TABLE `sociallink`
  MODIFY `socialLinkID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `subscriber`
--
ALTER TABLE `subscriber`
  MODIFY `subscriberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `bio`
--
ALTER TABLE `bio`
  ADD CONSTRAINT `bio_ibfk_1` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`);

--
-- Constraints for table `favourite`
--
ALTER TABLE `favourite`
  ADD CONSTRAINT `favourite_ibfk_1` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`) ON DELETE CASCADE,
  ADD CONSTRAINT `favourite_ibfk_2` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`) ON DELETE CASCADE;

--
-- Constraints for table `featuredpost`
--
ALTER TABLE `featuredpost`
  ADD CONSTRAINT `featuredpost_ibfk_1` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`);

--
-- Constraints for table `member`
--
ALTER TABLE `member`
  ADD CONSTRAINT `member_ibfk_1` FOREIGN KEY (`accessLevelID`) REFERENCES `accesslevel` (`accessLevelID`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`),
  ADD CONSTRAINT `post_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`);

--
-- Constraints for table `postcomment`
--
ALTER TABLE `postcomment`
  ADD CONSTRAINT `postcomment_ibfk_1` FOREIGN KEY (`postID`) REFERENCES `post` (`postID`),
  ADD CONSTRAINT `postcomment_ibfk_2` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`);

--
-- Constraints for table `security`
--
ALTER TABLE `security`
  ADD CONSTRAINT `security_ibfk_1` FOREIGN KEY (`securityID`) REFERENCES `securityquestions` (`securityID`);

--
-- Constraints for table `sociallink`
--
ALTER TABLE `sociallink`
  ADD CONSTRAINT `sociallink_ibfk_1` FOREIGN KEY (`socialID`) REFERENCES `social` (`socialID`),
  ADD CONSTRAINT `sociallink_ibfk_2` FOREIGN KEY (`memberID`) REFERENCES `member` (`memberID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
