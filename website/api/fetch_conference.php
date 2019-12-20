<?php


include_once('../database/db_conference.php');

header('Content-Type: application/json');



$conference_code = $_POST['conference_code'];

$conference_info = fetch_conference_info($conference_code);
$conference_id = $conference_info['id'];

$nodes = fetch_conference_nodes($conference_id);
$edges = fetch_conference_edges($conference_id);

echo json_encode(array($conference_info, $nodes, $edges));

?>
