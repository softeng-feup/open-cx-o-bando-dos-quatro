<?php

    include_once('../database/conference.php');

    $username = $_POST['username'];
    $password = $_POST['password'];

    if(valid_login($username, $password)){

        // swap website.html for Gustavo's page
        header("Location: ../src/website.html");

    }
    else{
        header("Location: ../src/draw_login.php");
    }


?>