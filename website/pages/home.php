<?php

include_once('../includes/session.php');

include_once('../database/db_conference.php');

include_once('../templates/tpl_common.php');
include_once('../templates/tpl_conference.php');


if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ./login.php'));
}

// get user conferences
$conferences = fetch_user_conferences($_SESSION['username']);

?>
<!DOCTYPE html>
<html>
    <head>
        <title>ConfView</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="../css/common.css" rel="stylesheet">
        <link href="../css/home.css" rel="stylesheet">
    </head>
    <body>

<?php draw_header(); ?>

<section id="conferences">
    <header>
        <h2>Your conferences</h2>
    </header>
    
    <ul>
        <?php foreach($conferences as $conference) {
            draw_conference_list_item($conference);
        } ?>
    </ul>
    
    <footer>
        <a href="../pages/add_conference.php">Add new conference</a>
    </footer>
</section>


<?php draw_footer(); ?>