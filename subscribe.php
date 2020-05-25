<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sub</title>
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
        <h3>Subscribe here:</h3>

        <form action = "" method = "POST">

            Email:
            <input type = "email" name = "email" required>
            
            Confirm Email:
            <input type = "email" name = "confirm_email" required>



            <button type = 'submit' name = 'subscribe'>Subscribe</button>
    </body>
</html>
