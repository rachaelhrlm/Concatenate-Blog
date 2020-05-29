<?php
session_start();
if (!isset($_SESSION['username'])) {
    echo "Please Login again";
    echo "<a href='login_registration.php'>Click Here to Login</a>";
} else {
    $time = $_SERVER['REQUEST_TIME'];
    $timeout_duration = 15 * 60;
    if (isset($_SESSION['LAST_ACTIVITY']) &&
            ($time - $_SESSION['LAST_ACTIVITY']) > $timeout_duration) {
        session_unset();
        session_destroy();
        session_start();
        $_SESSION['LAST_ACTIVITY'] = $time;
        echo "Your session has expired!";
    } else { 
        ?>
        <html>
            <head>
                <meta charset="UTF-8">
                <title></title>
            </head>
            <body>
        <?php
        echo "welcome" . $_SESSION['username'];
        echo "<a href='changepassword.php'>Click Here to change your password</a>";
    }
    }
?>

    </body>
</html>
