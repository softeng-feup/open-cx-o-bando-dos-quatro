<?php

include_once('../includes/session.php');

include_once('../database/db_conference.php');



if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}

$username = $_SESSION['username'];
$conference_id = $_GET['id'];

if (!belongs_to_user($conference_id, $username)) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This conference doesn\'t belong to you.');
    die(header('Location: ../pages/home.php'));
}

delete_conference($conference_id);

array_map('unlink', glob("../images/$conference_id/*.*"));
rmdir("../images/$conference_id/");

$_SESSION['messages'][] = array('type' => 'success', 'content' => 'Conference deleted!');
header("Location: ../pages/home.php");

?>
