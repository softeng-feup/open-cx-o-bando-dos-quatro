<?php

    include_once('../database/conference.php');
    include_once('../includes/session.php');

    $username = $_POST['username'];
    $password = $_POST['password'];

    if(valid_login($username, $password)){

        $_SESSION['username'] = $username;
        header("Location: ../src/website.php");

    }
    else{
        header("Location: ../src/draw_login.php");
    }


?>