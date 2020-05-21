<?php

session_start();
$dsn = "mysql:host=127.0.0.1;dbname=blog";
$user = "root";
$password = NULL;
$options = NULL;
$message = "";
try {
    $pdo = new PDO($dsn, $user, $password, $options);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (Exception $e) {
    $message = $e->getMessage();
}

if (!empty($_POST)) {
    $password = $_POST['password'];
//    I get rid of this first to help you validate your change
//    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $stmt = $pdo->prepare("UPDATE member SET passwords =:password WHERE userName =:username");
    $stmt->bindParam(":username", $_SESSION['username']);
    $stmt->bindParam(":password", $password);

    $stmt->execute();
    $count = $stmt->rowCount();
    if ($count > 0) {
        echo "Success!";
    } else {
        echo "Try again";
    }
}