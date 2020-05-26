<!DOCTYPE html>
<html>
<head>
 <title>Sub</title>
 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.6/sweetalert2.min.js"></script>
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.6.6/sweetalert2.css">
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
<script>
 $(document).ready(function(){
 swal({
 title: 'Subscribe here!',
 input: 'email',
 showCancelButton: true,
 confirmButtonText: 'Submit',
 showLoaderOnConfirm: true,
 preConfirm: function (email) {
 return new Promise(function (resolve, reject) {
 setTimeout(function() {
 $.ajax({
 type: 'post',
 url: 'check_email.php',
 data: {email:email},
 success: function(result){
 if(result>0){
 reject('This email is already taken.')
 }
 else{
 $.ajax({
 type: 'post',
 url: 'subscribe.php',
 data: {email:email},
 success: function(data){
 resolve()
 }
 });
 
 }
 }
 });
 
 }, 1000)
 })
 },
 allowOutsideClick: true
 }).then(function (email) {
 swal({
 type: 'success',
 title: 'Success!',
 html: 'Submitted email: ' + email
 })
 })
 });
</script>
</html>
