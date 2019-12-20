<?php

include_once('../includes/session.php');

include_once('../templates/tpl_common.php');

include_once('../database/db_conference.php');



if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}

$username = $_SESSION['username'];
$conference_id = $_GET['id'];

if (!belongs_to_user($conference_id, $username)) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This conference doesn\'t belong to you.');
    die(header('Location: ../pages/home.php'));
}

$conference_info = fetch_conference_info_id($conference_id);

?>

<!DOCTYPE html>
<html>
    <head>
        <title>ConfView</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="../javascript/dynamic_form.js" type="module" defer></script>
    </head>
    <body>
<?php draw_header(); ?>

<form id="form" action="../actions/edit_conference.php" method="post">
    <div id="info">
        <h3>Information</h3>
        <div class="form_entry">
            <label>Conference name</label>
            <input type="text" name="name" value="<?=$conference_info['name']?>" autofocus required>
        </div>
        <div class="form_entry">
            <label>Conference code</label>
            <input type="number" name="code" value="<?=$conference_info['code']?>" min="1000" max="9999" required>
        </div>
        <div class="form_entry">
            <label>Start date</label>
            <input type="date" name="start_date" value="<?=$conference_info['start_date']?>" required>
        </div>
        <div class="form_entry">
            <label>End date</label>
            <input type="date" name="end_date" value="<?=$conference_info['end_date']?>" required>
        </div>
        <div class="form_entry">
            <label>Address</label>
            <input type="text" name="address" value="<?=$conference_info['address']?>" required>
        </div>
        <div class="form_entry">
            <label>City</label>
            <input type="text" name="city" value="<?=$conference_info['city']?>" required>
        </div>
        <div class="form_entry">
            <label>Description</label>
            <textarea name="description" rows="5" required><?=$conference_info['description']?></textarea>
        </div>
    </div>

    <div id="nodes">
        <h3>Nodes</h3>
        <button id="add_node" type="button">Add node</button>
    </div>

    <div id="edges">
        <h3>Edges</h3>
        <button id="add_edge" type="button">Add edge</button>
    </div>

    <input id="submit" type="submit" value="Add conference">
</form>


<?php draw_footer(); ?>
