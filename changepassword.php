<?php
session_start();
require_once 'connection.php';
if (!isset($_SESSION['username'])) {
    echo "Please Login again";
    echo "<a href='login_registration.php'>Click Here to Login</a>";
} else {
    $now = time(); // Checking the time now when home page starts.

    if ($now > $_SESSION['expire']) {
        session_destroy();
        echo "Your session has expired!";
    } else { //Starting this else one [else1]
        ?>
        <html>
            <head>
                <meta charset="UTF-8">
                <title></title>
            </head>
            <body>
        <?php
        $db = Db::getInstance();
        if (isset($_POST['recover'])) {
            if ($_POST['password'] != $_POST['confirm_password']) {
                echo "Passwords do not match. Please try it again.";
            } else {
                $_SESSION ['email'] = $_POST['email'];
                $password = $_POST['password'];
                $stmt = $db->prepare("SELECT userName, email, passwords FROM member WHERE userName =:username and email =:email");
                $stmt->bindParam(":username", $_SESSION['username']);
                $stmt->bindParam(":email", $_SESSION['email']);
                $stmt->execute();
                $count = $stmt->rowCount();
                $data = $stmt->fetchall();
                foreach ($data as $row) {

                    $hashed_password = $row['passwords'];
                }
                if ($count > 0) {
                    if (password_verify($password, $hashed_password)) {
                        ?>
                                <form action = "" method = "POST">
                                    <input type='password' name='newpassword'>
                                    <button type='submit' name='reset'>Change Password</button>
                                </form>
                        <?php
                    }
                } else {
                    echo "password is incorrect. Please try again.";
                }
            }
        } else if (!empty($_POST['newpassword'])) {
            $newpassword = password_hash($_POST['newpassword'], PASSWORD_DEFAULT);
            $stmt = $db->prepare("UPDATE member SET passwords =:password WHERE userName =:username");
            $stmt->bindParam(":username", $_SESSION['username']);
            $stmt->bindParam(":password", $newpassword);

            $stmt->execute();
            $count = $stmt->rowCount();
            if ($count > 0) {
                echo "Success!";
            } else {
                echo "Try again";
            }
        } else {
            echo "Hello". $_SESSION['username'];
            ?>
                    <form method = "POST" >

                        Email address:
                        <input type='email' name='email' required>
                        Current Password:
                        <input type='password' name='password' required>
                        Confirm Password:
                        <input type='password' name='confirm_password' required>
                        <input type="hidden" name="recover" value="true">
                        <button type='submit'>Submit</button>
                    </form>
            <?php
        }
    }
}
?>
    </body>
</html>
