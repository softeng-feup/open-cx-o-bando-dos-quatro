<?php function draw_conference_list_item($conference) { ?>
    <li class="conference_item">
        <span><?=$conference['name']?></span>
        <a href="../pages/edit_conference.php?id=<?=$conference['id']?>">Edit</a>
        <a href="../actions/delete_conference.php?id=<?=$conference['id']?>">Delete</a>
    </li>
<?php } ?>