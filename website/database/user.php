<?php

include_once('../includes/include_data_base.php');

    function validInfo($conf_name, $conf_code){

        if(preg_match ("/^[a-zA-Z0-9]+$/", $conf_name)){
            if(strlen($conf_code) >=6 && (strcspn($password,'0123456789') + 1)){
                return true;
            }
        }

        return false;
    }

    function confNameExists($conf_name){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT * FROM conference WHERE confName = ?');
        $stmt->execute([$conf_name]);

        return $stmt->fetch();
    }

?>