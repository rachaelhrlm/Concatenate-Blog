
<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
    <div class="tab-container">


        <!--Update Name Form-->
        <div class="row justify-content-center">
            <h2>Update Name: </h2>
        </div>
        <div class="row justify-content-center">
            <form action="" method="GET" class="col-md-7">
                <input type="hidden" name="controller" value="member">
                <input type="hidden" name="action" value="updateName">
                <input class="form-control" type="text" name="name" value="<?php echo (isset($user['name'])) ? $user['name'] : $_SESSION['user']->getUserName(); ?> ">
                <div class="form-row justify-content-end">
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </form>
        </div>

        <div class="spacer"></div>
        <hr>
        <div class="spacer"></div>


        <!--Update About Me Form-->
        <div class="row justify-content-center">
            <h2>Update About Me: </h2>
        </div>
        <div class="row justify-content-center">
            <form action="" method="GET" id="aboutMe" class="col-md-7">
                <input type="hidden" name="controller" value="member">
                <input type="hidden" name="action" value="updateAbout">
                <textarea form="aboutMe" class="form-control aboutArea" type="text" name="about"><?php echo (isset($user['about'])) ? $user['about'] : "About me"; ?> </textarea>
                <div class="form-row justify-content-end">
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </form>
        </div>



        <div class="spacer"></div>
        <hr>
        <div class="spacer"></div>


        <!--Update Profile Picture Form-->
        <div class="row justify-content-center">
            <h2>Update Profile Picture: </h2>
        </div>
        <div class="row justify-content-center">
            <?php
            if (file_exists("views/images/members/{$_SESSION['user']->getMemberID()}.jpeg")) {
                $propic = "views/images/members/{$_SESSION['user']->getMemberID()}.jpeg";
            } else {
                $propic = "views/images/standard/noprofileimage.png";
            }
            ?>

            <img src="<?php echo $propic ?>" class="accountimg">
        </div>


        <div class="row justify-content-center">
            <form action="?controller=member&action=updateProfilePic" method="POST" id="about" class=" col-md-7" enctype="multipart/form-data">
                <input type="hidden" name="MAX_FILE_SIZE" value="10000000" />
                <input type="hidden" name="controller" value="member">
                <input type="hidden" name="action" value="updateProfilePic">
                <input type="file" name="myUploader" class="custom-file-input" id="image">
                <label class="custom-file-label cfl" for="image">Choose file</label>
                <div class="form-row justify-content-end">
                    <button type="submit" class="btn btn-success">Update</button>
                </div>
            </form>
        </div>



    </div>
</div>
