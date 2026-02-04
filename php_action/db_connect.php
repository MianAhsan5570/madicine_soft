<?php
date_default_timezone_set("Asia/Karachi");
$localhost = "localhost";
$username = "root";
$password = "";
$dbname = "medicine_soft";
// $localhost = "localhost";
// $username = "root";
// $password = "";
// $dbname = "lasani_bedsheet_soft";

$connect = new mysqli($localhost, $username, $password, $dbname);
$dbc =  mysqli_connect($localhost, $username, $password, $dbname);

@session_start();
if ($connect->connect_error) {
  die("Connection Failed : " . $connect->connect_error);
} else {
  //echo "Done";
}