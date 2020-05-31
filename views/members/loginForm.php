<?php $security = Member::security(); ?>
<div class="container-fluid" id="loginForm">
    <div class="row justify-content-center">
        <i class="fas fa-users fa-3x icon"></i><h1>Welcome</h1>
    </div>
    <div class="row justify-content-center">
        <div class='overall col-md-10' id='overall'>
            <div class="loginFormContainer" id="container">
                <div class="form-container sign-up-container">
                    <form method='POST' action='?controller=member&action=register'>
                        <div class="row justify-content-center">
                            <i class="far fa-arrow-alt-circle-up fa-3x icon"></i><h1>Sign Up</h1>
                        </div>
                        <input type='hidden' name='register' value="true">
                        <input type="text" name='userName' placeholder="Username" required />
                        <input  type="email" name='email' placeholder="Email" required />
                        <input type="password" name='password' placeholder="Password" required  />
                        <input type="password" name='confirmPassword' placeholder="Confirm Password" required />     
                        <select class="custom-select" name="securityID"> 
                            <?php foreach ($security as $securityquestion) { ?> 
                                <option value="
                                        <?php echo $securityquestion['securityID'] ?>">

                                    <?php echo $securityquestion['securityquestion'] ?></option>                             
                                <?php } ?>                     
                        </select>
                        <input type="text" name='securityAnswer' placeholder="Answer" required/>
                        <button class="btn fourth" type="submit">Sign Up</button>
                    </form>
                </div>
                <div class="form-group form-container sign-in-container ">
                    <form action="?controller=member&action=login" method="POST">
                        <div class="row justify-content-center">
                            <i class="far fa-arrow-alt-circle-right fa-3x icon"></i><h1>Sign In</h1>
                        </div>
                        <input type='hidden' name='login' value="true">
                        <input type="text" name="userName" placeholder="Username" required/>
                        <input type="password" name="password" placeholder="Password" required />
                        <a href="#">Forgot your password?</a>
                        <button class="btn fourth" type="submit">Sign In</button>
                    </form>
                </div>
                <div class="overlay-container">
                    <div class="overlay">
                        <div class="overlay-panel overlay-left">
                            <h2 class="overlayheader">Meow?</h2>
                            <p>Already have an account?</p>
                            <button class="btn third" id="signIn">Maybe.</button>
                        </div>
                        <div class="overlay-panel overlay-right">
                            <h2 class="overlayheader">Meow!</h2>
                            <p>Hey! Do you like cats? </p>
                            <button class="btn third" id="signUp">Yes!</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<script>

    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
    });





</script>