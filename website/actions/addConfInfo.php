<?php

include_once('../database/conference.php');
include_once('../debug/debug.php');



$conf_name = $_POST['name'];
$conf_code = $_POST['code'];
$x = $_POST['x'];
$y = $_POST['y'];
$tag = $_POST['tag'];
$first_id = $_POST['first_id'];
$second_id = $_POST['second_id'];


if($conf_name && $conf_code){
   if(validInfo($conf_name, $conf_code)){
       if(!confNameExists($conf_name)){
           if(!confCodeExists($conf_code)){
                addNewConf($conf_name, $conf_code);
                $number_nodes = countNodes();
                addNodes($conf_name, $x, $y, $tag);
                addEdges($first_id, $second_id, $number_nodes);
            }
           else{
            $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This code is already associated with a conference...');
           }
        }
       else{
        $_SESSION['messages'][] = array('type' => 'error', 'content' => 'This conference already exists!');
       }
   }
   else{
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Conference name or conference code do not follow the rules!');
        //header('Location: ../create.html'); 
   }
}
else{
    $_SESSION['messages'][] = array('type' => 'error', 'content' => 'Conference name and conference code must be field');
   // header('Location: ../create.html'); 
}



?>