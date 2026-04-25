-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 23, 2026 at 08:30 AM
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

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_assessment_statistics` ()   BEGIN
    SELECT 
        COUNT(*) AS total_assessments,
        ROUND(AVG(final_score), 2) AS average_score,
        ROUND(MIN(final_score), 2) AS lowest_score,
        ROUND(MAX(final_score), 2) AS highest_score,
        SUM(CASE WHEN final_score >= 80 THEN 1 ELSE 0 END) AS excellent_count,
        SUM(CASE WHEN final_score >= 70 AND final_score < 80 THEN 1 ELSE 0 END) AS good_count,
        SUM(CASE WHEN final_score >= 60 AND final_score < 70 THEN 1 ELSE 0 END) AS satisfactory_count,
        SUM(CASE WHEN final_score >= 50 AND final_score < 60 THEN 1 ELSE 0 END) AS pass_count,
        SUM(CASE WHEN final_score < 50 THEN 1 ELSE 0 END) AS fail_count
    FROM assessments;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `action`, `details`, `created_at`) VALUES
(1, 1, 'Login', 'User logged in successfully', '2026-04-22 21:26:10'),
(2, 1, 'Logout', 'User logged out', '2026-04-22 21:29:05'),
(3, 1, 'Login', 'User logged in successfully', '2026-04-22 21:29:16'),
(4, 1, 'Logout', 'User logged out', '2026-04-22 21:31:33'),
(5, 1, 'Login', 'User logged in successfully', '2026-04-22 21:42:23'),
(6, 1, 'Logout', 'User logged out', '2026-04-22 21:43:36'),
(7, 1, 'Login', 'User logged in successfully', '2026-04-22 22:01:58'),
(8, 1, 'Login', 'User logged in successfully', '2026-04-22 22:40:46'),
(9, 1, 'Update Assessor', 'Updated assessor: assessor3 - Dr. Emily Roberts', '2026-04-22 22:41:09'),
(10, 1, 'Update Assessor', 'Updated assessor: assessor1 - Dr. Sarah Johnson', '2026-04-22 22:41:16'),
(11, 1, 'Update Assessor', 'Updated assessor: assessor2 - Prof. Michael Chen', '2026-04-22 22:41:25'),
(12, 1, 'Logout', 'User logged out', '2026-04-22 22:41:29'),
(13, 2, 'Login', 'User logged in successfully', '2026-04-22 22:41:34'),
(14, 2, 'Assessment Submitted', 'Internship ID: 7 - Score: 50.00', '2026-04-22 23:00:08'),
(15, 2, 'Logout', 'User logged out', '2026-04-22 23:00:39'),
(16, 1, 'Login', 'User logged in successfully', '2026-04-23 15:38:56'),
(17, 1, 'Add Internship', 'Assigned student ID 8 to bla bla company', '2026-04-23 16:02:08'),
(18, NULL, 'Student Created', 'Student ID: 20713102 - Tresa', '2026-04-23 16:09:44'),
(19, 1, 'Add Student', 'Added student: 20713102 - Tresa', '2026-04-23 16:09:44'),
(20, 1, 'Logout', 'User logged out', '2026-04-23 16:10:38'),
(21, 2, 'Login', 'User logged in successfully', '2026-04-23 16:10:49'),
(22, 2, 'Logout', 'User logged out', '2026-04-23 16:28:53'),
(23, 1, 'Login', 'User logged in successfully', '2026-04-23 16:28:59');

-- --------------------------------------------------------

--
-- Table structure for table `assessments`
--

CREATE TABLE `assessments` (
  `assessment_id` int(11) NOT NULL,
  `internship_id` int(11) NOT NULL,
  `undertaking_tasks` decimal(5,2) DEFAULT '0.00',
  `health_safety` decimal(5,2) DEFAULT '0.00',
  `connectivity_knowledge` decimal(5,2) DEFAULT '0.00',
  `report_presentation` decimal(5,2) DEFAULT '0.00',
  `clarity_language` decimal(5,2) DEFAULT '0.00',
  `lifelong_learning` decimal(5,2) DEFAULT '0.00',
  `project_management` decimal(5,2) DEFAULT '0.00',
  `time_management` decimal(5,2) DEFAULT '0.00',
  `final_score` decimal(5,2) GENERATED ALWAYS AS (((((((((`undertaking_tasks` * 0.10) + (`health_safety` * 0.10)) + (`connectivity_knowledge` * 0.10)) + (`report_presentation` * 0.15)) + (`clarity_language` * 0.10)) + (`lifelong_learning` * 0.15)) + (`project_management` * 0.15)) + (`time_management` * 0.15))) STORED,
  `comments_undertaking` text COLLATE utf8mb4_unicode_ci,
  `comments_health_safety` text COLLATE utf8mb4_unicode_ci,
  `comments_connectivity` text COLLATE utf8mb4_unicode_ci,
  `comments_presentation` text COLLATE utf8mb4_unicode_ci,
  `comments_clarity` text COLLATE utf8mb4_unicode_ci,
  `comments_lifelong` text COLLATE utf8mb4_unicode_ci,
  `comments_project_mgmt` text COLLATE utf8mb4_unicode_ci,
  `comments_time_mgmt` text COLLATE utf8mb4_unicode_ci,
  `general_feedback` text COLLATE utf8mb4_unicode_ci,
  `assessed_by` int(11) NOT NULL,
  `assessed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assessments`
--

INSERT INTO `assessments` (`assessment_id`, `internship_id`, `undertaking_tasks`, `health_safety`, `connectivity_knowledge`, `report_presentation`, `clarity_language`, `lifelong_learning`, `project_management`, `time_management`, `comments_undertaking`, `comments_health_safety`, `comments_connectivity`, `comments_presentation`, `comments_clarity`, `comments_lifelong`, `comments_project_mgmt`, `comments_time_mgmt`, `general_feedback`, `assessed_by`, `assessed_at`, `updated_at`) VALUES
(1, 1, '85.00', '90.00', '80.00', '88.00', '85.00', '82.00', '86.00', '88.00', 'Excellent understanding of project requirements', 'Consistently followed safety protocols', 'Good application of theoretical knowledge', 'Well-structured and professional report', 'Clear and concise language throughout', 'Showed initiative in learning new technologies', 'Effectively managed project milestones', 'Good time management skills demonstrated', 'Outstanding performance overall. Keep up the excellent work!', 2, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(2, 2, '78.00', '85.00', '75.00', '80.00', '82.00', '78.00', '75.00', '80.00', 'Good grasp of project tasks', 'Maintained good safety practices', 'Applied concepts adequately', 'Report could be more detailed', 'Generally clear communication', 'Active learner, sought additional knowledge', 'Room for improvement in planning', 'Managed time reasonably well', 'Good performance with areas for improvement.', 2, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(3, 3, '92.00', '95.00', '88.00', '90.00', '92.00', '90.00', '88.00', '92.00', 'Exceptional work on all assigned tasks', 'Exemplary adherence to safety standards', 'Excellent integration of theory and practice', 'Outstanding report quality', 'Exceptional clarity in documentation', 'Proactive in continuous learning', 'Excellent project organization', 'Superior time management', 'Exceptional intern! Highly recommended for future opportunities.', 3, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(4, 7, '50.00', '50.00', '50.00', '50.00', '50.00', '50.00', '50.00', '50.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 2, '2026-04-22 23:00:08', '2026-04-22 23:00:08');

--
-- Triggers `assessments`
--
DELIMITER $$
CREATE TRIGGER `tr_assessment_created` AFTER INSERT ON `assessments` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (user_id, action, details, created_at)
    VALUES (NEW.assessed_by, 'Assessment Submitted', CONCAT('Internship ID: ', NEW.internship_id, ' - Score: ', NEW.final_score), NOW());
END
$$
DELIMITER ;

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
  `date_out` date NOT NULL,
  `date_returned` date DEFAULT NULL,
  `condition_out` varchar(100) DEFAULT NULL,
  `condition_returned` varchar(100) DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `internships`
--

CREATE TABLE `internships` (
  `internship_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `assessor_id` int(11) NOT NULL,
  `company_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `internship_start_date` date DEFAULT NULL,
  `internship_end_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `internships`
