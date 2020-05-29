<?php session_start(); ?>
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        require_once 'connection.php';
        $db = Db::getInstance();
        if (isset($_POST['recover'])) {
            $keyword = $_POST['keyword'];
            $stmt = $db->prepare("call forgetpassword(?)");
            $stmt->execute([$keyword]);
            $count = $stmt->rowCount();
            $data = $stmt->fetchall();
            foreach ($data as $row) {
                $securityquestion = $row['securityquestion'];
                $_SESSION['securityanswer'] = $row['securityanswer'];
                $_SESSION['id'] = intval($row['memberID']);
            }
            if ($count > 0) {
                ?>
                Security question : <?php echo $securityquestion; ?>
                Your answer is:        
                <form action = "" method = "POST">
                    <input type='text' name='answer' required>
                    <button type='submit' name='submit'>Submit</button>
                </form>
                <?php
            }
        } else if (isset($_POST['submit'])) {
            $answer = $_POST['answer'];
            if ($answer = $_SESSION['securityanswer']) {
                ?>
                Your answer is validated. Seems like you are not an attacker, meow! <br>
                Please enter your new password.
                <form action = "" method = "POST">
                    <input type='password' name='password' required><br>
                    Please confirm your password.<br>
                    <input type='password' name='confirm_password' required>
                    <button type='submit' name='reset'>Reset</button>
                </form> 

                <?php
            } else {
                echo "Security answer is incorrect. Meow!";
            }
        } else if (isset($_POST['reset'])) {
            if ($_POST['password'] != $_POST['confirm_password']) {
                echo "Passwords do not match. Please try it again.";
            } else {


                $uppercase = preg_match('@[A-Z]@', $_POST['password']);
                $lowercase = preg_match('@[a-z]@', $_POST['password']);
                $number = preg_match('@[0-9]@', $_POST['password']);
                $specialChars = preg_match('@[^\w]@', $_POST['password']);

                if (!$uppercase || !$lowercase || !$number || !$specialChars || strlen($_POST['password']) < 8) {
                    echo 'Password should be at least 8 characters in length and should include at least one upper case letter, one number, and one special character.';
                } else {
                    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
                    $req2 = $db->prepare("UPDATE member SET passwords =? where memberID=? ");
                    $req2->execute([$password,$_SESSION['id']]);
                            $count = $req2->rowCount();
                            if($count>0){
                                echo "Success!";                               
                            }else{
                                echo "Something went wrong... Maybe try again? :(";
                            }
                }
            }
        }else{
                    ?>


                    <form method = "POST" >

                        Insert your username or email:
                        <input type='text' name='keyword' required>

                        <input type="hidden" name="recover" value="true">
                        <button type='submit'>Submit</button>
                    </form>
            <?php
        }
        ?>

    </body>
</html>
