<?php

include_once('../includes/database.php');


function fetch_user_conferences($username)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM conference WHERE username = ?');
    $stmt->execute(array($username));

    return $stmt->fetchAll();
}

function available_code($code)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM conference WHERE code = ?');
    $stmt->execute([$code]);

    return $stmt->fetch() ? false : true;
}

function insert_conference($username, $name, $code, $start_date, $end_date, $address, $city, $description)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('INSERT INTO conference(username, name, code, start_date, end_date, address, city, description, version) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)');
    $stmt->execute(array($username, $name, $code, $start_date, $end_date, $address, $city, $description, 1));

    return $db->lastInsertId();
}

function insert_conference_node($conference_id, $conference_node_id, $x, $y, $name)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('INSERT INTO node(conf_id, conference, x, y, name) VALUES(?, ?, ?, ?, ?)');
    $stmt->execute(array($conference_node_id, $conference_id, $x, $y, $name));
}

function insert_conference_edge($conference_id, $origin_node, $destination_node)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('INSERT INTO edge(conference, origin, destination) VALUES(?, ?, ?)');
    $stmt->execute(array($conference_id, $origin_node, $destination_node));
}

function belongs_to_user($conference_id, $username)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM conference WHERE id = ? AND username = ?');
    $stmt->execute(array($conference_id, $username));

    return $stmt->fetch() ? true : false;
}

function insert_conference_image($conference_id, $node_id, $path)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('INSERT INTO image(node_id, conference, path) VALUES(?, ?, ?)');
    $stmt->execute(array($node_id, $conference_id, $path));
}

function fetch_conference_nodes($conference_id)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT conf_id, name, x, y FROM node WHERE conference = ?');
    $stmt->execute(array($conference_id));

    return $stmt->fetchAll();
}

function fetch_conference_edges($conference_id)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT origin, destination FROM edge WHERE conference = ?');
    $stmt->execute(array($conference_id));

    return $stmt->fetchAll();
}

function fetch_conference_info($code) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM conference WHERE code = ?');
    $stmt->execute(array($code));

    return $stmt->fetch();
}

function fetch_conference_info_id($id) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM conference WHERE id = ?');
    $stmt->execute(array($id));

    return $stmt->fetch();
}

function delete_conference($id) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('DELETE FROM conference WHERE id = ?');
    $stmt->execute(array($id));
}

function fetch_conference_code($id) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT code FROM conference WHERE id = ?');
    $stmt->execute(array($id));

    return $stmt->fetch()['code'];
}

function update_conference($conference_id, $name, $code, $start_date, $end_date, $address, $city, $description) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('UPDATE conference SET (name, code, start_date, end_date, address, city, description) = (?, ?, ?, ?, ?, ?, ?) WHERE id = ?');
    $stmt->execute(array($name, $code, $start_date, $end_date, $address, $city, $description, $conference_id));
}

function delete_conference_nodes($conference_id) {
    $db = Database::instance()->db();

    $stmt = $db->prepare('DELETE FROM node WHERE conference = ?');
    $stmt->execute(array($conference_id));
}

?>
