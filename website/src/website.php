<?php
    include_once('../includes/session.php');
    include_once('../database/conference.php');
?>


<head>
    <title> ConfView Creator </title>
    <meta charset="UTF_8">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
    <header>
        <h1> Confview Creator </h1>
        <h2> 
            <?php  if(isset($_SESSION['username'])){ ?>

            Welcome, <?= $_SESSION['username']  ?> 

            <?php } ?>
        </h2>
    </header>

    <div>
        
        <?php
        
            if(isset($_SESSION['username'])){ ?>
                <p>
                <h3>
                Your Conferences:
                </h3>
                </p>
                <?php $conferences = list_conferences(get_user_id($_SESSION['username']));

                foreach($conferences as $conference){
                    
                    ?>

                    <section id="display_conferences">
                        <li> <?= $conference['confName']; ?>   <a href="./edit-conference.php?id=<?=$conference['id']?>">Edit</a>  <a href="../actions/action_delete.php?id=<?=$conference['id']?>">Delete </a></li>
                    </section>

                    <?php
                }
                ?>
                
                
        <?php
            }
                
        ?>

    </div>

    <br>
    <br>
    <br>

    <nav id="create">
        <a href="create.php" style="color: #000000"> Set Up a new Conference </a>
    </nav>

    <div id="logout"><a href="../actions/logout.php" style="color: #000000"> Logout </a></div>
</body>
