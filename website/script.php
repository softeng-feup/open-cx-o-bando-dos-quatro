<script>
    $(document).ready(function(){
        var i=1;
        $('#add').click(function(){
            i++;
            $('#dynamic_field').append('<tr id="row'+i+'"><td><fieldset><legend>Node:</legend><label>x_coordinate: <input type="number"></label><label>y_coordinate: <input type="number"></label><label>Is this node a tag? <input type="checkbox"></label></fieldset></td><td><button type="button" name="remove" id="'+i+'" class="btn btn-danger btn_remove">X</button></td></tr>');
        });
            
        $(document).on('click', '.btn_remove', function(){
            var button_id = $(this).attr("id"); 
            $('#row'+button_id+'').remove();
        });
            
        $('#submit').click(function(){		
            $.ajax({
                url:"name.php",
                method:"POST",
                data:$('#add_node').serialize(),
                success:function(data)
                {
                    alert(data);
                $('#add_node')[0].reset();
                }
            });
        });
            
    });
</script>