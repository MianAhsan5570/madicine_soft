-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2026 at 10:31 AM
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
(1, 'lasani Bedsheet', 0, 1),
(2, '', 0, 1),
(3, '', 0, 1),
(4, '', 0, 1),
(6, 'lasani ', 0, 1),
(7, 'lasani collections', 0, 1),
(8, 'JJ', 0, 1);

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

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`budget_id`, `budget_name`, `budget_amount`, `budget_type`, `voucher_id`, `voucher_type`, `budget_date`, `budget_add_date`) VALUES
(1, 'expense added to kharcha', 2000, 'expense', 4, 0, '2026-01-26', '2026-01-26 09:52:57');

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
(2, 'double blankt', '1', '', 0, 1),
(3, 'Pillow', '1', '', 0, 1),
(4, 'FILLING', '1', '', 0, 1),
(5, 'gool takia', '1', '', 0, 1),
(6, 'multani double', '1', '', 0, 1),
(7, 'crystal singe bedsheet', '1', '', 0, 1),
(8, 'double blankt', '1', '', 0, 1),
(9, 'double blankt', '1', '', 0, 1),
(10, 'ac double blanket', '1', '', 0, 1),
(11, 'floor cusion filling', '1', '', 0, 1),
(12, 'single razai', '1', '', 0, 1),
(13, 'double razai', '1', '', 0, 1),
(14, 'gada filling', '1', '', 0, 1),
(15, 'nikrool filling', '1', '', 0, 1),
(16, 'cusion filling', '1', '', 0, 1),
(17, 'SHAGGY RAZAI', '1', '', 0, 1),
(18, 'single razai', '1', '', 0, 1),
(19, 'SHAGGY RAZAI', '1', '', 0, 1),
(20, 'COTTON BEDSHEETS', '1', '', 0, 1),
(21, 'export bedsheet', '1', '', 0, 1),
(22, 'rad silk bedsheet haji saleem', '1', '', 0, 1),
(23, 'rad silk bedsheet abs', '1', '', 0, 1),
(24, 'barfi kadai haji saleem', '1', '', 0, 1),
(25, 'malai kadai bedsheet abs', '1', '', 0, 1),
(26, 'malai qulit bedsheet abs', '1', '', 0, 1),
(27, 'texture qulit bedsheet abs', '1', '', 0, 1),
(28, 'elvet jecquard', '1', '', 0, 1),
(29, 'vetvet jecquard', '1', '', 0, 1),
(30, 'foami bedsheet', '1', '', 0, 1),
(31, 'ROOMA DOUBLE BEDSHEET', '1', '', 0, 1),
(32, 'vicos quilt bedsheet', '1', '', 0, 1),
(33, '', '1', '', 0, 1),
(34, '', '1', '', 0, 1),
(35, 'sada texture 3pc bedsheet', '1', '', 0, 1),
(36, 'viscous sada bedsheet', '1', '', 0, 1),
(37, 'palachi sada bedsheet', '1', '', 0, 1),
(38, 'special palachi 4 border ', '1', '', 0, 1),
(39, 'malai embossed bedsheet', '1', '', 0, 1),
(40, 'barfi sada bedsheet', '1', '', 0, 1),
(41, 'spread cotton bedsheet', '1', '', 0, 1),
(42, 'normal jacket bedsheet', '1', '', 0, 1),
(43, 'normal fleece 4pc bed sheet', '1', '', 0, 1),
(44, 'vip fleece set plachi', '1', '', 0, 1),
(45, 'arani fleece set', '1', '', 0, 1),
(46, 'sada kadai malai set', '1', '', 0, 1),
(47, 'farooq single bedsheet', '1', '', 0, 1),
(48, 'khan tex all over bedsheet', '1', '', 0, 1),
(49, 'ag tex cloudy kambal', '1', '', 0, 1),
(50, 'china spread abs', '1', '', 0, 1),
(51, 'kala mora bare bedsheet', '1', '', 0, 1),
(52, 'normal shaheen multani bedsheet', '1', '', 0, 1),
(53, 'xl shaheen bedsheet', '1', '', 0, 1),
(54, 'khaddar jal bedsheet', '1', '', 0, 1),
(55, 'khaddar single bedsheet', '1', '', 0, 1),
(56, 'tawal cotton 27x54', '1', '', 0, 1),
(57, 'tawal vip 27x54', '1', '', 0, 1),
(58, 'zero twist 27x54', '1', '', 0, 1),
(59, 'medium towel', '1', '', 0, 1),
(60, 'towel normal size cotton', '1', '', 0, 1),
(61, '6 payel tela + tela  jora ', '1', '', 0, 1),
(62, '6 payel jora daga + tela ', '1', '', 0, 1),
(63, 'jaal kadai ', '1', '', 0, 1),
(64, '4 payel emobes ', '1', '', 0, 1),
(65, '4 payel emobes ', '1', '', 0, 1),
(66, 'fomi razai cover single', '1', '', 0, 1),
(67, 'jacket razai cover single', '1', '', 0, 1),
(68, 'shaggy razaie cover single ', '1', '', 0, 1),
(69, 'plachi razai cover single', '1', '', 0, 1),
(70, 'normal shaggy razai cover', '1', '', 0, 1),
(71, ' palachi razai cover double', '1', '', 0, 1),
(72, 'shaggy razai cover double ', '1', '', 0, 1),
(73, 'double barfi razai cover', '1', '', 0, 1),
(74, 'double Jacquard razaie cover', '1', '', 0, 1),
(75, 'ac kambal', '1', '', 0, 1),
(76, 'matres cover', '1', '', 0, 1),
(77, 'matres cover', '1', '', 0, 1),
(78, ' fleece set', '1', '', 0, 1),
(79, 'rezaie istar', '1', '', 0, 1),
(80, 'gada cover', '1', '', 0, 1),
(81, 'gada shaggy rb', '1', '', 0, 1),
(82, 'karandi gada', '1', '', 0, 1),
(83, 'gada', '1', '', 0, 1),
(84, 'razai cover', '1', '', 0, 1),
(85, 'baby kambal', '1', '', 0, 1),
(86, 'dari', '1', '', 0, 1),
(87, 'khais', '1', '', 0, 1),
(88, 'razai set', '1', '', 0, 1),
(89, 'comfortor set', '1', '', 0, 1),
(90, 'single 2 ply blacket', '1', '', 0, 1),
(91, 'single 1 ply blanket ', '1', '', 0, 1),
(92, 'double blanket 1 ply', '1', '', 0, 1),
(93, 'blanket set 4 piece', '1', '', 0, 1),
(94, 'jaye namaz', '1', '', 0, 1),
(95, 'cusion ', '1', '', 0, 1),
(96, '', '1', '', 0, 1),
(97, 'bedsheets', '2500', '2000', 0, 1),
(98, '', '1', '', 0, 1);

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
(5, 'AMG', 'user.png', 'Head Office : P#10 Central Mill Road , Ayub Colony Jhang road Faisalabad Pakistan  ', '123456897', '231546897', 'https://lasanibedsheets.com/', 1, 'gui', 'print_order.php');

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
  `customer_status` int(255) NOT NULL,
  `customer_type` varchar(250) DEFAULT NULL,
  `customer_limit` varchar(10) NOT NULL DEFAULT '0',
  `customer_add_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_email`, `customer_phone`, `customer_address`, `customer_status`, `customer_type`, `customer_limit`, `customer_add_date`) VALUES
