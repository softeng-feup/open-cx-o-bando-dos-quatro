<?php


include_once('../database/conference.php');
include_once('../database/db_graph.php');

header('Content-Type: application/json');



$conference_code = $_POST['conference_code'];

$conference_info = confCodeExists($conference_code);
$conference_id = $conference_info['id'];

$nodes = get_conference_nodes($conference_id);
$edges = get_conference_edges($conference_id);

echo json_encode(array($conference_info, $nodes, $edges));

?>
