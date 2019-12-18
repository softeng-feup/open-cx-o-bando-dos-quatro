<?php

include_once('../includes/include_data_base.php');


function get_conference_nodes($conference_id)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT id, name, x_coord, y_coord, isTag FROM node WHERE conference_id = ?');
    $stmt->execute(array($conference_id));

    return $stmt->fetchAll();
}


function get_conference_edges($conference_id)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT origin_node, dest_node FROM edge WHERE conference_id = ?');
    $stmt->execute(array($conference_id));

    return $stmt->fetchAll();
}


?>
