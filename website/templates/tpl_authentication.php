<?php function draw_login() { ?>
    <section id="login">
        <header><h2>Login</h2></header>

        <form action="../actions/login.php" method="post">
            <div class="form_entry">
                <label>Username</label>
                <input type="text" name="username" autofocus required>
            </div>
            <div class="form_entry">
                <label>Password</label>
                <input type="password" name="password" minlength="8" required>
            </div>
            <input type="submit" value="Log in">
        </form>

        <footer>
            <p>Don't have an account? <a href="../pages/signup.php">Sign up!</a>
        </footer>
    </section>
<?php } ?>

<?php function draw_signup() { ?>
    <section id="signup">
        <header><h2>Sign up</h2></header>

        <form action="../actions/signup.php" method="post">
            <div class="form_entry">
                <label>Username</label>
                <input type="text" name="username" autofocus required>
            </div>
            <div class="form_entry">
                <label>Password</label>
                <input type="password" name="password" minlength="8" required>
            </div>
            <div class="form_entry">
                <label>Repeat password</label>
                <input type="password" name="r_password" minlength="8" required>
            </div>
            <input type="submit" value="Sign up">
        </form>

        <footer>
            <p>Already have an account? <a href="../pages/login.php">Log in!</a>
        </footer>
    </section>
<?php } ?>
