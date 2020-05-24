<?php
if (empty($_SESSION['user'])) {
    ob_start();
    header("Location:?controller=pages&action=home");
    ob_end_flush();
    exit();
}
?>
<body onload="clearPost()">
    <section class="container" >
        <div class ="row justify-content-center">
            <div class="col-md-2">
                <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <a class="nav-link" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="false">Login Details</a>
                    <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">Profile</a>
                    <a class="nav-link" id="actions-tab" data-toggle="pill" href="#actions" role="tab" aria-controls="actions" aria-selected="false">Actions</a>
                    <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">Favourite Posts</a>
                </div>
            </div>


            <div class="col-md-7">
                <div class="tab-content" id="v-pills-tabContent">


                    <!--Login Details Container-->
                    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
                        <div class="tab-container">




                        </div>
                    </div>






                    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
                        Profile
                    </div>


                    <!--Actions Container-->
                    <div class="tab-pane fade" id="actions" role="tabpanel" aria-labelledby="actions-tab">
                        <div class="tab-container">
                            <div class="row justify-content-center">
                                <h2>Post Actions: </h2>
                            </div>
                            <div class="row justify-content-center">
                                <a onclick="editPost()"><i class="fas fa-pen-square fa-3x icon"  data-toggle="tooltip" data-placement="top" title="Edit Post"></i></a>
                                <a href="?controller=post&action=create"><i class="fas fa-plus-square fa-3x icon"  data-toggle="tooltip" data-placement="top" title="New Post"></i></a>
                                <a onclick="deletePost()"><i class="fas fa-minus-square fa-3x icon"  data-toggle="tooltip" data-placement="top" title="Delete Post"></i></a>
                                <a onclick="restorePost()"><i class="fas fa-check-square fa-3x icon"  data-toggle="tooltip" data-placement="top" title="Restore Post"></i></a>
                            </div>

                            <div class="row justify-content-center">
                                <!--Form for Edit-->
                                <form action="" method="GET" class="form-inline" id="edit">
                                    <input type="hidden" name="controller" value="post">
                                    <input type="hidden" name="action" value="edit">
                                    <select name="id" placeholder="post ID" class="custom-select"> 
                                        <?php
                                        foreach ($posts as $post) {
                                            if ($post['visibility'] == 1) {
                                                ?>
                                                <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                                <?php
                                            }
                                        }
                                        ?>
                                    </select><button type="submit" class="btn btn-primary">Edit</button>
                                </form>


                                <!--Form for Delete-->

                                <form action="" method="GET" class="form-inline" id="delete">
                                    <input type="hidden" name="controller" value="post">
                                    <input type="hidden" name="action" value="delete">
                                    <select name="id" placeholder="post ID" class="custom-select"> 
                                        <?php
                                        foreach ($posts as $post) {
                                            if ($post['visibility'] == 1) {
                                                ?>
                                                <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title']?></option>
                                                <?php
                                            }
                                        }
                                        ?>
                                    </select><button type="submit" class="btn btn-primary">Delete</button>
                                </form>


                                <!--Form for Restore-->
                                <form action="" method="GET" class="form-inline" id="restore">
                                    <input type="hidden" name="controller" value="post">
                                    <input type="hidden" name="action" value="restore">
                                    <select name="id" placeholder="post ID" class="custom-select"> 
                                        <?php
                                        foreach ($posts as $post) {
                                            if ($post['visibility'] == 0) {
                                                ?>
                                                <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                                <?php
                                            }
                                        }
                                        ?>
                                    </select><button type="submit" class="btn btn-primary">Restore</button>
                                </form>


                            </div>

                            <hr>


                        </div>
                    </div>






                    <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
                        Settings
                    </div>
                </div>
            </div>
        </div>   



    </section>
    <script>
        function editPost() {
            document.querySelector("#delete").style.display = 'none';
            document.querySelector("#restore").style.display = 'none';
            document.querySelector("#edit").style.display = 'inline';
        }
        function deletePost() {
            document.querySelector("#delete").style.display = 'inline';
            document.querySelector("#restore").style.display = 'none';
            document.querySelector("#edit").style.display = 'none';
        }
        function restorePost() {
            document.querySelector("#delete").style.display = 'none';
            document.querySelector("#restore").style.display = 'inline';
            document.querySelector("#edit").style.display = 'none';
        }
        function clearPost() {
            document.querySelector("#delete").style.display = 'none';
            document.querySelector("#restore").style.display = 'none';
            document.querySelector("#edit").style.display = 'none';
        }
    </script>