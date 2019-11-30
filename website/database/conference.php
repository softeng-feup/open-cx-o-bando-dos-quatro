<?php

    include_once('../includes/include_data_base.php');
    include_once('../debug/debug.php');

    function validInfo($conf_name, $conf_code){
        if(preg_match ("/^[a-zA-Z0-9]+$/", $conf_name)){
            if(strlen($conf_code) >=4){
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

    function confCodeExists($conf_code){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT * FROM conference WHERE code = ?');
        $stmt->execute([$conf_code]);

        return $stmt->fetch();
    }

    function getConfID($conf_name){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT id FROM conference WHERE confName = ?');
        $stmt->execute([$conf_name]);

        return $stmt->fetch()['id'];

    }

    function addNewConf($conf_name, $conf_code){

        $db = Database::instance()->db();

        $stmt = $db->prepare('INSERT INTO conference(confName, code) VALUES(?,?)');
        $stmt->execute(array($conf_name, $conf_code));
       
     
    }

    function addNodes($conf_name, $x, $y, $tag){

        $db = Database::instance()->db();

        $keys1 = array_keys($x);
        $keys2 = array_keys($y);
        $keys3 = array_keys($tag);

        $conf_id = getConfID($conf_name);
        $min = min(count($x), count($y));

        for($i = 0; $i < $min; $i++) {
            $stmt = $db->prepare('INSERT INTO node(conference_id, x_coord, y_coord, isTag) VALUES(?, ?, ?, ?)');

            if($tag[$keys3[$i]] == "y"){
                $stmt->execute(array($conf_id, $x[$keys1[$i]], $y[$keys2[$i]], true));
            }
            else{
                $stmt->execute(array($conf_id, $x[$keys1[$i]], $y[$keys2[$i]], false));
            }    
        }
    }

    function addEdges($first_id, $second_id, $nodes_number){

        $db = Database::instance()->db();

        $keys1_edge = array_keys($first_id);
        $keys2_edge = array_keys($second_id);
        

        $min_edge = min(count($first_id), count($second_id));
    
        for($j = 0; $j < $min_edge; $j++) {
            
            $nodeX = $first_id[$keys1_edge[$j]];
            $sum_nodesX = $nodeX + $nodes_number;
            console_log($nodeX);
            console_log($sum_nodesX);

            $nodeY = $second_id[$keys2_edge[$j]];
            $sum_nodesY = $nodeY + $nodes_number;
            console_log($nodeY);
            console_log($sum_nodesY);


            $stmt = $db->prepare('INSERT INTO edge(origin_node, dest_node) VALUES(?, ?)');
            $stmt->execute(array($sum_nodesX, $sum_nodesY));
        }

    }

    function countNodes(){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT COUNT(id) AS num FROM node');
        $stmt->execute();

        return $stmt->fetch()['num'];
    }

?>