<?php
if (empty($_SESSION['user'])) {
    header("Location:?controller=pages&action=home");
    exit();
}
?>



<section class="container">
    <div class ="row justify-content-center">
        <div class="col-md-2">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">Login Details</a>
                <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">Profile</a>
                <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">Favourites</a>
                <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">Actions</a>
            </div>
        </div>


        <div class="col-md-7">
            <div class="tab-content" id="v-pills-tabContent">
                <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                    <div class="tab-container">
                        <div class="row">
                            <div class="row"><h5>Email:</h5></div>
                            <div class="row">
                                <div class="col-md-2">
                                    <?php echo $_SESSION['user']->getEmail(); ?>
                                </div>
                                <div class="col-md-4">
                                    <?php if (empty($_GET['account']) || $_GET['account'] !== "email") { ?>
                                        <button class="btn btn-primary" onclick='location.href = "?controller=member&action=account&account=email"'>Change Email</button>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-between ">
                            <?php if (!empty($_GET['account']) && $_GET['account'] === "email") { ?>
                                <div class="row accountupdate"><form action="" method="POST" class="col-md-12">
                                        <div class="form-group">
                                            <div class="row">
                                                <label for="email"><h6>New Email:</h6></label>
                                            </div>
                                            <div class="row">
                                                <input  class="form-control col-md-9" id="email" type="email" name="email" placeholder="New Email" autofocus required/>
                                                <input type="submit" class="btn btn-primary col-md-2 submitbutton" value="Update" />
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            <?php } ?>
                        </div>



                    </div>
                </div>
                <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                    Profile
                </div>
                <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
                    Messages
                </div>
                <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                    Settings
                </div>
            </div>
        </div>
    </div>   



</section>