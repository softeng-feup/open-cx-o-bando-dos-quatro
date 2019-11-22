<?php

    // placeholder
    $output = NULL;

    if(isset($_POST['submit'])){

        //when submitted
        $name = $_POST['name'];
        $code = $_POST['code'];

        

        $x = $_POST['x'];
        $y = $_POST['y'];
        $tag = $_POST['tag'];

        echo "Conference name: ";
        echo $name;
        echo "<br>";
        
        echo "Conference code: ";
        echo $code;
        echo "<br>";


        $keysOne = array_keys($x);
        $keysTwo = array_keys($y);
        //$keysThree = array_keys($tag);

        $min = min(count($x), count($y));

        for($i = 0; $i < $min; $i++) {
            echo $x[$keysOne[$i]] . "<br>";
            echo $y[$keysTwo[$i]] . "<br><br>";
            //echo $tag[$keysThree[$i]] . "<br><br>";
        }

    }


?>
