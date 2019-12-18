<?php
include_once('../database/conference.php');
include_once('../debug/debug.php');
include_once('../includes/session.php');

$conf_id = $_GET['id'];

?>



<html>
    <head>
        <title> ConfView Creator </title>
        <meta charset="UTF_8">
        <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
        <link href="../css/style.css" rel="stylesheet">

    </head>

    <body>

        <header>
            <h1> Confview Creator </h1>
            <h2> Create your own Conference Guide </h2>
            <h3> Welcome to ConfView, here you can map your event's venue. </h3>
        </header>

        

        <section id="form">
            <form action="../actions/process_photos.php" method="POST" enctype="multipart/form-data">

                <?php $nodes = countTagNodes($conf_id);

                    $keys1 = array_keys($nodes);
                    $cnt = count($nodes);
                    
                    for($j = 0; $j < $cnt; $j++){
                        ?>
                        <li><?php
                        $nodeX = $nodes[$keys1[$j]];
                        echo $nodeX['name'];
                        ?>
                        <input type="file" name="images[]" multiple=""></li>
                        <input type='hidden' name='node_id[]' value='<?php echo $nodeX['id'];?>'/>
                        <?php
                    }
                ?>

                 

                <input type="submit" name="submit" id="submit" value="Submit"/>

            </form>
        </section>