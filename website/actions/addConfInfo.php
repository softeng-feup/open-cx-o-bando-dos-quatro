<?php

include_once('../database/user.php');

$conf_name = $_POST['username'];
$conf_code = $_POST['password'];

if($conf_name && $conf_code){
   if(validInfo($conf_name, $conf_code)){
       if(!confNameExists($conf_name)){
            if(addNewConf($conf_name, $conf_code) != -1){
                //mensagens
            }
            else{
                //mensagens
            }
       }
       else{
        $_SESSION["ERROR"] = "This conference already exists...";
       }
   }
   else{
    header('Location: ../create.html'); 
    $_SESSION["ERROR"] = "Conference Name or Conference Code do not follow required parameters.";
   }
}
else{
    header('Location: ../create.html'); 
    $_SESSION["ERROR"] = "Conference Name and Conference Code must be field.";
}



?>