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
                <form action = "changepassword.php" method = "POST">
                    <input type='password' name='password'>
                    <button type='submit' name='reset'>Change Password</button>
                </form>
                <?php
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
<?php } ?>
    </body>
</html>
