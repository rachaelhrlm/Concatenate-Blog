<?php ?>


<h3>Log In Here</h3>

<form action = "" method = "POST">
    Username:
    <input type = "text" name = "login_username"required>
    Password:
    <input type = "password" name = "login_password"required>
    <button type = 'submit' name = 'login'>Log In</button>
</form>

<h3>Register Today!</h3>
<form action = "" method = "POST" name="register">
    Username:
    <input type = "text" name = "register_username"required>
    Password:
    <input type = "password" name = "register_password"required>
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
    Security Answer:
    <input type='text' name=' securityanswer' required>
    Email:
    <input type = "email" name = "register_email" required>

    <button type = 'submit' name = 'register'>Register</button>

    <input type = "checkbox" name = "confirm" value = "Agree">I confirmed that I like cats.


</form>



<!--<section class="container">
<?php echo $result; ?>
</section>-->
