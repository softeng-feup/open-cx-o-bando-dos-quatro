<?php

include_once('../includes/session.php');

include_once('../database/db_conference.php');


$conference_id = $_POST['id'];
// id of the node inside a conference 
$node_ids = $_POST['node_id'];

mkdir("../images/$conference_id", 0700);

$i = 0;
foreach ($_FILES['image']['tmp_name'] as $index => $tmpName) {
    
    $node_id = $node_ids[$i];
    if ($_FILES['image']['type'][$i] == 'image/jpeg') {
        $target = "../images/$conference_id/$node_id.jpg";
    }
    else if ($_FILES['image']['type'][$i] == 'image/png') {
        $target = "../images/$conference_id/$node_id.png";
    }
    
    if (move_uploaded_file($tmpName, $target)) {
        insert_conference_image($conference_id, $node_id, $target);
    }
    $i = $i + 1;
}


header('Location: ../pages/home.php');

?>
