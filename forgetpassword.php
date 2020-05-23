<?php
session_start();
require_once 'connection.php';
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
            $_SESSION ['username'] = $_POST['login_username'];
            $_SESSION ['email'] = $_POST['email'];

            $stmt = $db->prepare("SELECT userName, email FROM member WHERE userName =:username and email =:email");
            $stmt->bindParam(":username", $_SESSION['username']);
            $stmt->bindParam(":email", $_SESSION['email']);


            $stmt->execute();
            $count = $stmt->rowCount();



            if ($count > 0) {
                ?>
                <form action = "" method = "POST">
                    <input type='password' name='password'>
                    <button type='submit' name='reset'>Change Password</button>
                </form>
                <?php
            }
        } else if (!empty($_POST['password'])) {
            $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
            $stmt = $db->prepare("UPDATE member SET passwords =:password WHERE userName =:username");
            $stmt->bindParam(":username", $_SESSION['username']);
            $stmt->bindParam(":password", $password);

            $stmt->execute();
            $count = $stmt->rowCount();
            if ($count > 0) {
                echo "Success!";
            } else {
                echo "Try again";
            }
        } else {
            ?>


            <form method = "POST" >

                Username:
                <input type='text' name='login_username' required>

                Email address:

                <input type='email' name='email' required>
                <input type="hidden" name="recover" value="true">
                <button type='submit'>Submit</button>
            </form>
            <?php
        }
        ?>
    </body>
</html>
