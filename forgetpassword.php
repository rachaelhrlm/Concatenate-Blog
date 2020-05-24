<?php session_start(); ?>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        $dsn = "mysql:host=127.0.0.1;dbname=blog";
        $user = "root";
        $password = NULL;
        $options = NULL;
        $message = "";
        try {
            $pdo = new PDO($dsn, $user, $password, $options);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (Exception $e) {
            $message = $e->getMessage();
        }

        if (isset($_POST['recover'])) {
            $_SESSION ['username'] = $_POST['login_username'];
            $_SESSION ['email'] = $_POST['email'];

            $stmt = $pdo->prepare("SELECT userName, email FROM member WHERE userName =:username and email =:email");
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
                $password = $_POST['password'];
//    I get rid of this first to help you validate your change
//    $password = password_hash($_POST['password'], PASSWORD_DEFAULT); (thanks!!! very useful)
                $stmt = $pdo->prepare("UPDATE member SET passwords =:password WHERE userName =:username");
                $stmt->bindParam(":username", $_SESSION['username']);
                $stmt->bindParam(":password", $password);

                $stmt->execute();
                $count = $stmt->rowCount();
                if ($count > 0) {
                    echo "Success!";
                } else {
                    echo "Try again";
                }
            } else{
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
