<?php    


 
    $name = $_POST["name"];
    $code = $_POST["code"];

    echo 'your conference name is ';
    echo $name;
    echo ' and has the code ';
    echo $code;
    

    
    $array = $_POST["element-wrapper"];
    

    $counter = 0;

    $x = 0;
    $y = 0;
    $tag = true;

    echo ' yey';
    echo count($array);

    while($counter != sizeof($array)){

        echo 'hi';
        $node = $array[$counter];

        echo $node;

        $counter = $counter + 1;

    }
    
?>
