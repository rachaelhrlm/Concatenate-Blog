<?php
session_start();
require_once ('connection.php');
?>

<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        $db = Db::getInstance();
        if (isset($_POST['changeemail'])) {

        $_SESSION['username'] = $_POST['username'];
        $password = $_POST['password'];

        $stmt = $db->prepare("SELECT userName, passwords FROM member WHERE userName =:username");
        $stmt->bindParam(":username", $_SESSION['username']);
       
        $stmt->execute();
        $count = $stmt->rowCount();
        $data = $stmt->fetchall();
        foreach ($data as $row) {
        $hashed_password = $row['passwords'];
        }



        if ($count > 0) {
        if(password_verify($password, $hashed_password)) {
        ?>
        <form action =" " method="POST">
            change Email:
            <input required type = "email" name = "newemail" required>

            Confirm Email:
            <input required type = "email" name = "confirmemail" required>
            
                            
                <button type='submit'>Change Email</button>
            
            

        </form>

        <?php
        } else {

        echo "Incorrect. Please try again.";
        }
        }
        } else if (!empty($_POST['newemail'])) {
        if ($_POST['newemail'] != $_POST['confirmemail']) {
        echo "Email addresses do not match, please try again.";
        } else {
            
            //echo $_SESSION['username'];

        $_SESSION['email'] = $_POST['newemail'];
        $stmt = $db->prepare("UPDATE member SET email =? WHERE userName =?");
        //$stmt = bindParam(":name", $_SESSION['username']);
        //$stmt = bindParam(":newemail", $_SESSION['email']);

        $stmt->execute([$_SESSION['email'],$_SESSION['username']]);
        $count = $stmt->rowCount();
        if ($count > 0) {

        echo "Success.Meow.";
        } else {

        echo "Try again.";
        }
        }
        } else {
        ?>               <form method = "POST" >
            
                Username: <input type='text' name='username' required>                 
                Password: <input type='password' name='password' required>                 
                <input type="hidden" name="changeemail" value="true">                
                <button type='submit'>Submit</button>             
            </form>             <?php
        }
        















        //$_SESSION ['username'] = 'test';
        ?>
    </body>
</html>
