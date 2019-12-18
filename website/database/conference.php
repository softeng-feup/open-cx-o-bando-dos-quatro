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

    function addNewConf($user_id, $conf_name, $conf_code, $conf_start, $conf_end, $conf_address, $conf_city, $conf_description){

        $db = Database::instance()->db();

        $version = 1;

        $stmt = $db->prepare('INSERT INTO conference(user_id, confName, code, startdate, enddate, addr, city, descr, version) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)');
        $stmt->execute(array($user_id, $conf_name, $conf_code, $conf_start, $conf_end, $conf_address, $conf_city, $conf_description, $version));
       
     
    }

    function addNodes($conf_name, $x, $y, $tag, $name){

        $db = Database::instance()->db();

        $keys1 = array_keys($x);
        $keys2 = array_keys($y);
        $keys3 = array_keys($tag);
        $keys4 = array_keys($name);

        $conf_id = getConfID($conf_name);
        $min = min(count($x), count($y));

        for($i = 0; $i < $min; $i++) {
            $stmt = $db->prepare('INSERT INTO node(conference_id, name, x_coord, y_coord, isTag) VALUES(?, ?, ?, ?, ?)');

            if($tag[$keys3[$i]] == "y"){
                $stmt->execute(array($conf_id, $name[$keys4[$i]], $x[$keys1[$i]], $y[$keys2[$i]], true));
            }
            else{
                $stmt->execute(array($conf_id, $name[$keys4[$i]], $x[$keys1[$i]], $y[$keys2[$i]], false));
            }    
        }
    }

    function addEdges($first_id, $second_id, $nodes_number, $conf_id){

        $db = Database::instance()->db();

        $keys1_edge = array_keys($first_id);
        $keys2_edge = array_keys($second_id);

        print_r($first_id[$keys1_edge]);
        print_r($second_id[$keys2_edge]);
        

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


            $stmt = $db->prepare('INSERT INTO edge(conference_id, origin_node, dest_node) VALUES(?, ?, ?)');
            $stmt->execute(array($conf_id, $sum_nodesX, $sum_nodesY));
        }

    }

    function countNodes(){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT COUNT(id) AS num FROM node');
        $stmt->execute();

        return $stmt->fetch()['num'];
    }

    function getLastNode(){

        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT MAX(id) AS num FROM node');
        $stmt->execute();

        return $stmt->fetch()['num'];

    }

    function available_username($username){

        $db = Database::instance()->db();
        $stmt = $db->prepare('SELECT * FROM user WHERE username = ?');
        $stmt->execute(array($username));

        return $stmt->fetch() ? false : true;

    }

    function insert_user($username, $password){

        $db = Database::instance()->db();

        $hash_password = password_hash($password, PASSWORD_DEFAULT);

        $stmt = $db->prepare('INSERT INTO user(username, password) VALUES(?, ?)');
        $stmt->execute(array($username, $hash_password));

        return true;

    }


    function valid_login($username, $password){

        $db = Database::instance()->db();
        
        $stmt = $db->prepare('SELECT * FROM user WHERE username = ?');
        $stmt->execute(array($username));

        $user = $stmt->fetch();

        return $user !== false && password_verify($password, $user['password']);

    }

    function get_user_id($username){

        $db = Database::instance()->db();
        
        $stmt = $db->prepare('SELECT id FROM user WHERE username = ?');
        $stmt->execute(array($username));

        return $stmt->fetch()['id'];

    }

    function get_user_name($id){

        $db = Database::instance()->db();
        
        $stmt = $db->prepare('SELECT username FROM user WHERE id = ?');
        $stmt->execute(array($id));

        return $stmt->fetch()['username'];

    }


    function list_conferences($user_id){

        $db = Database::instance()->db();
        
        $stmt = $db->prepare('SELECT * FROM conference WHERE user_id = ?');
        $stmt->execute(array($user_id));

        return $stmt->fetchAll();

    }

    function delete_conference($id){
        $db = Database::instance()->db();

        $stmt = $db->prepare('DELETE FROM conference WHERE id=?');
        $stmt->execute(array($id));
    }

    function conference_information($id){
        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT * FROM conference WHERE id=?');
        $stmt->execute(array($id));

        return $stmt->fetch();
    }

    function update_conference_info($new_name, $new_code, $new_start, $new_end, $new_address, $new_city, $new_description, $id){
        $db = Database::instance()->db();

        $old_version = get_conference_version($id);
        $new_version = $old_version['version'] + 1;

        $stmt = $db->prepare('UPDATE conference SET (confName, code, startdate, enddate, addr, city, descr, version) = (?, ?, ?, ?, ?, ?, ?, ?) WHERE id = ?');
        $stmt->execute(array($new_name, $new_code, $new_start, $new_end, $new_address, $new_city, $new_description,$new_version, $id));
    
    }
  
    function conference_nodeIDS($conference_id){
        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT id FROM node WHERE conference_id=?');
        $stmt->execute(array($conference_id));

        return $stmt->fetchAll();
    }

    function get_coords_info($node_id){
        $db = Database::instance()->db();

        $stmt = $db->prepare('SELECT * FROM node WHERE id=?');
        $stmt->execute(array($node_id));

        return $stmt->fetch();
    }


    function update_conference_nodes($name, $x, $y, $tag, $ids, $conf_id){
        $db = Database::instance()->db();


        $keys1 = array_keys($x);
        $keys2 = array_keys($y);
        $keys3 = array_keys($tag);
        $keys4 = array_keys($ids);

        $keys5 = array_keys($name);


        $old_ids = count($ids);
        $min = min(count($x), count($y));

        for($i = 0; $i < $min; $i++){

            if($i < $old_ids){
                $stmt = $db->prepare('UPDATE node SET(name, x_coord, y_coord, isTag) = (?, ?, ?, ?) WHERE id = ?');

                if($tag[$keys3[$i]] == "y"){
                    $stmt->execute(array($name[$keys5[$i]], $x[$keys1[$i]], $y[$keys2[$i]], true, $ids[$keys4[$i]]));
                }
                else{
                    $stmt->execute(array($name[$keys5[$i]], $x[$keys1[$i]], $y[$keys2[$i]], false, $ids[$keys4[$i]]));
                }

            }
            else{
                $stmt = $db->prepare('INSERT INTO node(conference_id, name, x_coord, y_coord, isTag) VALUES(?, ?, ?, ?, ?)');

                if($tag[$keys3[$i]] == "y"){
                    $stmt->execute(array($conf_id, $name[$keys5[$i]], $x[$keys1[$i]], $y[$keys2[$i]], true));
                }
                else{
                    $stmt->execute(array($conf_id, $name[$keys5[$i]], $x[$keys1[$i]], $y[$keys2[$i]], false));
                }
            }
        }

    }

    function countTagNodes($conf_id){

        $db = Database::instance()->db();
        

        $stmt = $db->prepare('SELECT * FROM node WHERE (conference_id = ? AND isTag = 1)');
        $stmt->execute(array($conf_id));


        return $stmt->fetchAll();

    }

    function insertPhotos($node_id, $target){

        $db = Database::instance()->db();

        $stmt = $db->prepare('INSERT INTO image(node_id, IMAGE) VALUES(?, ?)');
        $stmt->execute(array($node_id, $target));

        return true;

    }

    function removeNodes($conf_id){
        
        $db = Database::instance()->db();

        $stmt = $db->prepare('DELETE FROM node WHERE conference_id = ?');
        $stmt->execute(array($conf_id));

    }

    function get_conference_version($conf_id){

        $db = Database::instance()->db();
        $stmt = $db->prepare('SELECT version FROM conference WHERE id=?');
        $stmt->execute(array($conf_id));


        return $stmt->fetch();
    }



?>