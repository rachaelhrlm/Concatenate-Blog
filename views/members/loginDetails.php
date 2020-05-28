
<div class="tab-pane fade <?php echo (isset($_GET['target']) && $_GET['target'] == 'login') ? "active show" : ""; ?>" id="loginDetails" role="tabpanel" aria-labelledby="loginDetails-tab">
    <div class="tab-container">
        <div class="row justify-content-center">
            <h2>Email:</h2>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 vpad text-center"><?php echo $_SESSION['user']->getEmail() ?></div>
            <div class="col-md-4 text-center"><button class="btn btn-success" onclick="showHide('email')">Change Email</button></div>
        </div>

        <div class="spacer"></div>

        <div class="row justify-content-center">
            <?php if (empty($_POST['changeemail']) && !isset($_SESSION['verification'])) { ?>
                <form action="?controller=member&action=changeEmail&target=login" method="POST" class="col-md-7" id="email">
                    Username: <input type='text' name='username' value="<?php echo $_SESSION['user']->getUserName() ?>" class="form-control" disabled="">                 
                    Password: <input type='password' name='password' class="form-control" required>                 
                    <input type="hidden" name="confirmLogin" value="true">        
                    <div class="smalltext">Please validate your session</div>        
                    <button class="btn btn-success" type='submit'>Submit</button>
                </form>
            <?php } else if (isset($_SESSION['verification'])) { ?>
                <form action="?controller=member&action=changeEmail&target=login" method="POST" class="col-md-7">
                    <input type="hidden" name="changeEmail" value="true">
                    <input class="form-control" type="email" name="newemail" value="<?php echo $_SESSION['user']->getEmail(); ?> ">
                    <div class="form-row justify-content-end">
                        <button type="submit" class="btn btn-success">Update</button>
                    </div>
                </form>
            <?php } ?>
        </div>

        <div class="spacer"></div>
        <hr>
        <div class="spacer"></div>


        <div class="row justify-content-center">
            <h2>Password:</h2>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-4 vpad text-center"> ( -- It's a secret! -- ) </div>
            <div class="col-md-4 text-center"><button class="btn btn-success" onclick="showHide('passwords')">Change Password</button></div>
        </div>

        <div class="spacer"></div>


        <div class="row justify-content-center">
            <?php if (empty($_POST['changepassword']) && !isset($_SESSION['verification'])) { ?>
                <form action="?controller=member&action=changePassword&target=login" method="POST" class="col-md-7" id="passwords">
                    Username: <input type='text' name='username' value="<?php echo $_SESSION['user']->getUserName() ?>" class="form-control" disabled="">                 
                    Password: <input type='password' name='password' class="form-control" required>                 
                    <input type="hidden" name="confirmLogin" value="true">        
                    <input type="hidden" name="changePassword" value="true">
                    <div class="smalltext">Please validate your session</div>        
                    <button class="btn btn-success" type='submit'>Submit</button>
                </form>
            <?php } else if (isset($_SESSION['verification']) && isset($_POST['changePassword'])) { ?>
                <form action="?controller=member&action=changePassword&target=login" method="POST" class="col-md-7">
                    <input type="hidden" name="changePassword" value="true">
                    New Password:  <input class="form-control" type="password" name="newpassword">
                    Confirm Password:  <input class="form-control" type="password" name="confirmpassword">
                    <div class="form-row justify-content-end">
                        <button type="submit" class="btn btn-success">Update</button>
                    </div>
                </form>
            <?php } ?>
        </div>


    </div>
</div>

