<?php

    include_once("../database/conference.php");

    $username = $_POST['username'];
    $password = $_POST['password'];
    $r_password = $_POST['r_password'];

    if($password != $r_password){
        // create error message
        header("Location: ../src/draw_signup.php");
    }
    
    if(!available_username($username)){
        // create error message
        header("Location: ../src/draw_signup.php");
    }

    insert_user($username, $password);

    // swap website.html for Gustavo's page
    header("Location: ../src/website.html");

?>