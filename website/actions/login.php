<?php

include_once('../database/db_user.php');
include_once('../includes/session.php');

$username = $_POST['username'];
$password = $_POST['password'];

if (valid_credentials($username, $password))
{
    $_SESSION['messages'][] = array('type' => 'success', 'content' => 'Successfuly logged in!');
    $_SESSION['username'] = $username;
    header("Location: ../pages/home.php");
}
else
{
    header("Location: ../pages/login.php");
}

?>
