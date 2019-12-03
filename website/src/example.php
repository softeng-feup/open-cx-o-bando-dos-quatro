<?php

    // placeholder
    //$output = NULL;

    // include the database
    include_once('../includes/include_data_base.php');

    // access database
    


    if(isset($_POST['submit'])){

        //when submitted
        $name = $_POST['name'];
        $code = $_POST['code'];

        echo "Conference name: ";
        echo $name;
        echo "<br>";
        
        echo "Conference code: ";
        echo $code;
        echo "<br>";

        $db = Database::instance()->db();

    
        $x = $_POST['x'];
        $y = $_POST['y'];
        $tag = $_POST['tag'];

        $first_id = $_POST['first_id'];
        $second_id = $_POST['second_id'];
    
        // insert function here
        // code to input into the databse hardcoded for now
        $stmt = $db->prepare('INSERT INTO conference(confName, code) VALUES(?, ?)');
        $stmt->execute(array($name, $code));


        $keysOne = array_keys($x);
        $keysTwo = array_keys($y);
        $keysThree = array_keys($tag);

        $min = min(count($x), count($y));

        for($i = 0; $i < $min; $i++) {
            echo $x[$keysOne[$i]] . "<br>";
            echo $y[$keysTwo[$i]] . "<br>";
            echo $tag[$keysThree[$i]] . "<br><br>";

            
            
            $stmt = $db->prepare('INSERT INTO node(conference_id, x_coord, y_coord, isTag) VALUES(?, ?, ?, ?)');
            if($tag[$keysThree[$i]] == "y"){
                $stmt->execute(array(1, $x[$keysOne[$i]], $y[$keysTwo[$i]], true));
            }
            else{
                $stmt->execute(array(1, $x[$keysOne[$i]], $y[$keysTwo[$i]],false));
            }
            
        }


        $keysOne_edge = array_keys($first_id);
        $keysTwo_edge = array_keys($second_id);

        $min_edge = min(count($first_id), count($second_id));

        for($j = 0; $j < $min_edge; $j++) {
            echo $first_id[$keysOne_edge[$j]] . "<br>";
            echo $second_id[$keysTwo_edge[$j]] . "<br><br>";

            // code to input the edges into the database
            // hardcoded for now, to test the for cycle
            $stmt = $db->prepare('INSERT INTO edge(origin_node, dest_node) VALUES(?, ?)');
            $stmt->execute(array($first_id[$keysOne_edge[$j]], $second_id[$keysTwo_edge[$j]]));
        }


       
        
    }

?>

