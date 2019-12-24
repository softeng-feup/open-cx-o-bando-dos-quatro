<?php

include_once('../includes/session.php');

include_once('../database/db_conference.php');


if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}

// conference information
$username = $_SESSION['username'];
$conference_id = $_POST['id'];
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


if (!available_code($code) && $code !== fetch_conference_code($conference_id)) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Code already taken.');
    // print_r(fetch_conference_code($conference_id));
    // die();

    die(header("Location: ../pages/edit_conference.php?id=$conference_id"));
}

// update conference info
update_conference($conference_id, $name, $code, $start_date, $end_date, $address, $city, $description);

// delete old nodes and edges
delete_conference_nodes($conference_id);

// delete all images from the old nodes
array_map('unlink', glob("../images/$conference_id/*.*"));
rmdir("../images/$conference_id/");

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


$_SESSION['messages'][] = array('type' => 'success', 'content' => 'Conference updated.');
header('Location: ../pages/add_images.php?id=' . $conference_id);

?>