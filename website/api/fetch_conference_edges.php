<?php


include_once('../database/db_conference.php');

header('Content-Type: application/json');



$conference_id = $_POST['conference_id'];

$edges = fetch_conference_edges($conference_id);

echo json_encode($edges);

?>
