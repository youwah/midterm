<?php
$servername = "localhost";
$username = "crimsonw_272043myshopadmin";
$password = "r#NJ0.TLeoHw";
$dbname = "crimsonw_272043_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error){
    die("Connection failed:" . $conn->connect_error);
}
?>