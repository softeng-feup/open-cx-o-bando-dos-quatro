<?php    


 
    $name = $_POST["name"];
    $code = $_POST["code"];

    echo 'your conference name is ';
    echo $name;
    echo ' and has the code ';
    echo $code;
    

    
    $array = $_POST["element"];
    

    $counter = 0;

    $x = $_POST["x_coordinate"];
    $y = $_POST["y_coordinate"];
    $tag = true;

    echo ' yey';
    echo sizeof($array);

    while($counter != sizeof($array)){

        echo 'hi';
        $node = $array[$counter];

        echo $node;

        $counter = $counter + 1;

    }
    
?>
