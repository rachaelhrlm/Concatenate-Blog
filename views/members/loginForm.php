<?php $security= Member::security(); ?>
<div class='overall' id='overall'>
    <div class="loginFormContainer" id="container">
        <div class="form-container sign-up-container">
            <form method='POST' action='?controller=member&action=register'>
                <h1>Sign up</h1>
                <input type='hidden' name='register' value="true">
                <input type="text" name='userName' placeholder="Username" />
                <input  type="email" name='email' placeholder="Email" />
                <input type="password" name='password' placeholder="Password" />
                <input type="password" name='confirmPassword' placeholder="Confirm Password" />     
                <select class="custom-select" name="securityID"> 
                    <?php foreach ($security as $securityquestion) { ?> 
                        <option value="
                                <?php echo $securityquestion['securityID'] ?>">

                            <?php echo $securityquestion['securityquestion'] ?></option>                             
                    <?php } ?>                     
                </select>
                <input type="text" name='securityAnswer' placeholder="Answer" />
                <button type="submit">Sign Up</button>
            </form>
        </div>
        <div class="form-group form-container sign-in-container ">
            <form action="#">
                <h1>Sign in</h1>
                <input type="email" placeholder="Email" />
                <input type="password" placeholder="Password" />
                <a href="#">Forgot your password?</a>
                <button class="botton">Sign In</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1 class="overlayheader">Meow?</h1>
                    <p>Already have an account?</p>
                    <button class="ghost" id="signIn">Maybe.</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1 class="overlayheader">Meow!</h1>
                    <p>Hey! Do you like cats? </p>
                    <button class="ghost" id="signUp">Yes!</button>
                </div>
            </div>
        </div>
    </div>
    <div class ="closeLogin" onclick="hide('overall')"><i class="fas fa-times-circle fa-3x icon"></i></div>
</div>

        


<script>
    function hide(div){
        document.getElementById(div).style.display = 'none';
    }

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