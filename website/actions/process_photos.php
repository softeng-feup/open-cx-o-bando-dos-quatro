<?php


    include_once('../database/conference.php');
    include_once('../includes/session.php');
    
    if(isset($_FILES['images']) && isset($_POST['node_id'])){
        
        // gets all files
        $images = $_FILES['images'];


        // gets all the node ids
        $node_id = $_POST['node_id'];

        $i = 0;
        foreach($_FILES['images']['tmp_name'] as $index => $tmpName ){
            
            $target = "../images/".basename($_FILES['images']['name'][$i]);

            if(move_uploaded_file($tmpName, $target)){
                
                // inserir na base de dados aqui;
                insertPhotos($node_id[$i], $target);

            }

            $i = $i + 1;


        }
        
        header("Location: ../src/website.php");

    }

    
    
?>