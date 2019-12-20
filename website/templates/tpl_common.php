<?php function draw_header() { ?>
            <header>
                <nav>
                    <ul id="menu">
                    <?php if (isset($_SESSION['username'])) { ?>
                        <li>Hello <?=$_SESSION['username']?>!</li>
                        <li><a href="../actions/logout.php">Logout</a></li>
                    <?php } else { ?>
                        <li><a href="../pages/login.php">Log in</a></li>
                        <li><a href="../pages/signup.php">Sign up</a></li>
                    <?php } ?>
                    </ul>
                </nav>
            </header>
            <div id="content">
            <?php if (isset($_SESSION['messages'])) { ?>
                <section id="messages">
                <?php foreach($_SESSION['messages'] as $message) { ?>
                    <div class="<?=$message['type']?>"><?=$message['content']?></div>
                <?php } ?>
                </section>
            <?php unset($_SESSION['messages']); } ?>
<?php } ?>


<?php function draw_footer() { ?>
            </div>
            <footer>
                <p>&copy; ConfView, ESOF-2019</p>
                <p>António Dantas, Bernardo Santos, Gustavo Torres, Vítor Gonçalves</p>
            </footer>
        </body>
    </html>
<?php } ?>
