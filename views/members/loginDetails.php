
<div class="tab-pane fade <?php echo (isset($_GET['target']) && $_GET['target'] == 'login') ? "active show" : ""; ?>" id="loginDetails" role="tabpanel" aria-labelledby="loginDetails-tab">
    <div class="tab-container">
        <div class="row justify-content-center">
            <i class="far fa-envelope fa-3x icon"></i><h1>Email</h1>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 vpad text-center"><?php echo $_SESSION['user']->getEmail() ?></div>
            <div class="col-md-4 text-center"><button class="btn1 fourth" onclick="showHide('email')">Change</button></div>
        </div>



        <?php if (empty($_POST['changeemail']) && !isset($_SESSION['verification'])) { ?>
            <div class="row justify-content-center" id="email">
                <form action="?controller=member&action=changeEmail&target=login" method="POST">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type='text' name='username' value="<?php echo $_SESSION['user']->getUserName() ?>" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type='password' name='password' class="form-control" required> 
                        </div>
                    </div>
                    <input type="hidden" name="confirmLogin" value="true">        
                    <input type="hidden" name="emailVerify" value="true">        
                    <div class="smalltext">Please validate your session</div>   
                    <div class="form-row justify-content-end">
                        <button class="btn1 fourth" type='submit'>Submit</button>
                    </div>
                </form>
            </div>
        <?php } else if (isset($_SESSION['verification']) && isset($_POST['emailVerify'])) { ?>
            <div class="row justify-content-center">
                <form action="?controller=member&action=changeEmail&target=login" method="POST">
                    <input type="hidden" name="changeEmail" value="true">
                    <input class="form-control" type="email" name="newemail" value="<?php echo $_SESSION['user']->getEmail(); ?> ">
                    <div class="form-row justify-content-end">
                        <button type="submit" class="btn1 fourth">Update</button>
                    </div>
                </form>
            </div>
        <?php } ?>


        <div class="spacer"></div>
        <hr>
        <div class="spacer"></div>


        <div class="row justify-content-center">
            <i class="fas fa-user-secret fa-3x icon"></i><h1>Password:</h1>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 vpad text-center"> ( -- It's a secret! -- ) </div>
            <div class="col-md-4 text-center"><button class="btn1 fourth" onclick="showHide('passwords')">Change</button></div>
        </div>

        <div class="spacer"></div>


        
            <?php if (empty($_POST['changepassword']) && !isset($_SESSION['verification'])) { ?>
        <div class="row justify-content-center" id="passwords">
                <form action="?controller=member&action=changePassword&target=login" method="POST"  >
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username:</label>
                            <input type='text' name='username' value="<?php echo $_SESSION['user']->getUserName() ?>" class="form-control" disabled>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password:</label>
                            <input type='password' name='password' class="form-control" required> 
                        </div>
                    </div>
                    <input type="hidden" name="confirmLogin" value="true">        
                    <input type="hidden" name="passwordVerify" value="true">        
                    <div class="smalltext">Please validate your session</div>   
                    <div class="form-row justify-content-end">
                        <button class="btn1 fourth" type='submit'>Submit</button>
                    </div>
                </form>
            </div>
            <?php } else if (isset($_SESSION['verification']) && isset($_POST['passwordVerify'])) { ?>
        <div class="row justify-content-center">
                <form action="?controller=member&action=changePassword&target=login" method="POST" class="col-md-7">
                    <input type="hidden" name="changePassword" value="true">
                    New Password:  <input class="form-control" type="password" name="newpassword">
                    Confirm Password:  <input class="form-control" type="password" name="confirmpassword">
                    <div class="form-row justify-content-end">
                        <button type="submit" class="btn1 fourth">Update</button>
                    </div>
                </form>
        </div>
            <?php } ?>
        


    </div>
</div>

