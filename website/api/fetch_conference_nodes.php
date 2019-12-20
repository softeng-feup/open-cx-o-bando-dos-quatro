<?php


include_once('../database/db_conference.php');

header('Content-Type: application/json');



$conference_id = $_POST['conference_id'];

$nodes = fetch_conference_nodes($conference_id);

echo json_encode($nodes);

?>
