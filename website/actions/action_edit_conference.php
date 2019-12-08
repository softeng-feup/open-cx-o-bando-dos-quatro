<?php

    include_once('../database/conference.php');
    include_once('../debug/debug.php');
    include_once('../includes/session.php');

    if(!isset($_SESSION['username'])){
        die(header('Location: ../src/draw_login.php'));
    }

    $id = $_POST['conf_id'];
    $new_name = $_POST['name'];
    $new_code = $_POST['code'];
    $new_start = $_POST['check-in'];
    $new_end = $_POST['check-out'];
    $new_address = $_POST['address'];
    $new_city = $_POST['city'];
    $new_description = $_POST['description'];

    //falta receber nodes e edges(deixar para a parte final)

    //recebe toda a informação dos conferencia (sem nós nem edges)
    $conf_info_db = conference_information($id);


    //não pode existir conferencias com código ou nomes iguais
    if($conf_info_db['confName'] != $new_name && confNameExists($new_name)){
        $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This conference name already exists!');
        header("Location: ../src/website.php");
    }

    if($conf_info_db['code'] != $new_code && confCodeExists($new_code)){
        $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This code already exists!');
        header("Location: ../src/website.php");
    }

    update_conference_info($new_name, $new_code, $new_start, $new_end, $new_address, $new_city, $new_description, $id);
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Conference updated');
    //header("Location: ../src/website.php");



?>