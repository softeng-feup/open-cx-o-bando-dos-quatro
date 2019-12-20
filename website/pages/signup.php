<?php

include_once('../includes/session.php');

include_once('../templates/tpl_common.php');
include_once('../templates/tpl_authentication.php');

?>

<!DOCTYPE html>
<html>
    <head>
        <title>ConfView</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
    <?php draw_header(); ?>
    <?php draw_signup(); ?>
    <?php draw_footer(); ?>