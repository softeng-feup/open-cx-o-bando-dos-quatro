<?php

include_once('../database/user.php');

$conf_name = $_POST['username'];
$conf_code = $_POST['password'];

if($conf_name && $conf_code){
   if(validInfo($conf_name, $conf_code)){
       if(!confNameExists($conf_name)){
            addNewConf($conf_name, $conf_code);
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