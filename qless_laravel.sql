-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2026 at 06:21 PM
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
-- Database: `qless_laravel`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-246f9cfb23333d1336778e3d1d743eed', 'i:1;', 1779821388),
('laravel-cache-246f9cfb23333d1336778e3d1d743eed:timer', 'i:1779821388;', 1779821388),
('laravel-cache-404bfea0573f33a20110c5a1a82bcec9', 'i:1;', 1779972829),
('laravel-cache-404bfea0573f33a20110c5a1a82bcec9:timer', 'i:1779972829;', 1779972829),
('laravel-cache-df0fd5cd086030281697f20c503aba5f', 'i:1;', 1779821338),
('laravel-cache-df0fd5cd086030281697f20c503aba5f:timer', 'i:1779821338;', 1779821338);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `canteens`
--

CREATE TABLE `canteens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `operating_hours` varchar(255) NOT NULL,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `canteens`
--

INSERT INTO `canteens` (`id`, `name`, `location`, `operating_hours`, `is_open`, `created_at`, `updated_at`) VALUES
(1, 'SLIIT - Main Canteen', 'New Kandy Rd, Malabe', '7:00 AM - 6:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(2, 'SLIIT - Cafe', 'New Kandy Rd, Malabe', '8:00 AM - 5:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(3, 'IIT - Rooftop Bistro', 'Wellawatte, level 4', '9:00 AM - 8:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(4, 'NSBM - Green Food Court', 'Homagama, Student Center', '8:00 AM - 6:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(5, 'CINEC - Maritime Mess', 'Malabe, Building C', '6:00 AM - 9:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(6, 'KDU - Cadets Canteen', 'Ratmalana, Mess Hall', '6:00 AM - 10:00 PM', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(7, 'NSBM Green Uni - Sunil Cafe', 'NSBM Green Uni', '8:00 AM - 6:00 PM', 0, '2026-05-26 12:12:36', '2026-05-26 12:12:36'),
(8, 'APIIT Main - Food Court', 'APIIT Main', '8:00 AM - 6:00 PM', 0, '2026-05-26 12:16:18', '2026-05-26 12:16:18'),
(9, 'Colombo Campus', 'Colombo', '8.30AM - 5.30PM', 1, '2026-05-26 12:40:09', '2026-05-26 12:40:09');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_21_121758_add_two_factor_columns_to_users_table', 1),
(5, '2026_04_21_121847_create_personal_access_tokens_table', 1),
(6, '2026_05_04_004909_create_canteens_table', 1),
(7, '2026_05_15_174645_create_products_table', 1),
(8, '2026_05_23_052921_add_canteen_id_to_users_table', 1),
(9, '2026_05_23_102928_create_orders_table', 1),
(10, '2026_05_23_103002_create_order_items_table', 1),
(11, '2026_05_24_164046_add_otp_to_orders_table', 2),
(12, '2026_05_26_170053_add_status_and_tenant_to_users_table', 3),
(13, '2026_05_27_061712_create_personal_access_tokens_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `canteen_id` bigint(20) UNSIGNED NOT NULL,
  `total_amount` decimal(8,2) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `otp` varchar(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `canteen_id`, `total_amount`, `status`, `otp`, `created_at`, `updated_at`) VALUES
(1, 8, 2, 550.00, 'completed', '1234', '2026-05-23 07:16:37', '2026-05-25 10:09:40'),
(2, 8, 2, 550.00, 'completed', '5432', '2026-05-23 07:23:38', '2026-05-26 00:54:27'),
(3, 8, 2, 550.00, 'completed', NULL, '2026-05-23 07:23:41', '2026-05-24 11:09:04'),
(4, 8, 2, 550.00, 'completed', '5321', '2026-05-23 07:29:52', '2026-05-26 00:55:45'),
(5, 8, 2, 800.00, 'completed', '5498', '2026-05-26 01:31:57', '2026-05-26 04:51:27'),
(6, 8, 2, 450.00, 'completed', '4861', '2026-05-26 02:58:49', '2026-05-26 04:45:26'),
(7, 8, 2, 200.00, 'completed', '5698', '2026-05-26 04:10:41', '2026-05-26 04:53:30'),
(8, 8, 2, 550.00, 'completed', '1234', '2026-05-26 04:21:26', '2026-05-26 04:57:49'),
(9, 10, 1, 660.00, 'completed', '5590', '2026-05-26 04:34:24', '2026-05-26 04:35:43'),
(10, 8, 2, 550.00, 'completed', '5602', '2026-05-26 05:05:01', '2026-05-26 05:05:45'),
(11, 8, 2, 200.00, 'completed', '5905', '2026-05-26 05:09:42', '2026-05-26 05:11:09'),
(12, 8, 2, 800.00, 'completed', '9672', '2026-05-26 05:10:11', '2026-05-26 05:16:10'),
(13, 8, 2, 750.00, 'completed', '2907', '2026-05-26 05:21:01', '2026-05-26 05:21:43'),
(14, 8, 2, 400.00, 'pending', '1742', '2026-05-26 13:16:40', '2026-05-26 13:16:40'),
(15, 9, 1, 750.00, 'pending', '6407', '2026-05-28 09:15:11', '2026-05-28 09:15:11');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 1, 550.00, '2026-05-23 07:16:37', '2026-05-23 07:16:37'),
(2, 2, 4, 1, 550.00, '2026-05-23 07:23:38', '2026-05-23 07:23:38'),
(3, 3, 4, 1, 550.00, '2026-05-23 07:23:41', '2026-05-23 07:23:41'),
(4, 4, 4, 1, 550.00, '2026-05-23 07:29:52', '2026-05-23 07:29:52'),
(5, 5, 8, 1, 250.00, '2026-05-26 01:31:57', '2026-05-26 01:31:57'),
(6, 5, 4, 1, 550.00, '2026-05-26 01:31:57', '2026-05-26 01:31:57'),
(7, 6, 5, 1, 200.00, '2026-05-26 02:58:49', '2026-05-26 02:58:49'),
(8, 6, 8, 1, 250.00, '2026-05-26 02:58:49', '2026-05-26 02:58:49'),
(9, 7, 5, 1, 200.00, '2026-05-26 04:10:41', '2026-05-26 04:10:41'),
(10, 8, 4, 1, 550.00, '2026-05-26 04:21:26', '2026-05-26 04:21:26'),
(11, 9, 2, 1, 550.00, '2026-05-26 04:34:24', '2026-05-26 04:34:24'),
(12, 9, 3, 1, 110.00, '2026-05-26 04:34:24', '2026-05-26 04:34:24'),
(13, 10, 4, 1, 550.00, '2026-05-26 05:05:01', '2026-05-26 05:05:01'),
(14, 11, 5, 1, 200.00, '2026-05-26 05:09:42', '2026-05-26 05:09:42'),
(15, 12, 8, 1, 250.00, '2026-05-26 05:10:11', '2026-05-26 05:10:11'),
(16, 12, 4, 1, 550.00, '2026-05-26 05:10:11', '2026-05-26 05:10:11'),
(17, 13, 5, 1, 200.00, '2026-05-26 05:21:01', '2026-05-26 05:21:01'),
(18, 13, 4, 1, 550.00, '2026-05-26 05:21:01', '2026-05-26 05:21:01'),
(19, 14, 9, 1, 150.00, '2026-05-26 13:16:40', '2026-05-26 13:16:40'),
(20, 14, 8, 1, 250.00, '2026-05-26 13:16:40', '2026-05-26 13:16:40'),
(21, 15, 1, 2, 650.00, '2026-05-28 09:15:11', '2026-05-28 09:15:11');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(9, 'App\\Models\\User', 9, 'iPhone 15 Pro', '0b86896da9a6fdbbdbe4a832ed3ac4508b19ef9791f966dac9d9bd41719100ee', '[\"menu:view\",\"orders:create\",\"profile:update\"]', '2026-05-28 07:32:39', NULL, '2026-05-28 07:32:24', '2026-05-28 07:32:39'),
(10, 'App\\Models\\User', 9, 'iPhone 15 Pro', 'd9ac6b9701cc2f9f485c5b125e23f5c78109e747f17904616d160a3674173f7e', '[\"menu:view\",\"orders:create\",\"profile:update\"]', '2026-05-28 07:46:11', NULL, '2026-05-28 07:45:18', '2026-05-28 07:46:11'),
(11, 'App\\Models\\User', 9, 'iPhone 15 Pro', '29f15b05967a5c33b073899d34f34f3345c0296412d1ed8382b4067605aa037b', '[\"menu:view\",\"orders:create\",\"profile:update\"]', '2026-05-28 07:54:00', NULL, '2026-05-28 07:51:07', '2026-05-28 07:54:00'),
(12, 'App\\Models\\User', 9, 'iPhone 15 Pro', '861f4096ab4f1d08cd805e2029992561f95e9e779d1e19703176f95ab0e56332', '[\"menu:view\",\"orders:create\",\"profile:update\"]', NULL, NULL, '2026-05-28 09:12:01', '2026-05-28 09:12:01'),
(13, 'App\\Models\\User', 9, 'iPhone 15 Pro', '8c76a2a03241c0b0174a6b7128e9f7538cc122de6206c56ff55e33af4138248e', '[\"menu:view\",\"orders:create\",\"profile:update\"]', '2026-05-28 09:15:11', NULL, '2026-05-28 09:14:25', '2026-05-28 09:15:11');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `canteen_id` bigint(20) UNSIGNED NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `canteen_id`, `item_name`, `category`, `price`, `description`, `image_url`, `is_available`, `created_at`, `updated_at`) VALUES
(1, 1, 'Chicken Fried Rice', 'Mains', 650.00, 'Basmati rice with fried chicken and chilli paste.', 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=500&q=60', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(2, 1, 'Vegetable Kottu', 'Mains', 550.00, 'Spicy chopped roti with fresh vegetables and gravy.', 'https://www.hungrylankan.com/wp-content/uploads/2024/07/IMG_4940.jpeg', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(3, 1, 'Iced Coffee', 'Drinks', 110.00, 'Chilled Sri Lankan style sweet iced coffee.', 'https://images.unsplash.com/photo-1578612599351-434b8ff87a70?q=80&w=750&auto=format&fit=crop', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(4, 2, 'Crispy Chicken Burger', 'Mains', 550.00, 'Crispy chicken patty with fresh lettuce and mayo.', 'https://plus.unsplash.com/premium_photo-1695758787947-0aff87c1f93a?w=600&auto=format&fit=crop', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(5, 2, 'Chocolate Brownie', 'Pastry', 200.00, 'Rich, fudgy dark chocolate brownie.', 'https://images.unsplash.com/photo-1606313564573-104197cf8f91?w=600&auto=format&fit=crop', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(6, 3, 'Club Sandwich', 'Mains', 400.00, 'Triple layer toasted sandwich with chicken and cheese.', 'https://plus.unsplash.com/premium_photo-1738802845911-809a01acfa50?w=600&auto=format&fit=crop', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(7, 3, 'French Fries', 'Snacks', 250.00, 'Crispy golden salted potato fries.', 'https://images.unsplash.com/photo-1541592106381-b31e9677c0e5?w=600&auto=format&fit=crop', 1, '2026-05-23 05:04:19', '2026-05-23 05:04:19'),
(8, 2, 'Falooda', 'Drinks', 250.00, 'A decadent, layered dessert drink made with chilled rose syrup, silky vermicelli, chewy sweet basil seeds, and fruit jelly.', 'https://herbivorecucina.com/wp-content/uploads/2021/05/Royal-Falooda-1.jpg', 1, '2026-05-24 19:12:57', '2026-05-24 19:21:20'),
(9, 2, 'Chicken Puff', 'Pastry', 150.00, 'A flaky, golden puff pastry stuffed with tender, seasoned chicken cooked to perfection with aromatic spices.', 'https://nishkitchen.com/wp-content/uploads/2019/01/Chicken-Puff-1B.jpg', 1, '2026-05-26 13:16:06', '2026-05-26 13:16:06');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2Xpth4YTxTqgVamO37tBgwhuxGHMg5QQyAyyi5DA', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGZRQkx0akRFanByS0NNT2JJV2JOWHJ1WFhYNk9GSDlvVEMyZU1IaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779905797),
('8FSrRRjeADW7sG4vQjtKMG60gX99joS2qNOCYX05', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEZQNFg2eU53VlJXWm1PNWhCZVFFTFZkZWIxSUdrSFVTMkVoZDFuWSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779908010),
('E9wEwsBXuPTaSP95kqbgJvsYQSSNevFJeTjMsyta', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHZLeEdGd1BlSktnanM3Nmpkc2ZzdVRGNzJMdkpuS0hTVjh1VWNPSSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779973226),
('eeRgzoExyuL4oUDqSfsSUWowH9bAaJDwOHV2zwed', 8, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMG84bms0SzZ4QXJJNDRyMjlzUFE2UG9IWjhqSXAwdnIzd1RTaGw5RiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zdHVkZW50L21lbnUiO3M6NToicm91dGUiO3M6MTI6InN0dWRlbnQubWVudSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjg7fQ==', 1779972771),
('fu2ryg6QcV1wKYTlRuFvNnL5t1ao584MtTkibRDQ', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDUyQ2cwb29NbFZvOWVSUUxTcFVhV1dMbE1qeHpUaU1oZFpJcWJ3aSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779907632),
('J0L2RxXQAqxmUZAV8xp9cXgP2KXgUDga0oSb0cD7', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUZBb1dLQVcydGZuNFJqemRhbm12V0w5NFRzZWxGVlV4ZnFXc011NSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779930889),
('pc2VxqCwG9bMa27hC1jKpgf1Jbd5KphMyrZGUemQ', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibW5vcmR3Z1EyODhzRW1GWERORFNXYU52N2MyYVdCRDBtR2hSRzhtbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779974200),
('uPMvpPrILG5b93HvS1IOLGx6co3bDcWJwmWNSagz', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoib0hpUHdNSlVGd0JNenJ6b1hMVTNnZUVBWGdDTGZvSkZ1YkRxOU94cyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNDoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3N0dWRlbnQvbWVudSI7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1779984943),
('wUz51M7PcGzJ0YqTciBoknxYZJV1EFIQRbNLiJDV', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUU9uTUgwc05EQWhmcDBnUk5BZ3lrRXRHQzNNZ0RUeUNYUk8zdjJvSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779979384),
('XKXNoQSoT0cZ9OpkcJ5FNV2cbTNaZig4CqP1KZAx', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjdGVjY2NzJFZUhlZE1FZDJOMkJZWUVDSk5KRE8zMEoyaXBLU0dkOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779908031),
('XYP0sy1DkTeFOaFAz5yOEvUS9qqLahnIxZnWj6Yl', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibk1CREtpaVBIVGtMbGh6VG9pUFBQelpyNHNqdzd5T3hjM2xEdkxuQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1779905752),
('Z4Qf7oXQajsCjhvR7MEHXJPFrgwcZpd49JdL3IpU', NULL, '127.0.0.1', 'PostmanRuntime/7.51.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDdmbkh5MVdaakZNT1BFd21PWVpXSVNvOWRqNUIzV2l5QzJQR0ROTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1779908042);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'student',
  `canteen_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `approval_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'approved'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `role`, `canteen_id`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`, `approval_status`) VALUES
