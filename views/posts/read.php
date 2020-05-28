<!--If image file with name of ID number exists, store it into the $img variable, else use a default image-->
<?php
if (file_exists("views/images/{$_GET['id']}.jpeg")) {
    $img = "views/images/{$_GET['id']}.jpeg";
} else {
    $img = "views/images/standard/_noproductimage.png";
}

if (file_exists("views/images/members/{$post->getMemberID()}.jpeg")) {
    $pic = "views/images/members/{$post->getMemberID()}.jpeg";
} else {
    $pic = "views/images/standard/noprofileimage.png";
}
?>


<!--if user is logged in and accessLevelID is admin or member logged in is the post author-->
<?php
if (isset($_SESSION['user'])) {
    ?>
    <div class="spacer"></div>
    <div class="container">
        <div class="row justify-content-center">
            <div class='col-md-1 text-left'>
                <?php 
                $faved= null;
                foreach($favs as $fav) {
                    if($_GET['id'] === $fav['postID']) {
                        $faved= true;
                        break;
                    }
                } 
                if (isset($faved)) { ?>
                <a href="?controller=member&action=unfav&id=<?php echo $post->getPostID(); ?>"><i class="fas fa-heart fa-3x icon"></i></a>
                
                <?php } else { ?>
                <a href="?controller=member&action=fav&id=<?php echo $post->getPostID(); ?>"><i class="far fa-heart fa-3x icon"></i></a>
                <?php } ?>
            </div>
            <div class="col-md-8 text-right">
            <?php 
        if(($_SESSION['user']->getAccessLevelID() === '1' ) || ($post->getMemberID() === $_SESSION['user']->getMemberID())) {?>

            
                <a href="?controller=post&action=edit&id=<?php echo $post->getPostID(); ?>"><i class="fas fa-pen-square fa-3x icon" data-toggle="tooltip" data-placement="top" title="Edit Post"></i></a>
                <a href="?controller=post&action=create"><i class="fas fa-plus-square fa-3x icon" data-toggle="tooltip" data-placement="top" title="New Post"></i></a>
                <a href="?controller=post&action=delete&id=<?php echo $post->getPostID(); ?>"><i class="fas fa-minus-square fa-3x icon" data-toggle="tooltip" data-placement="top" title="Delete Post"></i></a>
                
            
        <?php } ?>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class='col-md-9'><hr></div>
            </div>
    </div>
<?php } ?>






<!--Blog Content-->
<section class="container">    
    <div class ="row justify-content-center">
        <div class="col-md-9 text-center"> 
            <h1><?php echo ucwords(Post::censor($post->getTitle())) ?></h1>
        </div>
    </div>
    <div class="row justify-content-center">
        <small class="text-muted"><?php echo $post->getAuthor() . '&emsp; &emsp;' . $post->getDatePosted() . '&emsp; &emsp;' . $post->getCategory() ?></small>
    </div>


    <!--Add to Any Share Buttons-->
    <div class="row justify-content-center">
        <div class="a2a_kit a2a_kit_size_32 a2a_default_style sharebtn">
            <a class="a2a_button_email"></a>
            <a class="a2a_button_print"></a>
            <a class="a2a_button_twitter"></a>
            <a class="a2a_button_linkedin"></a>
            <a class="a2a_button_facebook"></a>
            <a class="a2a_button_tumblr"></a>
        </div>
    </div>



    <div class="row justify-content-center">
        <div class="col-md-9 text-center">
            <img src="<?php echo $img ?>?<?= Date('U') ?>" class="blogimg">
        </div>
    </div>


    <div class="row justify-content-center">
        <div class="col-md-9 post">
            <h2 class="excerpt"><?php echo ucfirst(Post::censor($post->getExcerpt())) ?></h2>
            <div class="spacer"></div>
            <?php
            $content = Post::censor(htmlspecialchars_decode($post->getContent()));

            echo $content
            ?>
        </div>
    </div>
</section>






<!--Author Snippet-->
<section class="content">
    <div class="row justify-content-center">
        <div class="col-md-9 authorSnippet">
            <div class="row justify-content-around">
                <div class="col-md-3">
                    <img src="<?php echo $pic ?>" class="profilePic">
                    <p><?php echo $post->getAuthor() ?></p>
                </div>
                <div class="col-md-6 text-left">
                    <h2>About the author:</h2>
                    <p><?php echo $post->getAbout() ?></p>

                    <?php
                    foreach ($socials as $social) {
                        if ($social['socialID'] === '1') {
                            ?>
                            <a href="<?php echo $social['url'] ?>"> <i class="fab fa-twitter fa-2x icon"></i></a>
                            <?php
                        }
                        if ($social['socialID'] === '2') {
                            ?>
                            <a href="<?php echo $social['url'] ?>"> <i class="fab fa-facebook fa-2x icon"></i></a>
                            <?php
                        }
                        if ($social['socialID'] === '3') {
                            ?>
                            <a href="<?php echo $social['url'] ?>"> <i class="fab fa-github fa-2x icon"></i>  </a> 
                            <?php
                        }
                        if ($social['socialID'] === '4') {
                            ?>
                            <a href="<?php echo $social['url'] ?>"> <i class="fab fa-instagram fa-2x icon"></i> </a>
                            <?php
                        }
                        if ($social['socialID'] === '5') {
                            ?>
                            <a href="<?php echo $social['url'] ?>"> <i class="fab fa-linkedin fa-2x icon"></i></a>
                            <?php
                        }
                    }
                    ?>
                </div>
            </div>
        </div>
