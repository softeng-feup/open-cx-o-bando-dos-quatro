<?php

include_once("../database/db_user.php");
include_once('../includes/session.php');


$username = $_POST['username'];
$password = $_POST['password'];
$r_password = $_POST['r_password'];

if ($password != $r_password)
{
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Passwords don\'t match.');
    header("Location: ../pages/signup.php");
}

if (!available_username($username))
{
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Username already taken.');
    header("Location: ../pages/signup.php");
}


insert_user($username, $password);

$_SESSION['messages'][] = array('type' => 'success', 'content' => 'Signed up and logged in!');
$_SESSION['username'] = $username;
header("Location: ../pages/home.php");

?>
