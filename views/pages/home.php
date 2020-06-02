<div class="container-fluid" id="featured">


    <div id="featuredPost" class="carousel slide" data-ride="carousel">
        <div class="container">
            <div class="row justify-content-center">
                <i class="far fa-newspaper fa-3x icon"></i><h1>Featured Stories</h1>
            </div>
            <div class="row justify-content-center">
                <div class="carousel-inner col-md-10">
                    <?php
                    $i = 0;
                    foreach ($featuredPosts as $featuredPost) {
                        if ($i == 0) {
                            ?>
                            <div class="carousel-item active">
                            <?php } else { ?>
                                <div class="carousel-item">
                                <?php } ?>
                                <div class="row">
                                    <div class="col-md-7 featured">
                                        <img class="featured-img" src="views/images/<?php echo $featuredPost->getPostID() ?>.jpeg">
                                    </div>
                                    <div class="col-md-5 featured-text">
                                        <div class="smalltext"><?php echo $featuredPost->getDatePosted() . '&emsp; &emsp;' . $featuredPost->getAuthor() ?></div>
                                        <h2><?php echo Post::censor($featuredPost->getTitle()) ?></h2>
                                        
                                        <hr>
                                        <p><?php echo ucfirst(Post::censor($featuredPost->getExcerpt())) ?></p>
                                        <button onclick='location.href ="?controller=post&action=searchID&id=<?php echo $featuredPost->getPostID();?>"' class="btn1 fourth align-self-end featured-btn">Read More</button>
                                    </div>
                                </div>
                            </div>
                            <?php
                            $i++;
                        }
                        ?>
                    </div>
                </div>
                
                

                <a class="carousel-control-prev icon" href="#featuredPost" role="button" data-slide="prev">
                    <span class="fas fa-angle-left fa-3x"" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next icon" href="#featuredPost" role="button" data-slide="next">
                    <span class="fas fa-angle-right fa-3x"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

        </div>
    </div>
</div>
        
    <hr>
    
    
    
    
        <div class="container-fluid latestPosts">
            <div class="container">
                <div class="col-md-12">
                <div class="row justify-content-center">
                    
                        <i class="far fa-clock fa-3x icon"></i><h1>Recent Stories</h1>
                    
                </div>
                <div class="row justify-content-center">
                    <?php
                    foreach ($latest as $post) {
                        $img = "views/images/{$post->getPostID()}.jpeg";
                        ?>
                        <div class="card customcard latestcard" onclick="location.href = '?controller=post&action=searchID&id=<?php echo $post->getPostID(); ?>';" style="width: 20rem;">
                            <img src="<?php echo $img ?>"  class="card-img-top" alt="Image for <?php ucwords(Post::censor($post->getTitle())) ?>">
                            <div class="card-body">
                                <p class="card-text"><small class="text-muted"><?php echo $post->getDatePosted() . '&emsp; &emsp;' . $post->getAuthor() ?></small></p>
                                <h5 class="card-title"><?php echo ucwords(Post::censor($post->getTitle())) ?></h5>
                                <hr>
                                <p class="card-text"><?php echo ucfirst(Post::censor($post->getExcerpt())) ?></p>
                                <button><?php echo $post->getCategory() ?></button>
                            </div>
                        </div>
                        <?php
                    }
                    ?>
                </div>
                    </div>
            </div>
            <div class="spacer"></div>
        </div>