(1, 'System Administrator', 'admin@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'admin', NULL, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(2, 'Kamal Perera', 'manager.sliit@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 1, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(3, 'Mahesh Kumara', 'manager.sliitcafe@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 2, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(4, 'Sarah Jones', 'manager.iit@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 3, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(5, 'Chathura Gunawardena', 'manager.nsbm@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 4, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(6, 'Capt. Perera', 'manager.cinec@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 5, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(7, 'Major Sunil', 'manager.kdu@qless.com', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'manager', 6, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(8, 'Avishka Fernando', 'avishka@sliit.lk', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'student', 2, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(9, 'Kavindi Perera', 'kavindi@sliit.lk', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'student', 1, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(10, 'Sanduni Silva', 'sanduni@sliit.lk', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'student', 1, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(11, 'Nuwan Pradeep', 'nuwan@iit.ac.lk', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'student', 1, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(12, 'Dilshan Madushanka', 'dilshanM@sliit.lk', NULL, '$2y$12$tUeCTIsPhH6D2FZBiIs7yOzCsAb0xMCHTLUarMnMZpccDhVrd622m', NULL, NULL, NULL, 'student', 1, NULL, NULL, NULL, '2026-05-23 05:04:19', '2026-05-23 05:04:19', 'approved'),
(13, 'Sunil Rajapaksha', 'sunil@outlook.com', NULL, '$2y$12$dZQB7UcfaP1ZiH2F39e/FuqtagasxmDtO732j8nn8YtdXnWIE3yDi', NULL, NULL, NULL, 'manager', 7, NULL, NULL, NULL, '2026-05-26 12:12:36', '2026-05-26 12:27:45', 'approved'),
(14, 'Diwya Jayawardana', 'diwyasemini@gmail.com', NULL, '$2y$12$AiWFkEJogqIOkWOeg6HU9OpB9wWEPpxWJHZ0fBQbjk/Vcm0J1O.CK', NULL, NULL, NULL, 'manager', 8, NULL, NULL, NULL, '2026-05-26 12:16:18', '2026-05-26 12:16:18', 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `canteens`
--
ALTER TABLE `canteens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_canteen_id_foreign` (`canteen_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_canteen_id_foreign` (`canteen_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `canteens`
--
ALTER TABLE `canteens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_canteen_id_foreign` FOREIGN KEY (`canteen_id`) REFERENCES `canteens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_canteen_id_foreign` FOREIGN KEY (`canteen_id`) REFERENCES `canteens` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
