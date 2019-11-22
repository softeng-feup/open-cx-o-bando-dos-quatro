<?php

include_once('../database/user.php');

$conf_name = $_POST['username'];
$conf_code = $_POST['password'];

if($conf_name && $conf_code){
   if(validInfo($conf_name, $conf_code)){
       if(!confNameExists()){
            if(addNewConf($conf_name, $conf_code) != -1){

            }
            else{

            }
       }
       else{

       }
   }
   else{

   }
}
else{
    header('Location: ../create.html'); //se der erro redirecionar novamente para signup page
    $_SESSION["ERROR"] = "Conference Name and Conference Code must be field.";
}



?>