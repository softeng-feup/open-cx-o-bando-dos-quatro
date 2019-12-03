<?php
    
?>
<h1>
    SIGN UP
</h1>
<div>
    <form action="../actions/signup.php" method="post">
        <label for="username" id="user">Username</label>
        <input type="text" id="username" name="username">
        <label for="pass" id="password">Password</label>
        <input type="password" id="pass" name="password" minlength="8" required>

        <label for="r_pass" id="r_password">Repeat Password</label>
        <input type="password" id="r_pass" name="r_password" minlength="8" required>

        <input type="submit" value="Sign in">
    </form>

</div>