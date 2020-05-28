
        <div class="loginContainer" id="loginContainer">
            <div class="form-container sign-up-container">
                <form>
                    <h1>Sign up</h1>
                    <input type="text" placeholder="Name" />
                    <input  type="email" placeholder="Email" />
                    <input type="password" placeholder="Password" />
                    <input type="password" placeholder="ConfirmPassword" />     
                    <select name="securityID">
                        <option selected>Choose a security question</option>
                        <option value="1">Hey</option>                             
                        <option value="2">Oh?</option>    
                    </select>
                    <input type="text" placeholder="Answer" />
<!--                                <input type = "checkbox" name = "confirm" value = "Agree">I confirmed that I like cats.-->

                    <button>Sign Up</button>
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
 
