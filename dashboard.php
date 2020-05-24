<?php
session_start();
    if (!isset($_SESSION['username'])) {
        echo "Please Login again";
        echo "<a href='login_registration.php'>Click Here to Login</a>";
    }
    else {
        $now = time(); // Checking the time now when home page starts.

        if ($now > $_SESSION['expire']) {
            session_destroy();
            echo "Your session has expired!";
        }
        else { //Starting this else one [else1]
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
echo "welcome" .$_SESSION['username'];
        echo "<a href='changepassword.php'>Click Here to change your password</a>";
        }
    }
?>
       
    </body>
</html>