(1, 'cash in hand', '', '03230641322', '', 1, 'bank', '0', '2025-06-27 15:24:51'),
(5, 'asif fiber', '', '03004607278', 'lal mills chowk fsd', 1, 'supplier', '0', '2025-06-27 15:34:44'),
(20, 'muhammad ahsan', 'ahsan@gmail.com', '03067055997', '67 jb sadhar', 1, 'customer', '0', '2026-02-06 09:27:54');

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
(128, 'income report', 'income_report.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 20:12:23'),
(129, 'profit and loss', 'profit_loss.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 20:12:38'),
(130, 'profit summary', 'profit_summary.php', 115, 'fa fa-edit', NULL, 0, 0, 0, '2021-04-21 20:12:58'),
(131, 'trail balance', 'trail_balance.php#', 115, 'fa fa-edit', 6, 0, 0, 0, '2021-06-02 23:19:37'),
(133, 'expense type', 'expense_type.php', 107, 'local_shipping', NULL, 0, 0, 0, '2021-06-10 19:04:02'),
(134, 'analytics', 'analytics.php', 0, 'local_shipping', 7, 0, 0, 0, '2024-08-06 06:28:41'),
(135, 'View Cash Sales', 'view_orders.php###', 104, 'local_shipping', NULL, 0, 0, 0, '2026-02-07 15:07:00'),
(136, 'view credit sales', 'credit_orders.php#', 104, 'local_shipping', NULL, 0, 0, 0, '2026-02-07 15:07:54'),
(137, 'analytics', 'analytics.php', 115, 'local_shipping', NULL, 0, 0, 0, '2021-08-29 17:56:15'),
(138, 'sale reports', 'sale_report.php', 107, 'local_shipping', NULL, 0, 0, 0, '2021-06-15 17:40:17'),
(139, 'purchase reports', 'purchase_report.php', 107, 'local_shipping', NULL, 0, 0, 0, '2021-06-15 17:41:00'),
(140, 'general voucher', 'voucher.php?act=general_voucher', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:42:27'),
(141, 'expense voucher', 'voucher.php?act=expense_voucher', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:43:15'),
(142, 'single voucher', 'voucher.php?act=single_voucher#', 101, 'local_shipping', NULL, 1, 0, 1, '2021-06-21 19:44:55'),
(143, 'backup & restore', 'backup.php', 107, 'local_shipping', NULL, 1, 0, 1, '2021-06-26 20:36:25'),
(144, 'pending cash bills ', 'pending_bills.php?search_it=all', 115, '', NULL, 0, 0, 0, '2021-08-20 19:43:20'),
(145, 'pending report', 'customerpendingreport.php', 107, '', NULL, 0, 0, 0, '2021-08-20 19:58:40'),
(147, 'check list ', 'check_list.php', 101, '', NULL, 1, 1, 1, '2021-09-19 12:53:19'),
(148, 'products', '#', 0, '', 5, 0, 0, 0, '2024-08-06 06:28:41'),
(149, 'inventory products', 'inventory.php?act=add', 148, '', NULL, 1, 1, 1, '2021-09-19 12:58:26'),
(150, 'inventory p list ', 'inventory.php?act=list', 148, '', NULL, 1, 1, 1, '2021-09-19 12:59:06'),
(151, 'customer due report', 'reports3.php?type=customer#', 107, '', NULL, 0, 0, 0, '2021-11-15 11:47:04'),
(153, 'cash purchase return', 'cash_purchase_return.php###', 112, '', NULL, 1, 1, 1, '2025-06-16 06:04:08'),
(154, 'cash sale return', 'cash_sale_return.php#####', 104, '', NULL, 1, 1, 1, '2025-06-16 06:01:43'),
(155, 'credit sale return', 'credit_sale_return.php##', 104, '', NULL, 1, 1, 1, '2025-06-16 06:03:04'),
(156, 'view sale returns', 'view_sale_return.php###', 104, '', NULL, 1, 1, 1, '2025-06-16 06:00:33'),
(158, 'credit purchase return', 'credit_purchase_return.php##', 112, '', NULL, 1, 1, 1, '2025-06-16 06:04:43'),
(159, 'view purchase returns', 'view_purchase_return.php###', 112, '', NULL, 1, 1, 1, '2025-06-16 06:01:02');

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
(18, 2, 2, 8, NULL, 100, 0, 0, 1, NULL, NULL, NULL),
(22, 1, 2, 8, NULL, 300, 0, 0, 1, NULL, NULL, NULL),
(25, 3, 2, 8, NULL, 100, 31000, 3100000, 1, NULL, NULL, NULL),
(29, 4, 2, 8, 'undefined', 300, 31000, 9300000, 1, NULL, NULL, NULL),
(30, 4, 2, 10, 'undefined', 300, 31000, 9300000, 1, NULL, NULL, NULL),
(31, 5, 2, 8, NULL, 100, 31000, 3100000, 1, NULL, NULL, NULL),
(32, 5, 2, 10, NULL, 100, 31000, 3100000, 1, NULL, NULL, NULL);

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

INSERT INTO `product` (`product_id`, `product_name`, `product_code`, `product_image`, `brand_id`, `category_id`, `quantity_instock`, `purchased`, `current_rate`, `f_days`, `t_days`, `purchase_rate`, `status`, `availability`, `alert_at`, `weight`, `actual_rate`, `product_description`, `product_mm`, `product_inch`, `product_meter`, `adddatetime`, `inventory`) VALUES
(1, 'rooma doble bedsheet', '035', '', 1, 1, 0, 0, 0, '', '', 1100, 0, 1, 20, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(2, 'super select double ', '155', '', 1, 2, 8400, 0, 31000, '', '', 51000, 1, 1, 5, '', '', '', '', '', '', '2026-02-10 09:23:01', 0),
(3, 'master pillow', '001', '', 1, 3, 2000, 0, 400, '', '', 335, 1, 1, 30, '', '', '', '', '', '', '2026-02-10 06:42:54', 0),
(4, 'nishat pillow', '002', '', 1, 3, 0, 0, 500, '', '', 415, 1, 1, 30, '', '', '', '', '', '', '2026-02-06 09:39:06', 0),
(5, 'korean open pillow', '003', '', 1, 3, 0, 0, 0, '', '', 515, 1, 1, 30, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(6, 'voli pillow', '005', '', 1, 3, 0, 0, 0, '', '', 190, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(7, 'master gadi set', '006', '', 1, 4, 0, 0, 0, '', '', 505, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(8, 'gadi set voli', '007', '', 1, 4, 0, 0, 0, '', '', 400, 1, 1, 1, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(9, '5piece gadi set ravi', '008', '', 1, 4, 0, 0, 0, '', '', 685, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(10, 'master golol takia', '0010', '', 1, 5, 0, 0, 0, '', '', 485, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(11, 'ravi gool takia', '009', '', 1, 5, 0, 0, 0, '', '', 655, 1, 1, 3, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(12, 'rabar gool takia', '012', '', 1, 5, 0, 0, 0, '', '', 350, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(13, 'foam gool takia', '011', '', 2, 5, 0, 0, 0, '', '', 425, 1, 1, 5, '', '', '', '', '', '', '2025-06-23 12:28:41', 0),
(14, 'light weight double  al farooq ', '067', '', 1, 6, 0, 0, 0, '', '', 1650, 1, 1, 8, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(15, 'rooma single bedsheet', '036', '', 1, 7, 0, 0, 0, '', '', 1250, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(16, 'super cloudy double', '160', '', 1, 8, 0, 0, 0, '', '', 6000, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(17, 'perfect king blanket', '157', '', 1, 9, 0, 0, 0, '', '', 7950, 1, 1, 0, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(18, 'home sweet ac blanket', '102', '', 1, 10, 0, 0, 0, '', '', 2390, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(19, 'press pillow korian', '004', '', 1, 3, 0, 0, 0, '', '', 590, 1, 1, 15, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(20, 'master floor cusion ', '013', '', 1, 11, 0, 0, 0, '', '', 505, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(21, 'floor cusion ravi ', '014', '', 1, 11, 0, 0, 0, '', '', 675, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(22, 'single razai collection', '015', '', 1, 12, 0, 0, 0, '', '', 1450, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(23, 'single razai sapna ', '016', '', 1, 12, 0, 0, 0, '', '', 2400, 1, 1, 15, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(24, 'sada razai single', '017', '', 1, 12, 0, 0, 0, '', '', 2200, 1, 1, 0, '', '', '', '', '', '', '2025-06-23 14:01:18', 0),
(25, 'double razai sada', '018', '', 1, 13, 0, 0, 0, '', '', 2900, 1, 1, 0, '', '', '', '', '', '', '2025-06-23 14:03:34', 0),
(26, 'double razai collection', '019', '', 1, 13, 0, 0, 0, '', '', 2000, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(27, 'double razai sapna', '020', '', 1, 13, 0, 0, 0, '', '', 3150, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(28, 'double razai korean', '021', '', 1, 13, 0, 0, 0, '', '', 3400, 1, 1, 5, '', '', '', '', '', '', '2025-06-23 14:08:07', 0),
(29, 'single razai korean', '022', '', 1, 12, 0, 0, 0, '', '', 2400, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(30, 'gada collection 2 meter', '023', '', 1, 14, 0, 0, 0, '', '', 1050, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(31, 'gada collection 2.5 meter', '026', '', 1, 14, 0, 0, 0, '', '', 1350, 1, 1, 0, '', '', '', '', '', '', '2025-06-23 14:12:04', 0),
(32, 'sada gada 2 meter ', '024', '', 1, 14, 0, 0, 0, '', '', 900, 1, 1, 0, '', '', '', '', '', '', '2025-06-23 14:14:03', 0),
(33, 'sapna gada 2.5 meter', '027', '', 1, 14, 0, 0, 0, '', '', 1450, 1, 1, 15, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(34, 'nikrool set filling', '028', '', 1, 15, 0, 0, 0, '', '', 105, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(35, 'dil cusion filling ', '029', '', 1, 16, 0, 0, 0, '', '', 105, 1, 1, 10, '', '', '', '', '', '', '2025-06-23 14:20:18', 0),
(36, 'cusion filling 18*18', '030', '', 1, 16, 0, 0, 0, '', '', 170, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(37, 'shaggy razai ', '031', '', 1, 17, 0, 0, 0, '', '', 8000, 1, 1, 0, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(38, 'shaggy razai  set', '032', '', 1, 18, 0, 0, 0, '', '', 11000, 1, 1, 0, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(39, 'bubble razai ', '033', '', 1, 19, 0, 0, 0, '', '', 9500, 1, 1, 0, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(40, 'china razai ', '034', '', 1, 19, 0, 0, 0, '', '', 8200, 1, 1, 0, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(41, 'pure cotton double open bedsheet', '037', '', 1, 20, 0, 0, 0, '', '', 1500, 1, 1, 10, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(42, 'single pure cotton open bedsheet', '038', '', 1, 20, 0, 0, 0, '', '', 1750, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(43, 'fitted bedsheet', '039', '', 1, 20, 0, 0, 0, '', '', 1500, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(44, 'dynesty pure cotton ', '040', '', 1, 20, 0, 0, 0, '', '', 1500, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(45, 'double export bedsheet', '041', '', 1, 21, 0, 0, 0, '', '', 900, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(46, 'single export bedsheet', '042', '', 1, 21, 0, 0, 0, '', '', 1050, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(47, 'rad silk 3 peiece bedsheet', '043', '', 1, 22, 0, 0, 0, '', '', 6000, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(48, 'rad silk 3 peiece bedsheet', '025', '', 1, 23, 0, 0, 0, '', '', 6500, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(49, 'barfi velvet kadai bedsheet', '044', '', 1, 24, 0, 0, 0, '', '', 6500, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(50, 'malai kadai bedsheet', '053', '', 1, 25, 0, 0, 0, '', '', 7200, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(51, 'malai qulit bedsheet', '045', '', 1, 26, 0, 0, 0, '', '', 6000, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(52, 'texture qulit bedsheet', '047', '', 1, 27, 0, 0, 0, '', '', 6500, 1, 1, 0, '', '', '', '', '', '', '2025-06-26 11:30:41', 0),
(53, 'velvet jecquard double bedsht', '051', '', 1, 28, 0, 0, 0, '', '', 3500, 0, 1, 25, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(54, 'velvet jecquard double bedsheet', '051', '', 1, 29, 0, 0, 0, '', '', 3500, 1, 1, 25, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(55, 'single velvet jecquard bedsheet', '052', '', 1, 29, 0, 0, 0, '', '', 4500, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(56, 'foami doublebedsheet', '065', '', 1, 30, 0, 0, 0, '', '', 3400, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(57, 'rooma doble bedsheet', '035', '', 1, 31, 0, 0, 0, '', '', 1100, 1, 1, 20, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(58, 'vicos quilt bedsheet', '048', '', 3, 32, 0, 0, 0, '', '', 5500, 1, 1, 2, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(59, 'quilt china 3pc', '049', '', 1, 33, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:27:25', 0),
(60, 'quilt cotton print ', '050', '', 1, 34, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:28:09', 0),
(61, 'sada texture 3pc bedsheet', '054', '', 1, 35, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:29:23', 0),
(62, 'viscous sada bedsheet', '055', '', 1, 36, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:30:15', 0),
(63, 'palachi sada bedsheet', '056', '', 1, 37, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:31:05', 0),
(64, 'special palachi 4 border bedsheet', '057', '', 4, 38, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:31:42', 0),
(65, 'malai embossed bedsheet', '058', '', 1, 39, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:32:16', 0),
(66, 'barfi sada bedsheet', '059', '', 1, 40, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:32:52', 0),
(67, 'spread cotton bedsheet', '060', '', 1, 41, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:33:21', 0),
(68, 'normal jacket bedsheet', '061', '', 1, 42, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:33:54', 0),
(69, 'normal fleece 4pc bed sheet', '062', '', 1, 43, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:34:30', 0),
(70, 'vip fleece set plachi', '063', '', 1, 44, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:35:20', 0),
(71, 'arani fleece set', '064', '', 1, 45, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:35:51', 0),
(72, 'sada kadai malai set', '066', '', 1, 46, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:36:17', 0),
(73, 'farooq single bedsheet', '068', '', 1, 47, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:36:55', 0),
(74, 'khan tex all over bedsheet', '069', '', 1, 48, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:38:08', 0),
(75, 'ag tex cloudy kambal', '070', '', 1, 49, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:39:02', 0),
(76, 'china spread abs', '208', '', 1, 50, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:40:04', 0),
(77, 'kala mora bare bedsheet', '071', '', 1, 51, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:41:48', 0),
(78, 'normal shaheen multani bedsheet', '072', '', 1, 52, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:42:18', 0),
(79, 'xl shaheen bedsheet', '073', '', 1, 53, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:42:50', 0),
(80, 'khaddar jal bedsheet', '075', '', 1, 54, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:44:52', 0),
(81, 'khaddar single bedsheet', '076', '', 1, 55, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:45:10', 0),
(82, 'tawal cotton 27x54', '077', '', 1, 56, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:45:38', 0),
(83, 'tawal vip 27x54', '078', '', 1, 57, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:46:03', 0),
(84, 'zero twist 27x54', '079', '', 1, 58, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:46:36', 0),
(85, 'medium towel', '080', '', 1, 59, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:46:58', 0),
(86, 'towel normal size cotton', '081', '', 1, 60, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:47:44', 0),
(87, '6 payel tela + tela jora', '083', '', 1, 61, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:49:04', 0),
(88, '6 payel jora daga + tela ', '084', '', 1, 62, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:49:53', 0),
(89, 'jaal kadai ', '085', '', 1, 63, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:50:27', 0),
(90, '4 payel emobes ', '086', '', 1, 64, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:51:12', 0),
(91, '6 payel emobes ', '087', '', 1, 65, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:51:28', 0),
(92, 'fomi razai cover single', '088', '', 1, 66, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:52:01', 0),
(93, 'jacket razai cover single', '089', '', 1, 67, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:52:41', 0),
(94, 'shaggy razaie cover single ', '090', '', 1, 68, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:53:19', 0),
(95, 'plachi razai cover single', '091', '', 1, 69, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:54:12', 0),
(96, 'normal shaggy razai cover', '092', '', 1, 70, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:54:41', 0),
(97, ' palachi razai cover double', '093', '', 1, 71, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:55:17', 0),
(98, 'shaggy razai cover double ', '094', '', 1, 72, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:56:52', 0),
(99, 'double barfi razai cover', '095', '', 1, 73, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:57:32', 0),
(100, 'double jacquard razaie cover', '096', '', 1, 74, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:59:03', 0),
(101, 'irani ac kambal double', '097', '', 1, 75, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 11:59:58', 0),
(102, 'irani ac kambal single', '098', '', 1, 75, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:00:33', 0),
(103, 'sada ac kambal double', '100', '', 1, 75, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:01:01', 0),
(104, 'hbk normal kambal a tex ', '1', '', 1, 75, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:01:54', 0),
(105, 'sada matres cover', '103', '', 1, 76, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:02:30', 0),
(106, 'aa matres cover', '104', '', 1, 77, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:03:00', 0),
(107, 'abs matres cover', '105', '', 1, 76, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:03:26', 0),
(108, 'texture fleece set', '210', '', 1, 78, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:04:08', 0),
(109, 'rezaie istar', '119', '', 1, 79, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:06:43', 0),
(110, 'gada cover rb', '120', '', 1, 80, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:07:20', 0),
(111, 'gada shaggy rb', '121', '', 1, 81, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:08:23', 0),
(112, 'karandi gada', '122', '', 1, 82, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:08:57', 0),
(113, 'special gada bare', '123', '', 1, 83, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:09:38', 0),
(114, 'normal shaggy gada ', '124', '', 1, 83, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:10:38', 0),
(115, 'razai cover single rb', '125', '', 1, 84, 0, 0, 0, '', '', 125, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:11:24', 0),
(116, 'double razai cover rb', '126', '', 1, 84, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:12:16', 0),
(117, 'baby kambal', '127', '', 1, 85, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:12:46', 0),
(118, 'rocket dari', '128', '', 1, 86, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:13:17', 0),
(119, 'velvet dari', '129', '', 1, 86, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:13:46', 0),
(120, 'soti khais vip', '130', '', 1, 87, 0, 0, 0, '', '', 10, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:14:32', 0),
(121, 'nirmal soti khais ', '131', '', 1, 87, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:15:05', 0),
(122, 'majnu soti khais', '132', '', 1, 87, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:15:33', 0),
(123, 'onai majnu qais', '133', '', 1, 87, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:16:16', 0),
(124, 'white special khais', '135', '', 1, 87, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:17:20', 0),
(125, 'onai khais', '134', '', 1, 87, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:17:48', 0),
(126, 'palachi razai set 9pcs', '136', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:18:32', 0),
(127, '4 border plachi set 9pcs', '137', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:19:35', 0),
(128, 'barfi velvet razai set 9pcs', '138', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:20:16', 0),
(129, 'rad silk set 9pcs', '140', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:22:05', 0),
(130, 'texture set 9pcs', '141', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:22:40', 0),
(131, 'laser set 9 pcs', '143', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:23:20', 0),
(132, 'viscous set 9pcs', '144', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:23:55', 0),
(133, '3 motiv set 9pcs', '145', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:25:00', 0),
(134, 'tela+tela set 9pcs', '146', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:25:43', 0),
(135, 'hand made set 9pcs', '147', '', 1, 88, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:26:35', 0),
(136, 'abs laser comforter set 9pcs', '148', '', 1, 89, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-02 12:27:39', 0),
(137, 'texture ac kambal', '149', '', 1, 75, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:37:42', 0),
(138, 'single 2 ply blacket cloudy', '150', '', 1, 90, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:39:59', 0),
(139, 'single 2 ply blanket snow cloudy ', '152', '', 1, 90, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:42:29', 0),
(140, 'single 2 ply blanket super select ', '151', '', 1, 90, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:43:15', 0),
(141, 'single 2 ply blanket normal', '153', '', 1, 90, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:46:05', 0),
(142, 'single 1 ply blanket ', '154', '', 1, 91, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:46:45', 0),
(143, 'double blanket 1ply ', '156', '', 1, 92, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:48:14', 0),
(144, 'double blanket select comfort', '158', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:49:07', 0),
(145, 'double blanket spin', '159', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:49:25', 0),
(146, 'double blanket love for ever', '161', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:49:57', 0),
(147, 'double blanket bali dream', '162', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:50:32', 0),
(148, 'double blanket sun flower', '163', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:50:48', 0),
(149, '4piece blanket set super cloudy ', '165', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:54:23', 0),
(150, 'double blanket 2 ply perfection', '164', '', 1, 2, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:54:52', 0),
(151, '4 piece blanket set black rose', '166', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:55:32', 0),
(152, '4 piece blanket set golden cloudy ', '167', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:56:02', 0),
(153, '4 piece blanket set universal ugt ', '168', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:56:52', 0),
(154, '4 piece blanket set clasic ugt ', '169', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:57:19', 0),
(155, '4 piece blanket set denza', '170', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:57:48', 0),
(156, '4 piece blanket set bloom betle ', '171', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:58:27', 0),
(157, '4 piece blanket set summer choice', '172', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:59:00', 0),
(158, '4 piece blanket set riched cloudy ', '173', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 11:59:38', 0),
(159, '4 piece blanket set platinum ', '174', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:00:02', 0),
(160, 'jaye namaz nomral ', '175', '', 1, 93, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:00:39', 0),
(161, 'jaye namaz vip', '176', '', 1, 94, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:01:07', 0),
(162, 'lazer cusion back velvet', '4', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:01:51', 0),
(163, 'lazer cusion back silk ', '178', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:02:24', 0),
(164, 'lazer cusion itlan ', '1797', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:02:38', 0),
(165, 'tesal cusion vip', '180', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 5, '', '', '', '', '', '', '2025-07-03 12:03:07', 0),
(166, 'versace jacket cushion', '181', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:04:27', 0),
(167, 'far dil cusion ', '182', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 5, '', '', '', '', '', '', '2025-07-03 12:04:53', 0),
(168, 'digtal cusion ', '183', '', 1, 95, 0, 0, 0, '', '', 1, 1, 1, 0, '', '', '', '', '', '', '2025-07-03 12:05:14', 0),
(169, 'test product', '1234', '', 1, 37, 0, 0, 0, '', '', 1000, 1, 1, 5, '', '', 'soft pillow good quality', '', '', '', '2026-01-27 11:03:24', 0),
(170, 'bedsheets', '345', '', 7, 96, 0, 0, 0, '', '', 4000, 1, 1, 5, '', '', 'waterproof bedsheets', '', '', '', '2026-01-27 11:03:24', 0),
(171, 'pillow', '10', '', 1, 3, 0, 0, 0, '', '', 200, 1, 1, 5, '', '', 'abc', '', '', '', '2026-01-27 11:03:24', 0),
(172, 'razai 1', '12', '', 8, 13, 0, 0, 0, '', '', 250, 1, 1, 5, '', '', '', '', '', '', '2026-01-27 11:03:24', 0),
(173, 'cover', '333', '', 1, 98, 0, 0, 300, '', '', 250, 1, 0, 0, '', '', 'cover open', '', '', '', '2026-01-27 11:03:24', 0),
(174, 'cover', '842824337', '', 1, 2, 0, 0, 0, '', '', 270, 1, 1, 5, '', '', '', '', '', '', '2026-02-09 12:06:09', 1),
(175, 'testing', '34424', '', 1, 2, 0, 0, 0, '', '', 40000, 1, 1, 5, '', '', 'dfsdfgdf', '', '', '', '2026-02-09 12:24:49', 0),
(176, 'testing', '985033246', '', 0, 0, 0, 0, 40000, NULL, NULL, 40000, 1, 1, 5, '', NULL, NULL, '0', '0', '0', '2026-02-09 12:25:23', 1);

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
(1, 2, 'fd454', '2026-02-24', 0, 0, 0, 1, '2026-02-10 06:25:41', '2026-02-10 06:29:22'),
(2, 2, 'dfdsf343', '2026-02-25', 0, 0, 0, 1, '2026-02-10 06:25:41', '2026-02-10 06:29:22'),
(3, 2, 'fd454', '2026-02-25', 0, 0, 0, 1, '2026-02-10 06:29:22', '2026-02-10 06:33:40'),
(4, 3, 'fd454', '2026-02-24', 0, 0, 0, 1, '2026-02-10 06:29:22', '2026-02-10 06:33:40'),
(5, 2, '123a', '2026-02-24', 0, 0, 0, 2, '2026-02-10 06:37:24', '2026-02-10 07:41:06'),
(6, 3, '3456a', '2026-02-20', 0, 0, 0, 2, '2026-02-10 06:37:24', '2026-02-10 06:42:54'),
(7, 2, '123a', '2026-02-24', 0, 0, 0, 2, '2026-02-10 06:39:28', '2026-02-10 07:41:06'),
(8, 2, '123a', '2026-02-24', 0, 0, 0, 3, '2026-02-10 06:43:46', '2026-02-10 07:42:37'),
(9, 2, '123a', '2026-02-27', 0, 0, 0, 4, '2026-02-10 06:57:34', '2026-02-10 07:42:43'),
(10, 2, 'fd45', '2026-02-26', 0, 0, 0, 5, '2026-02-10 07:20:34', '2026-02-10 07:41:03'),
(11, 2, 'sd567', '2026-02-28', 0, 0, 0, 6, '2026-02-10 07:43:06', '2026-02-10 07:43:16'),
(12, 2, '123a', '2026-02-25', 0, 0, 0, 7, '2026-02-10 09:17:50', '2026-02-10 09:23:01'),
(13, 2, '3456a', '2026-02-25', 0, 0, 0, 7, '2026-02-10 09:17:50', '2026-02-10 09:23:01'),
(14, 2, '123a', '2026-02-22', 1100, 0, 1100, 7, '2026-02-10 09:23:01', '2026-02-10 09:23:01');

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
(7, '2026-02-10', 'asif fiber', '', '03004607278', '', '', '56100000', '0', '56100000', '56100000.00', '0', 'cash_purchase', 1, 5, 1, 0, 25, '', '2026-02-10 09:17:50');

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
(4, 7, 2, '123a', '2026-02-22', '', '1100', '51000', '31000', '56100000', 1);

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
(25, '56100000.00', '0', '', 1, 'purchased by purchased id#7', '2026-02-10 09:23:01', '2026-02-10', 'cash_purchase', 'purchase');

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
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `brokers`
--
ALTER TABLE `brokers`
  MODIFY `broker_id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `budget_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `budget_category`
--
ALTER TABLE `budget_category`
  MODIFY `budget_category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

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
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `expense_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders_return`
--
ALTER TABLE `orders_return`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `order_return_item`
--
ALTER TABLE `order_return_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `privileges`
--
ALTER TABLE `privileges`
  MODIFY `privileges_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1419;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(200) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `batch_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `purchase_item`
--
ALTER TABLE `purchase_item`
  MODIFY `purchase_item_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_return`
--
ALTER TABLE `purchase_return`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `purchase_return_item`
--
ALTER TABLE `purchase_return_item`
  MODIFY `purchase_item_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
