<?php

include_once('../database/user.php');

$conf_name = $_POST['name'];
$conf_code = $_POST['code'];
$x_coords = $_POST['x'];
$y_coords = $_POST['y'];
$tags = $_POST['tag'];
$first_ids = $_POST['first_id'];
$second_ids = $_POST['second_id'];

if($conf_name && $conf_code){
   if(validInfo($conf_name, $conf_code)){
       if(!confNameExists($conf_name)){
            addNewConf($conf_name, $conf_code);
            //addNodesToConf($conf_name,$x_coords, $y_coords, $tags);
            //addEdges();
        }
       else{
        $_SESSION["ERROR"] = "This conference already exists...";
       }
   }
   else{
        $_SESSION["ERROR"] = "Conference Name or Conference Code do not follow required parameters.";
        header('Location: ../create.html'); 
   }
}
else{
    $_SESSION["ERROR"] = "Conference Name and Conference Code must be field.";
    header('Location: ../create.html'); 
}



?>