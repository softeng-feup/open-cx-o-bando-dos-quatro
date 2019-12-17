<?php

    include_once('../database/conference.php');
    include_once('../debug/debug.php');
    include_once('../includes/session.php');

    $id = $_GET['id'];

    delete_conference($id);

    header("Location: ../src/website.php");
    

?>