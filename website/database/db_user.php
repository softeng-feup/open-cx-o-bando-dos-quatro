<?php

include_once('../includes/database.php');


function insert_user($username, $password)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('INSERT INTO user(username, password) VALUES(?, ?)');
    $stmt->execute(array($username, password_hash($password, PASSWORD_DEFAULT)));
}

function valid_credentials($username, $password)
{
    $db = Database::instance()->db();
    
    $stmt = $db->prepare('SELECT * FROM user WHERE username = ?');
    $stmt->execute(array($username));

    $user = $stmt->fetch();

    return $user !== false && password_verify($password, $user['password']);
}

function available_username($username)
{
    $db = Database::instance()->db();

    $stmt = $db->prepare('SELECT * FROM user WHERE username = ?');
    $stmt->execute(array($username));

    return $stmt->fetch() ? false : true;
}
