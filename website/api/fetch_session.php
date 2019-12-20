<?php

include_once('../includes/session.php');

header('Content-Type: application/json');

$username = $_SESSION['username'];
echo json_encode($username);

?>
