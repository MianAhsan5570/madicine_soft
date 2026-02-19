-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 19, 2026 at 10:21 AM
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
-- Database: `medicine_soft`
--

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `area_id` int(11) NOT NULL,
  `area_name` varchar(255) NOT NULL,
  `area_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`area_id`, `area_name`, `area_status`) VALUES
(1, 'madina town', 1);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(255) NOT NULL,
  `brand_active` int(11) NOT NULL DEFAULT 0,
  `brand_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`, `brand_active`, `brand_status`) VALUES
(1, 'dsfr', 0, 1),
(2, '', 0, 1),
(3, '', 0, 1),
(4, '', 0, 1),
(5, '', 0, 1),
(6, '', 0, 1),
(7, '', 0, 1),
(8, '', 0, 1),
(9, '', 0, 1),
(10, '', 0, 1),
(11, '', 0, 1),
(12, '', 0, 1),
(13, '', 0, 1),
(14, '', 0, 1),
(15, '', 0, 1),
(16, '', 0, 1),
(17, '', 0, 1),
(18, '', 0, 1),
(19, '', 0, 1),
(20, '', 0, 1),
(21, '', 0, 1),
(22, '', 0, 1),
(23, '', 0, 1),
(24, '', 0, 1),
(25, '', 0, 1),
(26, '', 0, 1),
(27, '', 0, 1),
(28, '', 0, 1),
(29, '', 0, 1),
(30, '', 0, 1),
(31, '', 0, 1),
(32, '', 0, 1),
(33, '', 0, 1),
(34, '', 0, 1),
(35, '', 0, 1),
(36, 'sdsa', 0, 1),
(37, 'newww', 0, 0),
(39, 'tessss', 0, 1),
(40, 'dess', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `brokers`
--

CREATE TABLE `brokers` (
  `broker_id` int(255) NOT NULL,
  `broker_name` text NOT NULL,
  `broker_phone` text NOT NULL,
  `broker_email` text NOT NULL,
  `broker_address` text NOT NULL,
  `broker_status` int(11) NOT NULL,
  `adddatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `budget_id` int(11) NOT NULL,
  `budget_name` text NOT NULL,
  `budget_amount` double NOT NULL,
  `budget_type` varchar(300) NOT NULL,
  `voucher_id` int(11) DEFAULT NULL,
  `voucher_type` int(11) DEFAULT NULL,
  `budget_date` date NOT NULL,
  `budget_add_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `budget_category`
--

CREATE TABLE `budget_category` (
  `budget_category_id` int(11) NOT NULL,
  `budget_category_name` text NOT NULL,
  `budget_category_type` varchar(400) NOT NULL,
  `budget_category_add_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL,
  `categories_name` varchar(255) NOT NULL,
  `category_price` varchar(100) NOT NULL DEFAULT '1',
  `category_purchase` varchar(100) NOT NULL,
  `categories_active` int(11) NOT NULL DEFAULT 0,
  `categories_status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categories_id`, `categories_name`, `category_price`, `category_purchase`, `categories_active`, `categories_status`) VALUES