--

INSERT INTO `internships` (`internship_id`, `student_id`, `assessor_id`, `company_name`, `internship_start_date`, `internship_end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Tech Solutions Sdn Bhd', '2025-06-01', '2025-08-31', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(2, 2, 2, 'Digital Innovations Malaysia', '2025-06-01', '2025-08-31', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(3, 3, 3, 'Cloud Systems Asia', '2025-06-15', '2025-09-15', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(4, 4, 3, 'Software Development Corp', '2025-06-01', '2025-08-31', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(5, 5, 4, 'Cybersecurity Solutions', '2025-07-01', '2025-09-30', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(6, 6, 4, 'DataTech Malaysia', '2025-06-15', '2025-09-15', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(7, 7, 2, 'Mobile Apps Studio', '2025-06-01', '2025-08-31', '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(8, 8, 2, 'bla bla company', '2026-04-24', '2026-07-24', '2026-04-23 16:02:08', '2026-04-23 16:02:08');

-- --------------------------------------------------------

--
-- Table structure for table `it_assets`
--

CREATE TABLE `it_assets` (
  `asset_id` int(11) NOT NULL,
  `asset_type_code` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `it_asset_inventory`
--

CREATE TABLE `it_asset_inventory` (
  `it_asset_inventory_id` int(11) NOT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `inventory_date` date DEFAULT NULL,
  `number_assigned` int(11) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `attempt_id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attempt_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`attempt_id`, `username`, `ip_address`, `attempt_time`, `success`) VALUES
