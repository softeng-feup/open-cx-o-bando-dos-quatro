<?php
    
?>
<h1>
    LOGIN
</h1>
<div>
    <form action="../actions/login.php" method="post">
        <label for="username" id="user">Username</label>
        <input type="text" id="username" name="username">
        <label for="pass" id="password">Password</label>
        <input type="password" id="pass" name="password" minlength="8" required>
        <input type="submit" value="Sign in">
    </form>
</div>
<div>
    Don't have an account?
    <a href = "./draw_signup.php" > Sign up</a>
</div>