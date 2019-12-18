<?php

    include_once("../database/conference.php");
    include_once('../includes/session.php');


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

    if(insert_user($username, $password)){
        $_SESSION['username'] = $username;
        header("Location: ../src/website.php");
    }
    else{
        header("Location: ../src/draw_signup.php");
    }
    

?>