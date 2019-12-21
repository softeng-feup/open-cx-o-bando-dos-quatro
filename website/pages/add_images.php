<?php

include_once('../includes/session.php');

include_once('../templates/tpl_common.php');

include_once('../database/db_conference.php');


$conference_id = $_GET['id'];

if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}
$username = $_SESSION['username'];

if (!belongs_to_user($conference_id, $username)) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This conference doesn\'t belong to you.');
    die(header('Location: ../pages/home.php'));
}

$nodes = fetch_conference_nodes($conference_id);

?>

<!DOCTYPE html>
<html>
    <head>
        <title>ConfView</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link href="../css/common.css" rel="stylesheet">

    </head>
    <body>
<?php draw_header(); ?>

        <form action="../actions/insert_conference_images.php" method="post" enctype="multipart/form-data">
        <?php foreach($nodes as $node) { ?>
            <div class="form_entry">
                <label>Id: <?=$node['conf_id']?></label>
                <label>Name: <?=$node['name']?></label>
                <input type="file" name="image[]" multiple="" required>
            </div>
            <input type="hidden" name="node_id[]" value="<?=$node['conf_id']?>">
        <?php } ?>
            <input type="hidden" name="id" value="<?=$conference_id?>">
            <input type="submit" value="Submit">
        </form>

<?php draw_footer(); ?>