</section>





<!--Comment Section-->
<section class="container">
    <div class="row justify-content-center">
        <div class="col-md-7">
            <div class="row">
                <h2>Comments:</h2>
            </div>

            <?php
            if (!empty($comments)) {
                foreach ($comments as $comment) {
                    if (file_exists("views/images/members/{$comment['memberID']}.jpeg")) {
                        $propic = "views/images/members/{$comment['memberID']}.jpeg";
                    } else {
                        $propic = "views/images/standard/noprofileimage.png";
                    }
                    if (isset($comment['name'])) {
                        $name = $comment['name'];
                    } else {
                        $name = $comment['username'];
                    }
                    ?>
                    <div class="row comment">
                        <div class="col-md-1 commentPic">
                            <img src='<?php echo $propic ?>' class='propic'> 
                        </div>
                        <div class="col-md-4 commentMessage">
                            <div class="smalltext"><?php echo $name . "&emsp;" . $comment['dateCommented'] ?></div>
                            <p><?php echo Post::censor($comment['message']) ?></p>
                        </div></div><?php
                }
            } else {
                ?>
                <div class="row comment">
                    <p>No comments yet.</p>
                </div>
            <?php }
            ?>
        </div>
    </div>
</section>


<!--Write a Comment Section-->
<?php
if (isset($_SESSION['user'])) {
    if (!empty($user['name'])) {
        $name = $user['name'];
    } else {
        $name = $_SESSION['user']->getUserName();
    }
    ?>
    <section class="container">
        <div class="row justify-content-center">
            <div class="col-md-9">
                <form action="" method="GET"  id="form-comment">
                    <h2>New Comment:</h2>
                    <input type="hidden" name="controller" value="post">
                    <input type="hidden" name="action" value="createComment">
                    <input type='hidden' name='id' value='<?php echo $post->getPostID() ?>'>
                    <input type='hidden' name='member' value='<?php echo $_SESSION['user']->getMemberID() ?>'>
                    <div class='form-row'>
                        <input type="author" name="author" class="form-control" id="author" value="<?php echo $name ?>" disabled>
                    </div>
                    <div class='form-row'>
                        <textarea name='message' class='form-control commentAreas' form="form-comment" placeholder="Comment"></textarea>
                    </div>
                    <div class='form-row justify-content-end'>
                        <input type="submit" value='Submit Comment' class='btn btn-primary'>
                    </div>
            
            </form>
                </div>
        </div>
    </div>
    </section>
<?php } else { ?>
    <section class="container">
        <div class="row justify-content-center">
            <div class="col-md-9 newComment">
                <h2>New Comment:</h2>
                Please log in to comment.
                <div class='form-row justify-content-end'>
                    <button class="btn btn-primary" onclick="loginForm('overall')">Login </button>
                </div>
            </div>
        </div>
    </section>
<?php } ?>




<!--Previous and Next Post-->
<section class="container">
    <div class="row justify-content-around">
        <div class="col-md-4">
            <?php
            for ($i = 1; $i <= 3; $i++) {
                $prevID = $_GET['id'] - $i;
                $prev = Post::searchID($prevID);
                if (!empty($prev)) {
                    break;
                }
            }
            if (!empty($prev)) {
                $previmg = "views/images/{$prevID}.jpeg";
                ?>
                <div class="row justify-content-center">
                    <h3>Previous Post</h3>
                </div>
                <div class="card customcard" onclick="location.href = '?controller=post&action=searchID&id=<?php echo $prev->getPostID(); ?>';" style="width: 20rem;">
                    <img src="<?php echo $previmg ?>"  class="card-img-top">
                    <div class="card-body">
                        <p class="card-text"><small class="text-muted"><?php echo $prev->getDatePosted() . '&emsp; &emsp;' . $prev->getAuthor() ?></small></p>
                        <h5 class="card-title"><?php echo ucwords(Post::censor($prev->getTitle())) ?></h5>
                        <p class="card-text"><?php echo ucfirst(Post::censor($prev->getExcerpt())) ?></p>
                        <button><?php echo $prev->getCategory() ?></button>
                    </div>
                </div>
                <?php
            }
            ?>
        </div>
        <div class="col-md-4">
            <?php
            for ($i = 1; $i <= 3; $i++) {
                $nextID = $_GET['id'] + $i;
                $next = Post::searchID($nextID);
                if (!empty($next)) {
                    break;
                }
            }
            if (!empty($next)) {
                $nextimg = "views/images/{$nextID}.jpeg";
                ?>
                <div class="row justify-content-center">
                    <h3>Next Post</h3>
                </div>
                <div class="card customcard" onclick="location.href = '?controller=post&action=searchID&id=<?php echo $next->getPostID(); ?>';" style="width: 20rem;">
                    <img src="<?php echo $nextimg ?>"  class="card-img-top" >
                    <div class="card-body">
                        <p class="card-text"><small class="text-muted"><?php echo $next->getDatePosted() . '&emsp; &emsp;' . $next->getAuthor() ?></small></p>
                        <h5 class="card-title"><?php echo ucwords(Post::censor($next->getTitle())) ?></h5>
                        <p class="card-text"><?php echo ucfirst(Post::censor($next->getExcerpt())) ?></p>
                        <button><?php echo $next->getCategory() ?></button>
                    </div>
                </div>
                <?php
            }
            ?>
        </div>
    </div>
</section>

