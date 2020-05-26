<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
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


        if (isset($_POST['subscribe'])) {
            
            $_POST['email'] = $_POST['confirm_email'];





            $email = $_POST ['email'];
            


            $stmt = $pdo->prepare("INSERT INTO subscriber (email) VALUES (:email)");

            $stmt->bindParam(":email", $email);
            

            $stmt->execute();
            $count = $stmt->rowCount();
            if ($count > 0) {

                echo "Subscription Successful";
            } else {
                echo "Unsuccesful. Sad cat :(";
            }
        }
        ?>
    </body>
</html>
