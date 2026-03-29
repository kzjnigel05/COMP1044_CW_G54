-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 29, 2026 at 08:02 AM
-- Server version: 5.7.24
-- PHP Version: 8.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `comp1044_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE `asset_types` (
  `asset_type_code` varchar(10) NOT NULL,
  `asset_type_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee_assets`
--

CREATE TABLE `employee_assets` (
  `asset_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date_out` date DEFAULT NULL,
  `date_returned` date DEFAULT NULL,
  `condition_out` varchar(100) DEFAULT NULL,
  `condition_returned` varchar(100) DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `it_assets`
--

CREATE TABLE `it_assets` (
  `asset_id` int(11) NOT NULL,
  `asset_type_code` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `other_detail` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `it_assets_inventory`
--

CREATE TABLE `it_assets_inventory` (
  `it_asset_inventory_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `inventory_date` date DEFAULT NULL,
  `number_assigned` int(11) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL,
  `other_detail` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD PRIMARY KEY (`asset_type_code`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `employee_assets`
--
ALTER TABLE `employee_assets`
  ADD PRIMARY KEY (`asset_id`,`employee_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `it_assets`
--
ALTER TABLE `it_assets`
  ADD PRIMARY KEY (`asset_id`),
  ADD KEY `asset_type_code` (`asset_type_code`);

--
-- Indexes for table `it_assets_inventory`
--
ALTER TABLE `it_assets_inventory`
  ADD PRIMARY KEY (`it_asset_inventory_id`),
  ADD KEY `asset_id` (`asset_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee_assets`
--
ALTER TABLE `employee_assets`
  ADD CONSTRAINT `employee_assets_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `it_assets` (`asset_id`),
  ADD CONSTRAINT `employee_assets_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `it_assets`
--
ALTER TABLE `it_assets`
  ADD CONSTRAINT `it_assets_ibfk_1` FOREIGN KEY (`asset_type_code`) REFERENCES `asset_types` (`asset_type_code`);

--
-- Constraints for table `it_assets_inventory`
--
ALTER TABLE `it_assets_inventory`
  ADD CONSTRAINT `it_assets_inventory_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `it_assets` (`asset_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
