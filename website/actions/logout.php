<?php

    include_once('../includes/session.php');

    session_destroy();
    session_start();

    $_SESSION['messages'][] = array('type' => 'success', 'content' => 'Logged out!');

    header("Location: ../src/draw_login.php");


?>