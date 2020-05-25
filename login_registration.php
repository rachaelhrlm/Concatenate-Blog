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

        $req = $db->prepare("SELECT * FROM securityquestions");

        $req->execute();
        $count = $req->rowCount();
        $security = $req->fetchall();



        if (isset($_POST['login'])) {
            $login_username = $_POST['login_username'];
            //The password is encrypted
            $login_password = $_POST['login_password'];
            $stmt = $db->prepare("SELECT userName, passwords,accessLevelID FROM member WHERE userName =:username");
            $stmt->bindParam(":username", $login_username);
            $stmt->execute();
            $count = $stmt->rowCount();
            $data = $stmt->fetchall();
            foreach ($data as $row) {
                $hashed_password = $row['passwords'];
                $access = $row['accessLevelID'];
            }
            if ($count > 0) {
                if (password_verify($login_password, $hashed_password)) {
                    $_SESSION["username"] = $login_username;
                    $_SESSION["accessid"] = $access;
                    $_SESSION['start'] = time(); // Taking now logged in time.
                    // Ending a session in 15 minutes from the starting time.
                    $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
                    header("location: dashboard.php");
                } else {
                    echo "Password incorrect.";
                }
            } else {
                echo "Username does not exist.";
            }
        }
        if (isset($_POST['register'])) {
            if (isset($_POST['confirm'])){
                $username = $_POST['username'];
                $req = $db->prepare("SELECT userName FROM member WHERE userName =:username");
            $req->bindParam(":username", $username);
            $req->execute();
            $count = $req->rowCount();
            if ($count > 0) {

                echo "Username already in use, please chose another one.";
            } else {



                if ($_POST['password'] != $_POST['confirm_password']) {
                    echo "Passwords do not match. Please try it again.";
                } else {




                    $uppercase = preg_match('@[A-Z]@', $_POST['password']);
                    $lowercase = preg_match('@[a-z]@', $_POST['password']);
                    $number = preg_match('@[0-9]@', $_POST['password']);
                    $specialChars = preg_match('@[^\w]@', $_POST['password']);

                    if (!$uppercase || !$lowercase || !$number || !$specialChars || strlen($password) < 8) {
                        echo 'Password should be at least 8 characters in length and should include at least one upper case letter, one number, and one special character.';
                    } else {



                        
                        $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

                        $email = $_POST ['email'];

                        $stmt = $db->prepare("INSERT INTO member (email, userName,passwords) VALUES (:email ,:username,:password)");

                        $stmt->bindParam(':username', $username);

                        $stmt->bindParam(":email", $email);
                        $stmt->bindParam(':password', $password);

                        $stmt->execute();
                        $id = $db->lastInsertId();
                        $count = $stmt->rowCount();

                        if ($count > 0) {
                            $securityid = intval($_POST['securityID']);
                            $securityanswer = $_POST['securityanswer'];
                            $req2 = $db->prepare("INSERT INTO security (memberID, securityID, securityanswer) VALUES (?, ?, ?)");


                            $req2->execute([intval($id), $securityid, $securityanswer]);
                            $_SESSION["username"] = $username;
                            $_SESSION["accessid"] = 3;
                            $_SESSION['start'] = time(); // Taking now logged in time.
                            // Ending a session in 15 minutes from the starting time.
                            $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
                            header("location: dashboard.php");
                            echo "Hello " . $_SESSION["username"] . ". Registration Successful";
                        } else {
                            echo "Registration Unsuccessful";
                        }
                    }
            }}} else {
                    echo "whaaaaaaaaaaaaaaaaaaaaaaaaaaaat?";
                }
            
        }
        ?>

        <h3>Log In Here</h3>

        <form action = "" method = "POST">
            Username:
            <input type = "text" name = "login_username"required>
            Password:
            <input type = "password" name = "login_password"required>
            <button type = 'submit' name = 'login'>Log In</button>
        </form>

        <h3>Register Today!</h3>
        <form action = "" method = "POST" name="register" onSubmit="return confirm();">
            Username:
            <input type = "text" name = "username"required>
            Password:
            <input type = "password" name = "password" required>
            Confirm Password:
            <input type = "password" name = "confirm_password" required>

            Security Questions:
            <select class="custom-select" name="securityID"> 


<?php foreach ($security as $securityquestion) { ?> 

                    <option value="
    <?php echo $securityquestion['securityID'] ?>">

                            <?php echo $securityquestion['securityquestion'] ?></option>                             
                    <?php } ?>                     
            </select>
            <input required type='text' name=' securityanswer' required>


            Email:
            <input required type = "email" name = "email" required>


            <button type = 'submit' name = 'register'>Register</button>

            <input type = "checkbox" name = "confirm" value = "Agree">I confirmed that I like cats.


        </form>









    </body>
</html>