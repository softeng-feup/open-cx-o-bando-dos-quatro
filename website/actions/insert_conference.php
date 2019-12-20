<?php

include_once('../includes/session.php');

include_once('../database/db_graph.php');
include_once('../database/db_conference.php');

include_once('../debug/debug.php');


if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}

// conference information
$username = $_SESSION['username'];
$name = $_POST['name'];
$code = $_POST['code'];
$start_date = $_POST['start_date'];
$end_date = $_POST['end_date'];
$address = $_POST['address'];
$city = $_POST['city'];
$description = $_POST['description'];

// node information
$node_ids = $_POST['node_id'];
$node_names = $_POST['node_name'];
$node_x = $_POST['node_x'];
$node_y = $_POST['node_y'];

// edge information
$edge_origins = $_POST['edge_origin'];
$edge_destination = $_POST['edge_destination'];


if (!available_code($code)) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Code already taken.');
    die(header('Location: ../pages/add_conference.php'));
}

// insert conference
$conference_id = insert_conference($username, $name, $code, $start_date, $end_date, $address, $city, $description);

// insert nodes
for ($i = 0; $i < count($node_ids); $i++) 
{
    insert_conference_node($conference_id, $node_ids[$i], $node_x[$i], $node_y[$i], $node_names[$i]);
}

// insert edges
for ($i = 0; $i < count($edge_origins); $i++) 
{
    insert_conference_edge($conference_id, $edge_origins[$i], $edge_destination[$i]);
}


$_SESSION['messages'][] = array('type' => 'success', 'content' => 'Conference created.');
header('Location: ../pages/add_images.php?id=' . $conference_id);

?>