(1, '', '1', '', 0, 1),
(2, '', '1', '', 0, 1),
(3, '', '1', '', 0, 1),
(4, '', '1', '', 0, 1),
(5, '', '1', '', 0, 1),
(6, '', '1', '', 0, 1),
(7, '', '1', '', 0, 1),
(8, '', '1', '', 0, 1),
(9, '', '1', '', 0, 1),
(10, '', '1', '', 0, 1),
(11, '', '1', '', 0, 1),
(12, '', '1', '', 0, 1),
(13, '', '1', '', 0, 1),
(14, '', '1', '', 0, 1),
(15, '', '1', '', 0, 1),
(16, '', '1', '', 0, 1),
(17, '', '1', '', 0, 1),
(18, '', '1', '', 0, 1),
(19, '', '1', '', 0, 1),
(20, '', '1', '', 0, 1),
(21, '', '1', '', 0, 1),
(22, '', '1', '', 0, 1),
(23, '', '1', '', 0, 1),
(24, '', '1', '', 0, 1),
(25, '', '1', '', 0, 1),
(26, '', '1', '', 0, 1),
(27, '', '1', '', 0, 1),
(28, '', '1', '', 0, 1),
(29, '', '1', '', 0, 1),
(30, '', '1', '', 0, 1),
(31, '', '1', '', 0, 1),
(32, '', '1', '', 0, 1),
(33, '', '1', '', 0, 1),
(34, '', '1', '', 0, 1),
(35, '', '1', '', 0, 1),
(36, 'new5', '', '', 0, 1),
(37, 'new5', '', '', 0, 1),
(42, 'tessss', '1', '', 0, 1),
(43, 'dess', '1', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `checks`
--

CREATE TABLE `checks` (
  `check_id` int(11) NOT NULL,
  `check_no` varchar(250) DEFAULT NULL,
  `check_bank_name` varchar(250) DEFAULT NULL,
  `check_expiry_date` varchar(100) DEFAULT NULL,
  `check_type` varchar(100) DEFAULT NULL,
  `check_amount` varchar(100) DEFAULT NULL,
  `voucher_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `check_status` int(11) NOT NULL DEFAULT 0,
  `check_location` text DEFAULT NULL,
  `check_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `logo` text NOT NULL,
  `address` text DEFAULT NULL,
  `company_phone` varchar(100) NOT NULL,
  `personal_phone` varchar(100) NOT NULL,
  `email` text DEFAULT NULL,
  `stock_manage` int(11) NOT NULL,
  `sale_interface` varchar(50) DEFAULT NULL,
  `print_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `name`, `logo`, `address`, `company_phone`, `personal_phone`, `email`, `stock_manage`, `sale_interface`, `print_url`) VALUES
(5, 'AMG', 'user.png', 'P-160 Rachna Town # 1 Satyana Road Faisalabad', '03255455557', '', 'https://lasanibedsheets.com/', 1, 'gui', 'print_order.php');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(2000) NOT NULL,
  `customer_email` varchar(200) NOT NULL,
  `customer_phone` varchar(13) NOT NULL,
  `customer_address` text NOT NULL,
  `customer_area` int(11) DEFAULT NULL,
  `customer_status` int(255) NOT NULL,
  `customer_type` varchar(250) DEFAULT NULL,
  `customer_limit` varchar(10) NOT NULL DEFAULT '0',
  `customer_add_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_email`, `customer_phone`, `customer_address`, `customer_area`, `customer_status`, `customer_type`, `customer_limit`, `customer_add_date`) VALUES
(1, 'cash in hand', '', '03230641322', '', NULL, 1, 'bank', '0', '2025-06-27 15:24:51'),
(25, 'heilung pharmacetical company ', '', '031356622223', 'p-80 al qasim balosom view lasani pully sarghoda road faisalabad', 0, 1, 'supplier', '0', '2026-02-11 06:04:19'),
(26, 'new imran medicine company', '', '32423', 'fsd', 1, 1, 'customer', '0', '2026-02-13 09:43:31'),
(27, 'mian enterprises faisalabad', 'mianbest5570@gmail.com', '04343443', '67 jb sadhar', 3, 1, 'customer', '0', '2026-02-14 06:39:55'),
(28, '1', '', '34324', 'fsdfd', 4, 1, 'customer', '0', '2026-02-14 07:09:02'),
(29, 'dgsd', '', '35325', 'dsggdsg', 5, 1, 'customer', '0', '2026-02-14 07:09:15'),
(30, 'muhammad ahsan', 'mianbest5570@gmail.com', '45345', '67 jb sadhar', 6, 1, 'customer', '0', '2026-02-14 07:09:26'),
(31, 'muhammad ahsan', 'mianbest5570@gmail.com', '534543', '67 jb sadhar', 7, 1, 'customer', '0', '2026-02-14 07:09:37'),
(32, 'muhammad ahsan', 'mianbest5570@gmail.com', '45345', '67 jb sadhar', 7, 1, 'customer', '0', '2026-02-14 07:09:52'),
(33, 'muhammad ahsan', 'mianbest5570@gmail.com', '45345', '67 jb sadhar', 8, 1, 'customer', '0', '2026-02-14 07:10:03'),
(34, 'muhammad ahsan', 'mianbest5570@gmail.com', '546546', '67 jb sadhar', 9, 1, 'customer', '0', '2026-02-14 07:10:14'),
(35, 'muhammad ahsan', 'mianbest5570@gmail.com', '45654', '67 jb sadhar', 10, 1, 'customer', '0', '2026-02-14 07:10:32'),
(36, 'muhammad ahsan7546', 'mianbest5570@gmail.com', '456456', '67 jb sadhar', 11, 1, 'customer', '0', '2026-02-14 07:10:45'),
(37, 'muhammad ahsan', 'mianbest5570@gmail.com', '56546', '67 jb sadhar', 12, 1, 'customer', '0', '2026-02-14 07:10:56');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(11) NOT NULL,
  `expense_name` varchar(100) DEFAULT NULL,
  `expense_status` int(11) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `page` text DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `nav_edit` int(11) NOT NULL DEFAULT 0,
  `nav_delete` int(11) NOT NULL DEFAULT 0,
  `nav_add` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `title`, `page`, `parent_id`, `icon`, `sort_order`, `nav_edit`, `nav_delete`, `nav_add`, `timestamp`) VALUES
(97, 'accounts', '#', 0, 'fa fa-edit', 4, 1, 1, 1, '2024-08-06 06:28:41'),
(98, 'customers', 'customers.php?type=customer', 97, 'fa fa-edit', 4, 1, 1, 1, '2021-04-13 20:03:33'),
(99, 'banks', 'customers.php?type=bank', 97, 'fa fa-edit', 2, 1, 1, 1, '2021-04-13 20:03:33'),
(100, 'users', 'users.php', 97, 'fa fa-edit', 3, 1, 1, 1, '2021-04-13 20:03:33'),
(101, 'vouchers', '#', 0, 'fa fa-clipboard-list', 3, 0, 0, 0, '2024-08-06 06:29:01'),
(103, 'view vouchers', 'voucher.php?act=list', 101, 'fas fa-clipboard-list', 7, 1, 1, 1, '2021-04-13 20:03:33'),
(104, 'order', '#', 0, 'fas fa-cart-plus', 2, 0, 0, 0, '2024-08-06 06:29:01'),
(105, 'Cash Sale', 'cash_sale.php', 104, 'fas fa-cart-plus', 9, 1, 0, 1, '2021-04-13 20:03:33'),
(107, 'others', '#', 0, 'fa fa-edit', 8, 0, 0, 0, '2021-09-19 13:04:12'),
(108, 'Add Products', 'product.php?act=add', 148, 'fa fa-edit', 12, 1, 1, 1, '2021-09-19 13:01:26'),
(109, 'view products', 'product.php?act=list', 148, 'fa fa-edit', 13, 1, 1, 1, '2021-09-19 13:03:25'),
(110, 'brands', 'brands.php#', 107, 'fa fa-edit', 14, 1, 1, 1, '2021-04-13 20:03:34'),
(111, 'Credit Sale', 'credit_sale.php?credit_type=15days', 104, 'fa fa-edit', 15, 1, 1, 1, '2022-03-07 09:52:12'),
(112, 'purchase', '#', 0, 'fa fa-edit', 1, 0, 0, 0, '2024-08-06 06:29:01'),
(113, 'Cash Purchase', 'cash_purchase.php', 112, 'fa fa-edit', NULL, 1, 1, 1, '2021-04-13 22:33:37'),
(114, 'credit purchase', 'credit_purchase.php', 112, 'fa fa-edit', NULL, 1, 1, 1, '2021-04-13 22:34:31'),
(115, 'Reports', '#', 0, 'fa fa-edit', 6, 0, 0, 0, '2024-08-06 06:28:41'),
(116, 'bank ledger', 'reports.php?type=bank', 115, 'fa fa-edit', NULL, 1, 1, 1, '2021-04-14 21:03:11'),
(117, 'supplier ledger', 'reports.php?type=supplier', 115, 'fa fa-edit', NULL, 1, 0, 0, '2021-04-14 21:03:52'),
(118, 'customer ledger', 'reports.php?type=customer ', 115, 'fa-edit', NULL, 0, 0, 0, '2021-04-14 21:04:27'),
(119, 'view purchases', 'view_purchases.php', 112, 'add_to_queue', NULL, 1, 1, 1, '2021-04-15 21:17:07'),
(120, 'categories', 'categories.php', 107, 'fa fa-edit', NULL, 1, 1, 1, '2021-08-30 09:59:57'),
(121, 'supplier', 'customers.php?type=supplier', 97, 'fa fa-edit', NULL, 1, 1, 1, '2021-04-17 20:36:01'),
(122, 'expense ', 'customers.php?type=expense', 97, 'fa fa-edit', NULL, 1, 1, 1, '2021-04-17 20:41:42'),
(123, 'product purchase report', 'product_purchase_report.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-20 18:07:34'),
(125, 'product sale report', 'product_sale_report.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 19:48:47'),
(127, 'expense report', 'expence_report.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 20:11:51'),
(130, 'profit summary', 'profit_summary.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 20:12:58'),
(131, 'trail balance', 'trail_balance.php#', 115, 'fa fa-edit', 6, 0, 0, 0, '2021-06-02 23:19:37'),
(133, 'expense type', 'expense_type.php', 107, 'local_shipping', NULL, 0, 0, 0, '2021-06-10 19:04:02'),
(134, 'analytics', 'analytics.php', 0, 'local_shipping', 7, 0, 0, 0, '2024-08-06 06:28:41'),
(135, 'View Cash Sales', 'view_orders.php###', 104, 'local_shipping', NULL, 0, 0, 0, '2026-02-07 15:07:00'),
(136, 'view credit sales', 'credit_orders.php#', 104, 'local_shipping', NULL, 0, 0, 0, '2026-02-07 15:07:54'),
(137, 'analytics', 'analytics.php', 115, 'local_shipping', NULL, 0, 0, 0, '2021-08-29 17:56:15'),
(138, 'sale reports', 'sale_report.php#', 115, 'local_shipping', NULL, 0, 0, 0, '2026-02-13 10:40:00'),
(139, 'purchase reports', 'purchase_report.php#', 115, 'local_shipping', NULL, 0, 0, 0, '2026-02-13 10:40:19'),
(140, 'general voucher', 'voucher.php?act=general_voucher', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:42:27'),
(141, 'expense voucher', 'voucher.php?act=expense_voucher', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:43:15'),
(142, 'single voucher', 'voucher.php?act=single_voucher#', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:44:55'),
(143, 'backup & restore', 'backup.php', 107, 'local_shipping', NULL, 1, 0, 1, '2021-06-26 20:36:25'),
(144, 'pending cash bills ', 'pending_bills.php?search_it=all', 115, '', NULL, 0, 0, 0, '2021-08-20 19:43:20'),
(145, 'pending report', 'customerpendingreport.php#', 115, '', NULL, 0, 0, 0, '2026-02-13 10:38:41'),
(147, 'check list ', 'check_list.php', 101, '', NULL, 1, 1, 1, '2021-09-19 12:53:19'),
(148, 'products', '#', 0, '', 5, 0, 0, 0, '2024-08-06 06:28:41'),
(151, 'customer due report', 'reports3.php?type=customer##', 115, '', NULL, 0, 0, 0, '2026-02-13 10:39:06'),
(153, 'cash purchase return', 'cash_purchase_return.php###', 112, '', NULL, 1, 1, 1, '2025-06-16 06:04:08'),
(154, 'cash sale return', 'cash_sale_return.php#####', 104, '', NULL, 1, 1, 1, '2025-06-16 06:01:43'),
(155, 'credit sale return', 'credit_sale_return.php##', 104, '', NULL, 1, 1, 1, '2025-06-16 06:03:04'),
(156, 'view sale returns', 'view_sale_return.php###', 104, '', NULL, 1, 1, 1, '2025-06-16 06:00:33'),
(158, 'credit purchase return', 'credit_purchase_return.php##', 112, '', NULL, 1, 1, 1, '2025-06-16 06:04:43'),
(159, 'view purchase returns', 'view_purchase_return.php###', 112, '', NULL, 1, 1, 1, '2025-06-16 06:01:02'),
(160, 'areas', 'areas.php#', 107, '', NULL, 1, 1, 1, '2026-02-13 09:50:05'),
(161, 'product wise area wise sales report', 'product_area_wise_sale_report.php', 115, '', NULL, 0, 0, 0, '2026-02-13 10:37:27'),
(162, 'ssr report', 'ssr_report.php', 148, '', NULL, 0, 0, 0, '2026-02-14 10:51:26');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `transaction_paid_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `bill_no` varchar(255) NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `client_contact` varchar(255) NOT NULL,
  `sub_total` varchar(255) NOT NULL,
  `vat` varchar(255) NOT NULL,
  `total_amount` varchar(255) NOT NULL,
  `discount` varchar(255) NOT NULL,
  `cod` varchar(200) NOT NULL,
  `grand_total` varchar(255) NOT NULL,
  `paid` varchar(255) NOT NULL,
  `due` varchar(255) NOT NULL,
  `payment_type` varchar(30) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `customer_account` int(11) DEFAULT NULL,
  `payment_account` int(11) DEFAULT NULL,
  `order_status` varchar(20) NOT NULL DEFAULT '0',
  `address` varchar(500) NOT NULL,
  `charges` varchar(200) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `pending_order` varchar(1000) NOT NULL,
  `tracking` varchar(200) NOT NULL,
  `customer_profit` varchar(255) NOT NULL,
  `transaction_id` int(11) NOT NULL DEFAULT 0,
  `broker_id` int(11) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `delaytime` text DEFAULT NULL,
  `freight` text DEFAULT NULL,
  `order_narration` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `credit_sale_type` varchar(20) NOT NULL DEFAULT 'none',
  `vehicle_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `transaction_paid_id`, `order_date`, `bill_no`, `client_name`, `client_contact`, `sub_total`, `vat`, `total_amount`, `discount`, `cod`, `grand_total`, `paid`, `due`, `payment_type`, `payment_status`, `customer_account`, `payment_account`, `order_status`, `address`, `charges`, `note`, `pending_order`, `tracking`, `customer_profit`, `transaction_id`, `broker_id`, `type`, `delaytime`, `freight`, `order_narration`, `timestamp`, `credit_sale_type`, `vehicle_no`) VALUES
(37, 52, '2026-02-16', '', 'new imran medicine company', '32423', '', '', '79475', '0', '', '79475', '79475.00', '0', 'cash_in_hand', 1, 26, 1, '1', '', '', '', '', '', '', 0, NULL, NULL, NULL, '', '', '2026-02-16 06:18:14', 'none', ''),
(38, 0, '2026-02-16', '', 'mian enterprises faisalabad', '04343443', '', '', '7947.5', '0', '', '7947.5', '7947.5', '0', 'credit_sale', 1, 27, 1, '1', '', '', '', '', '', '', 53, NULL, NULL, NULL, '', '', '2026-02-16 06:28:34', '15days', '');

-- --------------------------------------------------------

--
-- Table structure for table `orders_return`
--

CREATE TABLE `orders_return` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_paid_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `bill_no` varchar(255) NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `client_contact` varchar(255) NOT NULL,
  `sub_total` varchar(255) NOT NULL,
  `vat` varchar(255) NOT NULL,
  `total_amount` varchar(255) NOT NULL,
  `discount` varchar(255) NOT NULL,
  `cod` varchar(200) NOT NULL,
  `grand_total` varchar(255) NOT NULL,
  `paid` varchar(255) NOT NULL,
  `due` varchar(255) NOT NULL,
  `payment_type` varchar(30) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `customer_account` int(11) DEFAULT NULL,
  `payment_account` int(11) DEFAULT NULL,
  `order_status` varchar(20) NOT NULL DEFAULT '0',
  `address` varchar(500) NOT NULL,
  `charges` varchar(200) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `pending_order` varchar(1000) NOT NULL,
  `tracking` varchar(200) NOT NULL,
  `customer_profit` varchar(255) NOT NULL,
  `transaction_id` int(11) NOT NULL DEFAULT 0,
  `broker_id` int(11) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `delaytime` text DEFAULT NULL,
  `freight` text DEFAULT NULL,
  `order_narration` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `credit_sale_type` varchar(20) NOT NULL DEFAULT 'none',
  `vehicle_no` varchar(100) DEFAULT NULL,
  `return_days` varchar(255) NOT NULL,
  `order_file` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `batch_id` int(11) DEFAULT NULL,
  `product_detail` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `order_item_status` int(11) NOT NULL DEFAULT 0,
  `discount` varchar(255) DEFAULT NULL,
  `gauge` text DEFAULT NULL,
  `width` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`order_item_id`, `order_id`, `product_id`, `batch_id`, `product_detail`, `quantity`, `rate`, `total`, `order_item_status`, `discount`, `gauge`, `width`) VALUES
(3, 37, 1, 35, NULL, 100, 794.75, 79475, 1, NULL, NULL, NULL),
(4, 38, 1, 35, 'undefined', 10, 794.75, 7947.5, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_return_item`
--

CREATE TABLE `order_return_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `branch_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT 0,
  `batch_id` int(11) DEFAULT NULL,
  `product_detail` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `rate` double NOT NULL,
  `final_rate` varchar(255) NOT NULL,
  `total` double NOT NULL,
  `order_item_status` int(11) NOT NULL DEFAULT 0,
  `discount` varchar(255) DEFAULT NULL,
  `gauge` text DEFAULT NULL,
  `width` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `privileges`
--

CREATE TABLE `privileges` (
  `privileges_id` int(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nav_id` int(11) NOT NULL,
  `nav_url` text NOT NULL,
  `addby` text NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `nav_add` int(11) NOT NULL DEFAULT 0,
  `nav_edit` int(11) NOT NULL DEFAULT 0,
  `nav_delete` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `privileges`
--

INSERT INTO `privileges` (`privileges_id`, `user_id`, `nav_id`, `nav_url`, `addby`, `date_time`, `nav_add`, `nav_edit`, `nav_delete`) VALUES
(332, 1, 98, 'customers.php?type=customer', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(333, 1, 99, 'customers.php?type=bank', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(334, 1, 100, 'users.php', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(335, 1, 102, 'voucher.php?act=add', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 0),
(336, 1, 103, 'voucher.php?act=list', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(337, 1, 105, 'cash_sale.php', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 0),
(338, 1, 106, 'view_orders.php', 'Added By: admin', '2021-04-15 21:26:49', 0, 0, 0),
(339, 1, 108, 'product.php?act=add#', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 0),
(340, 1, 109, 'product.php?act=list', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(341, 1, 110, 'brands.php#', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(342, 1, 111, 'credit_sale.php', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 0),
(343, 1, 113, 'cash_purchase.php', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(344, 1, 114, 'credit_purchase.php', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(345, 1, 116, 'reports.php?type=bank', 'Added By: admin', '2021-04-15 21:26:49', 1, 0, 1),
(346, 1, 117, 'reports.php?type=supplier', 'Added By: admin', '2021-04-15 21:26:49', 0, 0, 0),
(347, 1, 118, 'reports.php?type=customer ', 'Added By: admin', '2021-04-15 21:26:49', 0, 0, 0),
(348, 1, 119, 'view_purchases.php', 'Added By: admin', '2021-04-15 21:26:49', 0, 0, 0),
(349, 1, 0, '', 'Added By: admin', '2021-04-15 21:26:49', 0, 0, 0),
(386, 2, 98, 'customers.php?type=customer', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(387, 2, 99, 'customers.php?type=bank', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(388, 2, 100, 'users.php', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(389, 2, 102, 'voucher.php?act=add', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 0),
(390, 2, 103, 'voucher.php?act=list', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(391, 2, 105, 'cash_sale.php', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 0),
(392, 2, 106, 'view_orders.php', 'Added By: admin', '2021-06-04 21:43:16', 0, 0, 0),
(393, 2, 108, 'product.php?act=add#', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 0),
(394, 2, 109, 'product.php?act=list', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(395, 2, 110, 'brands.php#', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(396, 2, 111, 'credit_sale.php?credit_type=30days', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(397, 2, 113, 'cash_purchase.php', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 1),
(398, 2, 114, 'credit_purchase.php', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 0),
(399, 2, 116, 'reports.php?type=bank', 'Added By: admin', '2021-06-04 21:43:16', 0, 0, 0),
(400, 2, 117, 'reports.php?type=supplier', 'Added By: admin', '2021-06-04 21:43:16', 0, 0, 1),
(401, 2, 118, 'reports.php?type=customer ', 'Added By: admin', '2021-06-04 21:43:16', 1, 0, 0),
(402, 2, 119, 'view_purchases.php', 'Added By: admin', '2021-06-04 21:43:16', 0, 0, 0),
(403, 5, 0, 'voucher.php?act=general_voucher', 'Added By: admin', '2022-01-24 06:43:14', 1, 0, 0),
(1323, 5, 98, 'customers.php?type=customer', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 1),
(1324, 5, 99, 'customers.php?type=bank', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 1),
(1325, 5, 103, 'users.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1326, 5, 105, 'voucher.php?act=list', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1327, 5, 108, 'cash_sale.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1328, 5, 109, 'product.php?act=add', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1329, 5, 110, 'product.php?act=list', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1330, 5, 111, 'brands.php#', 'Added By: admin', '2022-01-23 13:40:10', 1, 1, 0),
(1331, 5, 117, 'credit_sale.php?credit_type=15days', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1332, 5, 118, 'cash_purchase.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1333, 5, 119, 'credit_purchase.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1334, 5, 120, 'reports.php?type=bank', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1335, 5, 121, 'reports.php?type=supplier', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1336, 5, 122, 'reports.php?type=customer ', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1337, 5, 123, 'view_purchases.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1338, 5, 125, 'categories.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1339, 5, 127, 'customers.php?type=supplier', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1340, 5, 132, 'customers.php?type=expense', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1341, 5, 133, 'product_purchase_report.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1342, 5, 135, 'product_sale_report.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1343, 5, 136, 'expence_report.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1344, 5, 138, 'income_report.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1345, 5, 139, 'profit_loss.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1346, 5, 140, 'profit_summary.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1347, 5, 141, 'trail_balance.php#', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1348, 5, 143, 'credit_sale.php?credit_type=30days', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1349, 5, 144, 'expense_type.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1350, 5, 146, 'analytics.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1351, 5, 147, 'view_orders.php#', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1352, 5, 149, 'credit_orders.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1353, 5, 150, 'analytics.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1354, 5, 151, 'sale_report.php', 'Added By: admin', '2022-01-23 13:40:10', 1, 0, 0),
(1355, 5, 0, 'purchase_report.php', 'Added By: admin', '2022-01-23 13:40:10', 0, 0, 0),
(1400, 6, 98, 'customers.php?type=customer', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1401, 6, 99, 'customers.php?type=bank', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1402, 6, 103, 'users.php', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1403, 6, 105, 'voucher.php?act=list', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1404, 6, 108, 'cash_sale.php', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1405, 6, 109, 'product.php?act=add', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1406, 6, 110, 'product.php?act=list', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1407, 6, 111, 'brands.php#', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1408, 6, 0, 'credit_sale.php?credit_type=15days', 'Added By: admin', '2024-12-11 12:09:26', 1, 0, 0),
(1409, 8, 100, 'customers.php?type=customer', 'Added By: admin', '2025-10-02 07:13:51', 1, 1, 0),
(1410, 8, 0, 'customers.php?type=bank', 'Added By: admin', '2025-10-02 07:13:51', 0, 0, 0),
(1411, 9, 105, 'customers.php?type=customer', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1412, 9, 111, 'customers.php?type=bank', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1413, 9, 113, 'users.php', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1414, 9, 114, 'voucher.php?act=list', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1415, 9, 119, 'cash_sale.php', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1416, 9, 135, 'product.php?act=add', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1417, 9, 136, 'product.php?act=list', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0),
(1418, 9, 0, 'brands.php#', 'Added By: admin', '2026-01-13 10:22:18', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(200) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_pack` varchar(255) DEFAULT NULL,
  `product_code` varchar(250) DEFAULT NULL,
  `product_image` text NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `quantity_instock` double NOT NULL,
  `purchased` double NOT NULL,
  `current_rate` double NOT NULL,
  `f_days` text DEFAULT NULL,
  `t_days` text DEFAULT NULL,
  `purchase_rate` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `availability` int(11) DEFAULT 0,
  `alert_at` double DEFAULT 5,
  `weight` varchar(200) NOT NULL,
  `actual_rate` varchar(250) DEFAULT NULL,
  `product_description` text DEFAULT NULL,
  `product_mm` varchar(100) NOT NULL DEFAULT '0',
  `product_inch` varchar(100) DEFAULT '0',
  `product_meter` varchar(100) NOT NULL DEFAULT '0',
  `adddatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `inventory` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_pack`, `product_code`, `product_image`, `brand_id`, `category_id`, `quantity_instock`, `purchased`, `current_rate`, `f_days`, `t_days`, `purchase_rate`, `status`, `availability`, `alert_at`, `weight`, `actual_rate`, `product_description`, `product_mm`, `product_inch`, `product_meter`, `adddatetime`, `inventory`) VALUES
(1, 'caradex 30 mg ', '30', '25l019', '', 1, 1, 136, 0, 794.75, '', '', 794.75, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:26:02', 0),
(2, 'caradex 60mg cap', '30s', '25j031', '', 2, 2, 281, 0, 1198.5, '', '', 1198.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:55', 0),
(3, 'iron-p tab ', '30s', '14', '', 3, 3, 654, 0, 586.5, '', '', 586.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(4, 'cefpec inj 2g', '1s', 'fp-87', '', 4, 4, 178, 0, 629, '', '', 629, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:09', 0),
(5, 'ciptop tab 500mg ', '10s', 'cp-84', '', 5, 5, 320, 0, 320.45, '', '', 320.45, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(6, 'ketowise inj 1ml ', '1ml*5', '6', '', 6, 6, 685, 0, 663, '', '', 663, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(7, 'r-eze syp 120 ml ', '1s', '7', '', 7, 7, 1399, 0, 297.5, '', '', 297.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(8, 'omson inj 40mg ', '1 vial ', '8', '', 8, 8, 1269, 0, 447.95, '', '', 447.95, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:13', 0),
(9, 'ov-m ', '10 satet', '9', '', 9, 9, 47, 0, 719.1, '', '', 719.1, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:36', 0),
(10, 'cefpec inj 1gm', '1s', '11', '', 10, 10, 264, 0, 459, '', '', 459, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:00', 0),
(11, 'sg kal 120ml syp ', '1s', '12', '', 11, 11, 400, 0, 289, '', '', 289, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(12, 'neropenem inj 500mg ', '1s', '13', '', 12, 12, 65, 0, 1422.05, '', '', 1422.05, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:39', 0),
(13, 'neropenem inj 1gm ', '1s', '15', '', 13, 13, 180, 0, 2760.8, '', '', 2760.8, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:43', 0),
(14, 'ciptop sus 125mg', '1s', '16', '', 14, 14, 374, 0, 163.2, '', '', 163.2, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:03', 0),
(15, 'dia-go cap', '30 cap', '17', '', 15, 15, 156, 0, 1785, '', '', 1785, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(16, 'od q-10 tab ', '30s', '19', '', 16, 16, 354, 0, 1827.5, '', '', 1827.75, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(17, 'nerfit tab ', '30s', '20', '', 17, 17, 5834, 0, 1190, '', '', 1190, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:13', 0),
(18, 'santosa tab ', '20s', '21', '', 18, 18, 840, 0, 561, '', '', 561, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(19, 'ciptop tab 250mg ', '20s', '22', '', 19, 19, 410, 0, 193.8, '', '', 193.8, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:03', 0),
(20, 'sg kal tab ', '30s', '23', '', 20, 20, 20, 0, 756.5, '', '', 756.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(21, 'estarown tab 10mg ', '20s', '24', '', 21, 21, 1620, 0, 382.5, '', '', 382.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(22, 'axigon tab 550mg ', '10s', '25', '', 22, 22, 200, 0, 1096.5, '', '', 1096.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:13', 0),
(23, 'ginobit tab ', '30s', '26', '', 23, 23, 460, 0, 1275, '', '', 1275, 1, 1, 5, '', '', '', '', '', '', '2026-02-11 09:52:16', 0),
(24, 'iris inj 100mg', '5s', '27', '', 24, 24, 225, 0, 1997.5, '', '', 1997.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:39', 0),
(25, 'cholewise-d oral amp', '1s', '28', '', 25, 25, 1032, 0, 238, '', '', 238, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(26, 'sita-wis tab 50/500', '10s', '29', '', 26, 26, 864, 0, 382.5, '', '', 382.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:50', 0),
(27, 'montrial tab 10mg', '14s', '30', '', 27, 27, 270, 0, 467.5, '', '', 467.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(28, 'danalac lf 200g', '1s', '31', '', 28, 28, 690, 0, 930, '', '', 930, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(29, 'danalac 1 200g ', '1s', '32', '', 29, 29, 1218, 0, 930, '', '', 930, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:26', 0),
(30, 'danalac mama 200g', '1s', '33', '', 30, 30, 56, 0, 930, '', '', 930, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:36', 0),
(31, 'sg labam powder 400g', '1s', '34', '', 31, 31, 711, 0, 2700, '', '', 2700, 1, 1, 5, '', '', '', '', '', '', '2026-02-12 06:32:28', 0),
(32, 'danalac lf 400g', '1s', '35', '', 32, 32, 216, 0, 2209, '', '', 2209, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:30', 0),
(33, 'dia-go 200g', '1s', '36', '', 33, 33, 40, 0, 930, '', '', 930, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:02:30', 0),
(34, 'hacer syp 120ml', '1s', '38', '', 34, 34, 2445, 0, 246.5, '', '', 246.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:03:32', 0),
(35, 'ciotop sus 250mg ', '1s', '40', '', 35, 35, 0, 0, 0, '', '', 297.5, 1, 1, 5, '', '', '', '', '', '', '2026-02-12 08:43:00', 0),
(36, 'ciptop sus 250mg ', '1s', '41', '', 36, 36, 187, 0, 0, '0', '0', 0, 1, 1, 5, '', '', '', '', '', '', '2026-02-13 12:02:37', 0),
(37, 'ventrum tab ', '20s', '42', '', 37, 37, 1303, 0, 0, '0', '0', 0, 1, 1, 5, '', '', '', '', '', '', '2026-02-16 06:04:09', 0),
(38, 'tessss', '40', '34234', '', 38, 41, 0, 0, 0, '0', '0', 0, 0, 1, 5, '', '', '', '', '', '', '2026-02-13 12:26:52', 0),
(39, 'testingmodal', '', '34442', '', 1, 36, 0, 0, 300, '', '', 0, 0, 0, 0, '', '', '', '', '', '', '2026-02-14 06:42:01', 0),
(40, 'testingds', '', '534534', '', 39, 42, 0, 0, 400, '', '', 0, 0, 0, 0, '', '', 'dfdsfsd', '', '', '', '2026-02-14 06:42:05', 0),
(41, 'newsss', '', '3434324', '', 40, 43, 0, 0, 300, '', '', 0, 0, 0, 0, '', '', 'dfdfsf', '', '', '', '2026-02-14 06:42:08', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `expiry_date` date NOT NULL,
  `qty_in` int(11) NOT NULL DEFAULT 0,
  `qty_out` int(11) NOT NULL DEFAULT 0,
  `available_qty` int(11) NOT NULL DEFAULT 0,
  `purchase_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`batch_id`, `product_id`, `batch_no`, `expiry_date`, `qty_in`, `qty_out`, `available_qty`, `purchase_id`, `created_at`, `updated_at`) VALUES
(1, 23, '001', '2026-10-31', 460, 0, 460, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(2, 22, '001', '2026-11-30', 200, 0, 200, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:13'),
(3, 2, '25j031', '2027-08-31', 35, 0, 35, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:55'),
(4, 12, '26a004', '2027-12-31', 65, 0, 65, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:39'),
(5, 8, 'osi016', '2027-02-28', 1269, 0, 1269, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:13'),
(6, 15, '01', '2026-11-30', 156, 0, 156, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(7, 3, '14', '2027-03-31', 654, 0, 654, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(8, 17, '960', '2027-09-30', 634, 0, 634, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:13'),
(9, 16, '608', '2026-10-31', 354, 0, 354, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(10, 9, '929', '2027-08-31', 47, 0, 47, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:36'),
(11, 32, '002', '2026-12-31', 216, 0, 216, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:30'),
(12, 7, 'rz002', '2027-09-30', 1399, 0, 1399, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(13, 10, 'f-68', '0027-05-31', 4, 0, 4, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:00'),
(14, 10, 'f-70', '2027-10-31', 260, 0, 260, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:00'),
(15, 4, 'fp-88', '2027-10-31', 146, 0, 146, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:09'),
(16, 25, 'cw-023', '2027-08-31', 369, 0, 369, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(17, 5, 'cp-84', '2027-08-31', 170, 0, 170, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(18, 28, 'hd0010', '2027-11-30', 168, 0, 168, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(19, 30, 'hd0004', '2027-10-30', 56, 0, 56, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(20, 33, 'hd0004', '2027-05-31', 40, 0, 40, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:30'),
(21, 24, 'ir-013', '2027-04-30', 225, 0, 225, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:39'),
(22, 6, 'kt-029', '2027-08-31', 35, 0, 35, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(23, 6, 'kt-030', '2027-10-31', 250, 0, 250, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(24, 11, 'sg002', '2027-03-31', 400, 0, 400, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(25, 20, 'he006', '2027-03-31', 20, 0, 20, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(26, 31, '008', '2027-03-31', 140, 0, 140, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(27, 18, 's-48', '2027-10-31', 840, 0, 840, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(28, 26, 'sw-34', '2027-09-30', 864, 0, 864, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:50'),
(29, 4, 'fp-86', '2027-05-31', 11, 0, 11, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(30, 19, 'c-77', '2027-03-31', 236, 0, 236, 1, '2026-02-11 09:52:16', '2026-02-16 06:02:50'),
(31, 21, '1035', '2026-11-30', 1620, 0, 1620, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(32, 27, 'mt-36', '2027-03-31', 70, 0, 70, 1, '2026-02-11 09:52:16', '2026-02-16 06:03:36'),
(33, 4, 'fp-87', '2027-08-31', 21, 0, 21, 1, '2026-02-11 09:52:16', '2026-02-11 09:52:16'),
(34, 19, 'c-78', '2027-05-31', 174, 0, 174, 2, '2026-02-12 06:14:03', '2026-02-16 06:03:03'),
(35, 1, '25l019', '2027-10-31', 246, 110, 136, 3, '2026-02-12 06:22:11', '2026-02-16 06:26:02'),
(36, 2, '25l020', '2027-10-31', 246, 0, 246, 3, '2026-02-12 06:22:11', '2026-02-16 06:03:40'),
(37, 29, 'hd006', '2027-11-30', 1218, 0, 1218, 3, '2026-02-12 06:22:11', '2026-02-16 06:03:26'),
(38, 34, 'he012', '2027-05-31', 1640, 0, 1640, 4, '2026-02-12 06:27:47', '2026-02-16 06:03:32'),
(39, 34, 'he013', '2027-05-31', 805, 0, 805, 5, '2026-02-12 06:29:45', '2026-02-16 06:03:29'),
(40, 31, '008', '2027-07-31', 28, 0, 28, 6, '2026-02-12 06:32:28', '2026-02-12 06:32:28'),
(41, 31, '26023', '2027-12-31', 515, 0, 515, 6, '2026-02-12 06:32:28', '2026-02-12 06:32:28'),
(42, 31, '007', '2027-07-31', 28, 0, 28, 6, '2026-02-12 06:32:28', '2026-02-12 06:32:28'),
(43, 17, '1069', '2027-12-31', 5200, 0, 5200, 9, '2026-02-12 08:13:50', '2026-02-16 06:03:13'),
(44, 25, 'cw-023', '2027-08-30', 663, 0, 663, 10, '2026-02-12 08:55:42', '2026-02-16 06:02:27'),
(45, 14, 'cx-24', '2027-07-31', 374, 0, 374, 10, '2026-02-12 08:55:42', '2026-02-16 06:03:03'),
(46, 36, 'cf-14', '2027-09-30', 187, 0, 187, 10, '2026-02-12 08:55:42', '2026-02-12 08:55:42'),
(47, 5, 'cp-84', '2027-08-30', 45, 0, 45, 10, '2026-02-12 08:55:42', '2026-02-12 08:55:42'),
(48, 5, 'cp-85', '2027-08-30', 105, 0, 105, 10, '2026-02-12 08:55:42', '2026-02-12 08:55:42'),
(49, 27, 'mt-37', '2027-12-31', 200, 0, 200, 10, '2026-02-12 08:55:42', '2026-02-16 06:03:13'),
(50, 6, 'kt-030', '2027-10-30', 400, 0, 400, 10, '2026-02-12 08:55:42', '2026-02-16 06:03:00'),
(51, 28, 'hd 0010', '2027-11-30', 522, 0, 522, 11, '2026-02-12 10:24:49', '2026-02-16 06:02:47'),
(52, 13, '26a002', '2027-12-31', 180, 0, 180, 12, '2026-02-12 10:32:04', '2026-02-16 06:02:43'),
(53, 37, '949', '2027-08-31', 1303, 0, 1303, 13, '2026-02-12 10:45:13', '2026-02-16 06:04:09');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchase_id` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `bill_no` varchar(255) NOT NULL,
  `client_contact` varchar(255) NOT NULL,
  `sub_total` varchar(255) NOT NULL,
  `vat` varchar(255) NOT NULL,
  `total_amount` varchar(255) NOT NULL,
  `discount` varchar(255) NOT NULL,
  `grand_total` varchar(255) NOT NULL,
  `paid` varchar(255) NOT NULL,
  `due` varchar(255) NOT NULL,
  `payment_type` varchar(30) DEFAULT NULL,
  `payment_account` int(11) DEFAULT NULL,
  `customer_account` int(11) DEFAULT NULL,
  `payment_status` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_paid_id` int(11) NOT NULL,
  `purchase_narration` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`purchase_id`, `purchase_date`, `client_name`, `bill_no`, `client_contact`, `sub_total`, `vat`, `total_amount`, `discount`, `grand_total`, `paid`, `due`, `payment_type`, `payment_account`, `customer_account`, `payment_status`, `transaction_id`, `transaction_paid_id`, `purchase_narration`, `timestamp`) VALUES
(1, '2026-02-11', 'heilung pharmacetical company ', '1383', '03135662222', '', '', '7194594.6', '0', '7194594.6', '7194594', '0.59999999962747', 'cash_purchase', 1, 25, 1, 0, 1, '', '2026-02-11 09:52:16'),
(2, '2026-02-12', 'heilung pharmacetical company ', '', '03135662222', '', '', '33721.2', '0', '33721.2', '33721', '0.20000000000437', 'cash_purchase', 1, 25, 1, 0, 2, '', '2026-02-12 06:14:03'),
(3, '2026-02-12', 'heilung pharmacetical company ', '1386', '03135662222', '', '', '706099.5', '0', '706099.5', '706099', '0.5', 'cash_purchase', 1, 25, 1, 0, 3, '', '2026-02-12 06:22:11'),
(4, '2026-02-12', 'heilung pharmacetical company ', '1396', '03135662222', '', '', '348500', '0', '348500', '348500.00', '0', 'cash_purchase', 1, 25, 1, 0, 4, '', '2026-02-12 06:27:47'),
(5, '2026-02-12', 'heilung pharmacetical company ', '1397', '03135662222', '', '', '198432.5', '0', '198432.5', '198432', '0.5', 'cash_purchase', 1, 25, 1, 0, 5, '', '2026-02-12 06:29:45'),
(6, '2026-02-12', 'heilung pharmacetical company ', '1399', '03135662222', '', '', '1541700', '0', '1541700', '1541700.00', '0', 'cash_purchase', 1, 25, 1, 0, 6, '', '2026-02-12 06:32:28'),
(7, '2026-02-12', 'heilung pharmacetical company ', '1405', '03135662222', '', '', '656580', '0', '656580', '656580.00', '0', 'cash_purchase', 1, 25, 1, 0, 12, '', '2026-02-12 08:11:35'),
(8, '2026-02-12', 'heilung pharmacetical company ', '1403', '03135662222', '', '', '260400', '0', '260400', '260400.00', '0', 'cash_purchase', 1, 25, 1, 0, 13, '', '2026-02-12 08:12:40'),
(9, '2026-02-12', 'heilung pharmacetical company ', '1410', '03135662222', '', '', '6188000', '0', '6188000', '6188000.00', '0', 'cash_purchase', 1, 25, 1, 0, 14, '', '2026-02-12 08:13:50'),
(10, '2026-02-12', 'heilung pharmacetical company ', '113', '03135662222', '', '', '681230.8', '0', '681230.8', '681230', '0.80000000004657', 'cash_purchase', 1, 25, 1, 0, 19, '', '2026-02-12 08:55:42'),
(11, '2026-02-12', 'heilung pharmacetical company ', '', '03135662222', '', '', '485460', '0', '485460', '485460.00', '0', 'cash_purchase', 1, 25, 1, 0, 28, '', '2026-02-12 10:24:49'),
(12, '2026-02-12', 'heilung pharmacetical company ', '1436', '03135662222', '', '', '496944', '0', '496944', '496944.00', '5.8207660913467E-11', 'cash_purchase', 1, 25, 1, 0, 30, '', '2026-02-12 10:32:04'),
(13, '2026-02-12', 'heilung pharmacetical company ', '', '03135662222', '', '', '1235730', '0', '1235730', '1235730.00', '0', 'cash_purchase', 1, 25, 1, 0, 33, '', '2026-02-12 10:45:13');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_item`
--

CREATE TABLE `purchase_item` (
  `purchase_item_id` int(255) NOT NULL,
  `purchase_id` int(255) NOT NULL,
  `product_id` int(255) NOT NULL,
  `batch_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `expiry_date` date NOT NULL,
  `product_detail` text DEFAULT NULL,
  `quantity` varchar(255) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `sale_rate` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `purchase_item_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `purchase_item`
--

INSERT INTO `purchase_item` (`purchase_item_id`, `purchase_id`, `product_id`, `batch_no`, `expiry_date`, `product_detail`, `quantity`, `rate`, `sale_rate`, `total`, `purchase_item_status`) VALUES
(1, 1, 23, '001', '2026-10-31', '', '460', '1275', '1275', '586500', 1),
(2, 1, 22, '001', '2026-11-30', '', '200', '1096.5', '1096.5', '219300', 1),
(3, 1, 2, '25j031', '2027-08-31', '', '35', '1198.5', '1198.5', '41947.5', 1),
(4, 1, 12, '26a004', '2027-12-31', '', '65', '1422.05', '1422.05', '92433.25', 1),
(5, 1, 8, 'osi016', '2027-02-28', '', '1269', '447.95', '447.95', '568448.55', 1),
(6, 1, 15, '01', '2026-11-30', '', '156', '1785', '1785', '278460', 1),
(7, 1, 3, '14', '2027-03-31', '', '654', '586.5', '586.5', '383571', 1),
(8, 1, 17, '960', '2027-09-30', '', '154', '1190', '1190', '183260', 1),
(9, 1, 16, '608', '2026-10-31', '', '354', '1827.75', '1827.5', '647023.5', 1),
(10, 1, 9, '929', '2027-08-31', '', '47', '719.1', '719.1', '33797.7', 1),
(11, 1, 32, '002', '2026-12-31', '', '216', '2209', '2209', '477144', 1),
(12, 1, 7, 'rz002', '2027-09-30', '', '1399', '297.5', '297.5', '416202.5', 1),
(13, 1, 10, 'f-68', '0027-05-31', '', '4', '459', '459', '1836', 1),
(14, 1, 10, 'f-70', '2027-10-31', '', '260', '459', '459', '119340', 1),
(15, 1, 4, 'fp-88', '2027-10-31', '', '146', '629', '629', '91834', 1),
(16, 1, 25, 'cw-023', '2027-08-31', '', '369', '238', '238', '87822', 1),
(17, 1, 5, 'cp-84', '2027-08-31', '', '170', '320.45', '320.45', '54476.5', 1),
(18, 1, 28, 'hd0010', '2027-11-30', '', '168', '930', '930', '156240', 1),
(19, 1, 30, 'hd0004', '2027-10-30', '', '56', '930', '930', '52080', 1),
(20, 1, 33, 'hd0004', '2027-05-31', '', '40', '930', '930', '37200', 1),
(21, 1, 24, 'ir-013', '2027-04-30', '', '225', '1997.5', '1997.5', '449437.5', 1),
(22, 1, 6, 'kt-029', '2027-08-31', '', '35', '663', '663', '23205', 1),
(23, 1, 6, 'kt-030', '2027-10-31', '', '250', '663', '663', '165750', 1),
(24, 1, 11, 'sg002', '2027-03-31', '', '400', '289', '289', '115600', 1),
(25, 1, 20, 'he006', '2027-03-31', '', '20', '756.5', '756.5', '15130', 1),
(26, 1, 31, '008', '2027-03-31', '', '140', '2700', '2700', '378000', 1),
(27, 1, 18, 's-48', '2027-10-31', '', '840', '561', '561', '471240', 1),
(28, 1, 26, 'sw-34', '2027-09-30', '', '864', '382.5', '382.5', '330480', 1),
(29, 1, 4, 'fp-86', '2027-05-31', '', '11', '629', '629', '6919', 1),
(30, 1, 19, 'c-77', '2027-03-31', '', '236', '187.85', '187.85', '44332.6', 1),
(31, 1, 21, '1035', '2026-11-30', '', '1620', '382.5', '382.5', '619650', 1),
(32, 1, 27, 'mt-36', '2027-03-31', '', '70', '467.5', '467.5', '32725', 1),
(33, 1, 4, 'fp-87', '2027-08-31', '', '21', '629', '629', '13209', 1),
(34, 2, 19, 'c-78', '2027-05-31', '', '174', '193.8', '193.8', '33721.2', 1),
(35, 3, 1, '25l019', '2027-10-31', '', '246', '794.75', '794.75', '195508.5', 1),
(36, 3, 2, '25l020', '2027-10-31', '', '246', '1198.5', '1198.5', '294831', 1),
(37, 3, 29, 'hd006', '2027-11-30', '', '232', '930', '930', '215760', 1),
(38, 4, 34, 'he012', '2027-05-31', '', '1640', '212.5', '212.5', '348500', 1),
(39, 5, 34, 'he013', '2027-05-31', '', '805', '246.5', '246.5', '198432.5', 1),
(40, 6, 31, '008', '2027-07-31', '', '28', '2700', '2700', '75600', 1),
(41, 6, 31, '26023', '2027-12-31', '', '515', '2700', '2700', '1390500', 1),
(42, 6, 31, '007', '2027-07-31', '', '28', '2700', '2700', '75600', 1),
(43, 7, 29, 'hd006', '2027-11-30', '', '706', '930', '930', '656580', 1),
(44, 8, 29, 'hd006', '2027-11-30', '', '280', '930', '930', '260400', 1),
(45, 9, 17, '1069', '2027-12-31', '', '5200', '1190', '1190', '6188000', 1),
(46, 10, 25, 'cw-023', '2027-08-30', '', '663', '238', '238', '157794', 1),
(47, 10, 14, 'cx-24', '2027-07-31', '', '374', '163.2', '163.2', '61036.8', 1),
(48, 10, 36, 'cf-14', '2027-09-30', '', '187', '297.5', '297.5', '55632.5', 1),
(49, 10, 5, 'cp-84', '2027-08-30', '', '45', '320.45', '320.45', '14420.25', 1),
(50, 10, 5, 'cp-85', '2027-08-30', '', '105', '320.45', '320.45', '33647.25', 1),
(51, 10, 27, 'mt-37', '2027-12-31', '', '200', '467.5', '467.5', '93500', 1),
(52, 10, 6, 'kt-030', '2027-10-30', '', '400', '663', '663', '265200', 1),
(53, 11, 28, 'hd 0010', '2027-11-30', '', '522', '930', '930', '485460', 1),
(54, 12, 13, '26a002', '2027-12-31', '', '180', '2760.8', '2760.8', '496944', 1),
(55, 13, 37, '949', '2027-08-31', '', '1303', '510', '510', '664530', 1),
(56, 13, 17, '960', '2027-09-30', '', '480', '1190', '1190', '571200', 1);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return`
--

CREATE TABLE `purchase_return` (
  `purchase_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_date` date NOT NULL,
  `client_name` varchar(255) NOT NULL,
  `bill_no` varchar(255) NOT NULL,
  `client_contact` varchar(255) NOT NULL,
  `sub_total` varchar(255) NOT NULL,
  `vat` varchar(255) NOT NULL,
  `total_amount` varchar(255) NOT NULL,
  `discount` varchar(255) NOT NULL,
  `grand_total` varchar(255) NOT NULL,
  `paid` varchar(255) NOT NULL,
  `due` varchar(255) NOT NULL,
  `payment_type` varchar(30) DEFAULT NULL,
  `payment_account` int(11) DEFAULT NULL,
  `customer_account` int(11) DEFAULT NULL,
  `payment_status` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `transaction_paid_id` int(11) NOT NULL,
  `purchase_narration` text DEFAULT NULL,
  `purchase_file` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_item`
--

CREATE TABLE `purchase_return_item` (
  `purchase_item_id` int(255) NOT NULL,
  `purchase_id` int(255) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(255) NOT NULL,
  `batch_id` int(11) DEFAULT NULL,
  `product_detail` text DEFAULT NULL,
  `quantity` varchar(255) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `sale_rate` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `purchase_item_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `debit` varchar(100) NOT NULL,
  `credit` varchar(100) NOT NULL,
  `balance` varchar(100) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `transaction_remarks` text NOT NULL,
  `transaction_add_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `transaction_date` text DEFAULT NULL,
  `transaction_type` text DEFAULT NULL,
  `transaction_from` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `debit`, `credit`, `balance`, `customer_id`, `transaction_remarks`, `transaction_add_date`, `transaction_date`, `transaction_type`, `transaction_from`) VALUES
(1, '7194594', '0', '', 1, 'purchased by purchased id#1', '2026-02-11 09:52:16', '2026-02-11', 'cash_purchase', 'purchase'),
(2, '33721', '0', '', 1, 'purchased by purchased id#2', '2026-02-12 06:14:03', '2026-02-12', 'cash_purchase', 'purchase'),
(3, '706099', '0', '', 1, 'purchased by purchased id#3', '2026-02-12 06:22:11', '2026-02-12', 'cash_purchase', 'purchase'),
(4, '348500.00', '0', '', 1, 'purchased by purchased id#4', '2026-02-12 06:27:47', '2026-02-12', 'cash_purchase', 'purchase'),
(5, '198432', '0', '', 1, 'purchased by purchased id#5', '2026-02-12 06:29:45', '2026-02-12', 'cash_purchase', 'purchase'),
(6, '1541700.00', '0', '', 1, 'purchased by purchased id#6', '2026-02-12 06:32:28', '2026-02-12', 'cash_purchase', 'purchase'),
(12, '656580.00', '0', '', 1, 'purchased by purchased id#7', '2026-02-12 08:11:35', '2026-02-12', 'cash_purchase', 'purchase'),
(13, '260400.00', '0', '', 1, 'purchased by purchased id#8', '2026-02-12 08:12:40', '2026-02-12', 'cash_purchase', 'purchase'),
(14, '6188000.00', '0', '', 1, 'purchased by purchased id#9', '2026-02-12 08:13:50', '2026-02-12', 'cash_purchase', 'purchase'),
(19, '681230', '0', '', 1, 'purchased by purchased id#10', '2026-02-12 08:55:42', '2026-02-12', 'cash_purchase', 'purchase'),
(28, '485460.00', '0', '', 1, 'purchased by purchased id#11', '2026-02-12 10:24:49', '2026-02-12', 'cash_purchase', 'purchase'),
(30, '496944.00', '0', '', 1, 'purchased by purchased id#12', '2026-02-12 10:32:04', '2026-02-12', 'cash_purchase', 'purchase'),
(33, '1235730.00', '0', '', 1, 'purchased by purchased id#13', '2026-02-12 10:45:13', '2026-02-12', 'cash_purchase', 'purchase'),
(52, '0', '79475.00', '', 1, 'cash_sale by order id#37', '2026-02-16 06:14:24', '2026-02-16', 'cash_in_hand', 'invoice'),
(53, '0', '7947.5', '', 27, 'credit_sale by order id#38', '2026-02-16 06:26:02', '2026-02-16', 'credit_sale', 'invoice');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` text NOT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `address` text NOT NULL,
  `phone` text NOT NULL,
  `user_role` text NOT NULL,
  `status` text NOT NULL,
  `adddatetime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `fullname`, `email`, `password`, `address`, `phone`, `user_role`, `status`, `adddatetime`) VALUES
(1, 'admin', 'Ahsan Malik ', 'a.ttraders909@gmail.com', '21232f297a57a5a743894a0e4a801fc3', 'fsd', '1234567', 'admin', '1', '2022-12-08 13:38:04'),
(5, 'test', '', 'ali@polybags.com', '098f6bcd4621d373cade4e832627b4f6', 'fsd', '03057442934', 'admin', '1', '2025-06-16 07:26:00');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `voucher_id` int(11) NOT NULL,
  `customer_id1` varchar(250) DEFAULT NULL,
  `customer_id2` varchar(250) DEFAULT NULL,
  `addby_user_id` int(11) DEFAULT NULL,
  `editby_user_id` int(11) DEFAULT NULL,
  `voucher_amount` varchar(250) NOT NULL,
  `transaction_id1` varchar(250) DEFAULT NULL,
  `transaction_id2` varchar(250) DEFAULT NULL,
  `voucher_hint` text DEFAULT NULL,
  `voucher_date` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `voucher_type` varchar(100) DEFAULT NULL,
  `voucher_group` varchar(100) DEFAULT NULL,
  `td_check_no` text DEFAULT NULL,
  `voucher_bank_name` varchar(255) DEFAULT NULL,
  `td_check_date` varchar(100) DEFAULT NULL,
  `check_type` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `brokers`
--
ALTER TABLE `brokers`
  ADD PRIMARY KEY (`broker_id`);

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`budget_id`);

--
-- Indexes for table `budget_category`
--
ALTER TABLE `budget_category`
  ADD PRIMARY KEY (`budget_category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categories_id`);

--
-- Indexes for table `checks`
--
ALTER TABLE `checks`
  ADD PRIMARY KEY (`check_id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `orders_return`
--
ALTER TABLE `orders_return`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`);

--
-- Indexes for table `order_return_item`
--
ALTER TABLE `order_return_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `idx_batch_id` (`batch_id`);

--
-- Indexes for table `privileges`
--
ALTER TABLE `privileges`
  ADD PRIMARY KEY (`privileges_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD KEY `idx_product_id` (`product_id`),
  ADD KEY `idx_batch_no` (`batch_no`),
  ADD KEY `idx_expiry_date` (`expiry_date`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indexes for table `purchase_item`
--
ALTER TABLE `purchase_item`
  ADD PRIMARY KEY (`purchase_item_id`);

--
-- Indexes for table `purchase_return`
--
ALTER TABLE `purchase_return`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indexes for table `purchase_return_item`
--
ALTER TABLE `purchase_return_item`
  ADD PRIMARY KEY (`purchase_item_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`voucher_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `brokers`
--
ALTER TABLE `brokers`
  MODIFY `broker_id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `budget_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget_category`
--
ALTER TABLE `budget_category`
  MODIFY `budget_category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `checks`
--
ALTER TABLE `checks`
  MODIFY `check_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `orders_return`
--
ALTER TABLE `orders_return`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_return_item`
--
ALTER TABLE `order_return_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `privileges_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1419;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `batch_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `purchase_item`
--
ALTER TABLE `purchase_item`
  MODIFY `purchase_item_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `purchase_return`
--
ALTER TABLE `purchase_return`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `purchase_return_item`
--
ALTER TABLE `purchase_return_item`
  MODIFY `purchase_item_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `voucher_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