(1, 'admin', '::1', '2026-04-22 17:19:31', 0),
(2, 'admin', '::1', '2026-04-22 17:20:21', 0),
(3, 'admin', '::1', '2026-04-22 17:21:24', 0),
(4, 'admin', '::1', '2026-04-22 17:21:48', 0),
(5, 'admin', '::1', '2026-04-22 17:22:37', 0),
(6, 'assessor1', '::1', '2026-04-22 17:22:59', 0),
(7, 'admin', '::1', '2026-04-22 17:26:33', 0),
(8, 'admin', '::1', '2026-04-22 17:26:41', 0),
(9, 'admin', '::1', '2026-04-22 17:39:30', 0),
(10, 'assessor1', '::1', '2026-04-22 17:40:46', 0),
(11, 'assessor1', '::1', '2026-04-22 18:15:22', 0),
(12, 'admin', '::1', '2026-04-22 18:18:18', 0),
(13, 'admin', '::1', '2026-04-22 18:18:59', 0),
(14, 'admin', '::1', '2026-04-22 18:19:04', 0),
(15, 'admin', '::1', '2026-04-22 18:19:08', 0),
(16, 'admin', '::1', '2026-04-22 18:19:24', 0),
(17, 'admin', '::1', '2026-04-22 18:36:41', 0),
(18, 'admin', '::1', '2026-04-22 19:04:36', 0),
(19, 'assessor1', '::1', '2026-04-22 21:31:48', 0),
(20, 'assessor1', '::1', '2026-04-22 21:42:12', 0),
(21, 'assessor1', '::1', '2026-04-22 21:42:16', 0),
(22, 'assessor1', '::1', '2026-04-22 21:43:43', 0),
(23, 'assessor1', '::1', '2026-04-22 21:43:48', 0);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `programme` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `student_name`, `programme`, `email`, `phone`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CS2021001', 'John Smith', 'Computer Science', 'john.smith@student.edu', '+60123456789', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(2, 'CS2021002', 'Alice Wong', 'Computer Science', 'alice.wong@student.edu', '+60123456790', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(3, 'CS2021003', 'David Lee', 'Computer Science', 'david.lee@student.edu', '+60123456791', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(4, 'SE2021001', 'Emma Brown', 'Software Engineering', 'emma.brown@student.edu', '+60123456792', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(5, 'SE2021002', 'Ryan Taylor', 'Software Engineering', 'ryan.taylor@student.edu', '+60123456793', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(6, 'IT2021001', 'Sophia Martinez', 'Information Technology', 'sophia.m@student.edu', '+60123456794', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(7, 'IT2021002', 'James Wilson', 'Information Technology', 'james.w@student.edu', '+60123456795', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(8, 'CS2021004', 'Olivia Anderson', 'Computer Science', 'olivia.a@student.edu', '+60123456796', 1, '2026-04-22 16:56:34', '2026-04-22 16:56:34'),
(9, '20713102', 'Tresa', 'Computer Science', 'jongjunjiet@gmail.com', '0123456789', 1, '2026-04-23 16:09:44', '2026-04-23 16:09:44');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `tr_student_created` AFTER INSERT ON `students` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (user_id, action, details, created_at)
    VALUES (NULL, 'Student Created', CONCAT('Student ID: ', NEW.student_id, ' - ', NEW.student_name), NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('Admin','Assessor') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `full_name`, `email`, `role`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2y$10$/cNiu5RcKPr9C0JyF73lFe8YPSdUoMoLZW5bUHxsfdklTow.073c2', 'System Administrator', 'admin@university.edu', 'Admin', 1, '2026-04-22 16:56:34', '2026-04-22 21:28:48'),
(2, 'assessor1', '$2y$10$UWWKjWd8CD/Qm052uZ7gSO4DK3vsOaOjDUfqCBJXVrXaygewZ8.z6', 'Dr. Sarah Johnson', 'sarah.j@university.edu', 'Assessor', 1, '2026-04-22 16:56:34', '2026-04-22 22:41:16'),
(3, 'assessor2', '$2y$10$Led5dITNXeESXXkugmIMKenoxV0ZaMNjr4t0C1c5by8OP0sH9F1NW', 'Prof. Michael Chen', 'michael.c@university.edu', 'Assessor', 1, '2026-04-22 16:56:34', '2026-04-22 22:41:25'),
(4, 'assessor3', '$2y$10$ycDGf0/k4iylDj/oAFHBf.f7cSgdctrxZpHESVkDiOJnp2tmcmMaS', 'Dr. Emily Roberts', 'emily.r@university.edu', 'Assessor', 1, '2026-04-22 16:56:34', '2026-04-22 22:41:09');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_assessor_workload`
-- (See below for the actual view)
--
CREATE TABLE `vw_assessor_workload` (
`user_id` int(11)
,`assessor_name` varchar(100)
,`total_students` bigint(21)
,`completed_assessments` bigint(21)
,`pending_assessments` bigint(22)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_student_results`
-- (See below for the actual view)
--
CREATE TABLE `vw_student_results` (
`student_id` varchar(20)
,`student_name` varchar(100)
,`programme` varchar(100)
,`company_name` varchar(150)
,`assessor_name` varchar(100)
,`final_score` decimal(5,2)
,`assessed_at` datetime
,`grade` varchar(12)
);

-- --------------------------------------------------------

--
-- Structure for view `vw_assessor_workload`
--
DROP TABLE IF EXISTS `vw_assessor_workload`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_assessor_workload`  AS SELECT `u`.`user_id` AS `user_id`, `u`.`full_name` AS `assessor_name`, count(`i`.`internship_id`) AS `total_students`, count(`a`.`assessment_id`) AS `completed_assessments`, (count(`i`.`internship_id`) - count(`a`.`assessment_id`)) AS `pending_assessments` FROM ((`users` `u` left join `internships` `i` on((`u`.`user_id` = `i`.`assessor_id`))) left join `assessments` `a` on((`i`.`internship_id` = `a`.`internship_id`))) WHERE ((`u`.`role` = 'Assessor') AND (`u`.`is_active` = 1)) GROUP BY `u`.`user_id`, `u`.`full_name``full_name`  ;

-- --------------------------------------------------------

--
-- Structure for view `vw_student_results`
--
DROP TABLE IF EXISTS `vw_student_results`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_student_results`  AS SELECT `s`.`student_id` AS `student_id`, `s`.`student_name` AS `student_name`, `s`.`programme` AS `programme`, `i`.`company_name` AS `company_name`, `u`.`full_name` AS `assessor_name`, `a`.`final_score` AS `final_score`, `a`.`assessed_at` AS `assessed_at`, (case when (`a`.`final_score` >= 80) then 'Excellent' when (`a`.`final_score` >= 70) then 'Good' when (`a`.`final_score` >= 60) then 'Satisfactory' when (`a`.`final_score` >= 50) then 'Pass' else 'Fail' end) AS `grade` FROM (((`students` `s` left join `internships` `i` on((`s`.`id` = `i`.`student_id`))) left join `assessments` `a` on((`i`.`internship_id` = `a`.`internship_id`))) left join `users` `u` on((`i`.`assessor_id` = `u`.`user_id`))) WHERE (`s`.`is_active` = 1)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`assessment_id`),
  ADD UNIQUE KEY `unique_internship_assessment` (`internship_id`),
  ADD KEY `assessed_by` (`assessed_by`),
  ADD KEY `idx_internship` (`internship_id`),
  ADD KEY `idx_final_score` (`final_score`);

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
  ADD PRIMARY KEY (`asset_id`,`employee_id`,`date_out`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `internships`
--
ALTER TABLE `internships`
  ADD PRIMARY KEY (`internship_id`),
  ADD KEY `idx_student` (`student_id`),
  ADD KEY `idx_assessor` (`assessor_id`);

--
-- Indexes for table `it_assets`
--
ALTER TABLE `it_assets`
  ADD PRIMARY KEY (`asset_id`),
  ADD KEY `asset_type_code` (`asset_type_code`);

--
-- Indexes for table `it_asset_inventory`
--
ALTER TABLE `it_asset_inventory`
  ADD PRIMARY KEY (`it_asset_inventory_id`),
  ADD KEY `asset_id` (`asset_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`attempt_id`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_attempt_time` (`attempt_time`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD KEY `idx_student_id` (`student_id`),
  ADD KEY `idx_student_name` (`student_name`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `assessments`
--
ALTER TABLE `assessments`
  MODIFY `assessment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `internships`
--
ALTER TABLE `internships`
  MODIFY `internship_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `attempt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `assessments_ibfk_1` FOREIGN KEY (`internship_id`) REFERENCES `internships` (`internship_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `assessments_ibfk_2` FOREIGN KEY (`assessed_by`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `employee_assets`
--
ALTER TABLE `employee_assets`
  ADD CONSTRAINT `employee_assets_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `it_assets` (`asset_id`),
  ADD CONSTRAINT `employee_assets_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

--
-- Constraints for table `internships`
--
ALTER TABLE `internships`
  ADD CONSTRAINT `internships_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `internships_ibfk_2` FOREIGN KEY (`assessor_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `it_assets`
--
ALTER TABLE `it_assets`
  ADD CONSTRAINT `it_assets_ibfk_1` FOREIGN KEY (`asset_type_code`) REFERENCES `asset_types` (`asset_type_code`);

--
-- Constraints for table `it_asset_inventory`
--
ALTER TABLE `it_asset_inventory`
  ADD CONSTRAINT `it_asset_inventory_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `it_assets` (`asset_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
