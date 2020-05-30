<?php if ($_SESSION['user']->getAccessLevelID() < 3) { ?>
    <div class="tab-pane fade <?php echo!isset($_GET['target']) ? "show active" : ""; ?> " id="actions" role="tabpanel" aria-labelledby="actions-tab">
        <div class="tab-container">
            <div class="row justify-content-center">
                <i class="far fa-list-alt fa-3x icon"></i><h1>Post Actions </h1>
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
                    </select><div class="form-row justify-content-end"><button type="submit" class="btn fourth">Edit</button></div>
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
                                <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                <?php
                            }
                        }
                        ?>
                    </select><div class="form-row justify-content-end"><button type="submit" class="btn fourth">Delete</button></div>
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
                    </select><div class="form-row justify-content-end"><button type="submit" class="btn fourth">Restore</button></div>
                </form>
            </div>






            <!--Featured Post Section-->
            <?php if ($_SESSION['user']->getAccessLevelID() == 1) { ?>

                <div class="spacer"></div>
                <hr>
                <div class="spacer"></div>




                <div class="row justify-content-center">
                    <i class="far fa-newspaper fa-3x icon"></i><h1>Featured Posts </h1>
                </div>

                <!--First Featured Post-->
                <div class="row justify-content-center">
                    <form action="" method="GET" class="form-inline">
                        <input type="hidden" name="controller" value="post">
                        <input type="hidden" name="action" value="feature">
                        <input type="hidden" name="post" value="1">
                        <select name="id" placeholder="post ID" class="custom-select"> 
                            <?php
                            foreach ($posts as $post) {
                                if ($post['visibility'] == 1) {
                                    if ($post['postID'] == $featuredPost1['postID']) {
                                        ?>

                                        <option value="<?php echo $post['postID'] ?>" selected><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                    <?php } else {
                                        ?>
                                        <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                        <?php
                                    }
                                }
                            }
                            ?>
                        </select><button type="submit" class="btn fourth">Set</button>
                    </form>
                </div>
                <!--Second Featured Post-->
                <div class="row justify-content-center">
                    <form action="" method="GET" class="form-inline">
                        <input type="hidden" name="controller" value="post">
                        <input type="hidden" name="action" value="feature">
                        <input type="hidden" name="post" value="2">
                        <select name="id" placeholder="post ID" class="custom-select"> 
                            <?php
                            foreach ($posts as $post) {
                                if ($post['visibility'] == 1) {
                                    if ($post['postID'] == $featuredPost2['postID']) {
                                        ?>

                                        <option value="<?php echo $post['postID'] ?>" selected><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                    <?php } else {
                                        ?>
                                        <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                        <?php
                                    }
                                }
                            }
                            ?>
                        </select><button type="submit" class="btn fourth">Set</button>
                    </form>
                </div>
                <!--Third Featured Post-->
                <div class="row justify-content-center">
                    <form action="" method="GET" class="form-inline">
                        <input type="hidden" name="controller" value="post">
                        <input type="hidden" name="action" value="feature">
                        <input type="hidden" name="post" value="3">
                        <select name="id" placeholder="post ID" class="custom-select"> 
                            <?php
                            foreach ($posts as $post) {
                                if ($post['visibility'] == 1) {
                                    if ($post['postID'] == $featuredPost3['postID']) {
                                        ?>

                                        <option value="<?php echo $post['postID'] ?>" selected><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                    <?php } else {
                                        ?>
                                        <option value="<?php echo $post['postID'] ?>"><?php echo $post['postID'] . "." . '&emsp;' . $post['title'] ?></option>
                                        <?php
                                    }
                                }
                            }
                            ?>
                        </select><button type="submit" class="btn fourth">Set</button>
                    </form>
                </div>


                <div class="spacer"></div>
                <hr>
                <div class="spacer"></div>



                <div class="row justify-content-center">
                   <i class="fas fa-user-plus fa-3x icon"></i> <h1>Promote Member </h1>
                </div>
                <div class="row justify-content-center">
                    <form action="?controller=member&action=promoteMember" method="POST" class="form-inline">
                        <select name="id" placeholder="member ID" class="custom-select"> 
                            <?php
                            foreach ($members as $member) {
                                if ($member['accessLevelID'] == 3) {
                                    ?>
                                    <option value = "<?php echo $member['memberID'] ?>"><?php echo $member['memberID'] . "." . '&emsp;' . $member['userName']
                                    ?></option>
                                    <?php
                                }
                            }
                            ?></select><button type="submit" class="btn fourth">Set</button>

                    </form>
                </div>

                <div class="spacer"></div>
                <hr>
                <div class="spacer"></div>

                <div class="row justify-content-center">
                   <i class="fas fa-user-minus fa-3x icon"></i> <h1>Demote Blogger </h1>
                </div>
                <div class="row justify-content-center">
                    <form action="?controller=member&action=demoteMember" method="POST" class="form-inline">
                        <select name="id" placeholder="member ID" class="custom-select"> 
                            <?php
                            foreach ($members as $member) {
                                if ($member['accessLevelID'] == 2) {
                                    ?>
                                    <option value = "<?php echo $member['memberID'] ?>"><?php echo $member['memberID'] . "." . '&emsp;' . $member['userName']
                                    ?></option>
                                    <?php
                                }
                            }
                            ?></select><button type="submit" class="btn fourth">Set</button>

                    </form>
                </div>


                <div class="spacer"></div>
                <hr>
                <div class="spacer"></div>


                <div class="row justify-content-center">
                    <i class="fas fa-user-times fa-3x icon"></i><h1>Ban Member </h1>
                </div>
                <div class="row justify-content-center">
                    <form action="?controller=member&action=banMember" method="POST" class="form-inline">
                        <select name="id" placeholder="member ID" class="custom-select"> 
                            <?php
                            foreach ($members as $member) {
                                if ($member['accessLevelID'] > 1 && $member['accessLevelID'] != 4) {
                                    ?>
                                    <option value = "<?php echo $member['memberID'] ?>"><?php echo $member['memberID'] . "." . '&emsp;' . $member['userName']
                                    ?></option>
                                    <?php
                                }
                            }
                            ?></select><button type="submit" class="btn fourth">Set</button>

                    </form>
                </div>



                <div class="spacer"></div>
                <hr>
                <div class="spacer"></div>


                <div class="row justify-content-center">
                    <i class="fas fa-user-check fa-3x icon"></i><h1>Unban Member </h1>
                </div>
                <div class="row justify-content-center">
                    <form action="?controller=member&action=unbanMember" method="POST" class="form-inline">
                        <select name="id" placeholder="member ID" class="custom-select"> 
                            <?php
                            foreach ($members as $member) {
                                if ($member['accessLevelID'] == 4) {
                                    ?>
                                    <option value = "<?php echo $member['memberID'] ?>"><?php echo $member['memberID'] . "." . '&emsp;' . $member['userName']
                                    ?></option>
                                    <?php
                                }
                            }
                            ?></select><button type="submit" class="btn fourth">Set</button>

                    </form>
                </div>






            <?php } ?>
        </div>
    </div>

<?php } ?>