<?php

include_once('../includes/session.php');

include_once('../templates/tpl_common.php');


if (!isset($_SESSION['username'])) {
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Please log in.');
    die(header('Location: ../pages/login.php'));
}

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

<form id="form" action="../actions/insert_conference.php" method="post">
    <div id="info">
        <h3>Information</h3>
        <div class="form_entry">
            <label>Conference name</label>
            <input type="text" name="name" autofocus required>
        </div>
        <div class="form_entry">
            <label>Conference code</label>
            <input type="number" name="code" min="1000" max="9999" required>
        </div>
        <div class="form_entry">
            <label>Start date</label>
            <input type="date" name="start_date" value="<?php echo date('Y-m-d');?>" required>
        </div>
        <div class="form_entry">
            <label>End date</label>
            <input type="date" name="end_date" value="<?php echo date('Y-m-d');?>" required>
        </div>
        <div class="form_entry">
            <label>Address</label>
            <input type="text" name="address" required>
        </div>
        <div class="form_entry">
            <label>City</label>
            <input type="text" name="city" required>
        </div>
        <div class="form_entry">
            <label>Description</label>
            <textarea name="description" rows="5" required>Tell us a little bit about your conference :)</textarea>
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
