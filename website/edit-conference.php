<?php

    include_once ('./include_data_base.php');

    $db = Database::instance()->db;

    $stmt = $db->prepare('SELECT * FROM location');
    $stmt->execute();
    
    $rows = $stmt->fetchAll();
    foreach($rows as $row){
        ?>
              <?php echo $row['id']?> 
        <?php
    }
    ?>
