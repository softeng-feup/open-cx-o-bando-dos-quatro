<html>
    <head>
        <title> ConfView Creator </title>
        <meta charset="UTF_8">
        <script type="text/javascript" src="jquery-3.2.1.min.js"></script>

        <!-- javascript -->
        <script>
            
            $(document).ready(function(e){

                /* ------------------------------------- */
                /* --------------- NODES --------------- */
                /* ------------------------------------- */

                // Variables
                var html = '<p/><div>x_coordinate: <input type="number" name="x[]" id="child_x_coordinate"/>y_coordinate: <input type="number" name="y[]" id="child_y_coordinate"/>Tag (y/n)? <input type="text" name="tag[]" id="child_tag"/><a href="#" id="remove">x</a></div>';

                // Add nodes
                $("#add").click(function(e){
                    $("#container").append(html);
                });

                // remove nodes
                $("#container").on('click', '#remove', function(e){
                    $(this).parent('div').remove();
                });


                
                
                /* ------------------------------------- */
                /* --------------- EDGES --------------- */
                /* ------------------------------------- */

                // Variables
                var edges = '<p/><div>Node id: <input type="number" name="first_id[]" id="child_id1"/>connects to Node id: <input type="number" name="second_id[]" id="child_id2"/><a href="#" id="remove_edge">x</a></div>';

                // Add Edges
                $("#add_edge").click(function(e){
                    $("#edge_container").append(edges);
                });

                // remove nodes
                $("#edge_container").on('click', '#remove_edge', function(e){
                    $(this).parent('div').remove();
                });

            });

        </script>

    </head>

    <body>

        <header>
            <h1> Confview Creator </h1>
            <h2> Create your own Conference Guide </h2>
            <h3> Welcome to ConfView, here you can map your event's venue. </h3>
        </header>


        <section id="form">
            <form action="../actions/addConfInfo.php" method="POST">

                <label></label>Conference Name: <input type="text" name="name"/></label>
                <label></label>Conference Code: <input type="number" name="code"/></label>
                <label>Start Date<input id="check-in" type="date" value="<?php echo date('Y-m-d');?>"></label>
                <label>End Date<input id="check-out" type="date" value="<?php echo date('Y-m-d', strtotime('tomorrow'));?>"></label>
                
                <br>
                <br>

                <!-- container for the nodes -->
                Here you should fill out information about each node of the conference venue.
                <br>
                You must tell us the coordinates of each point of the map in order for us to generate it.
                <div id="container">
                    x_coordinate: <input type="number" name="x[]" id="x_coordinate"/>
                    y_coordinate: <input type="number" name="y[]" id="y_coordinate"/>
                    Tag (y/n)? <input type="text" name="tag[]" id="tag2"/>
                    <a href="#" id="add">
                        Add Node
                    </a>
                </div>

                <br>
                <br>

                <!-- container for the edges -->
                Here you should tell us which nodes are connected. The id of each node is a reference to the way they were input before (the id of the first node is 1, of the second node is 2, ...).
                <div id="edge_container">
                    Node id: <input type="number" name="first_id[]" id="id1"/>
                    connects to
                    Node id: <input type="number" name="second_id[]" id="id2"/>
                    <a href="#" id="add_edge">
                        Add Edge
                    </a>
                </div>

                <br>
                <input type="submit" name="submit"/>
            
            </form>
        </section>
    </body>
</html>