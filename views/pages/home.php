<div class="container-fluid">



    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
        <div class="container">
            <div class="row justify-content-center">
                <div class="carousel-inner col-md-9">
                    <?php
                    $i = 0;
                    foreach ($featuredPosts as $featuredPost) {
                        if ($i == 0) {
                            ?>
                            <div class="carousel-item active">
                            <?php } else { ?>
                                <div class="carousel-item">
                                <?php } ?>
                                <div class="row justify-content-center">
                                    <div class="col-md-6 featured">
                                        <img class="featured-img" src="views/images/<?php echo $featuredPost->getPostID() ?>.jpeg">
                                    </div>
                                    <div class="col-md-6 featured-text">
                                        <h2><?php echo $featuredPost->getTitle() ?></h2>
                                        <div class="small-text"><?php echo $featuredPost->getDatePosted() . '&emsp; &emsp;' . $featuredPost->getAuthor() ?></div>

                                        <p class="feature-excerpt"><?php echo $featuredPost->getExcerpt() ?></p>
                                        <button onclick='location.href = "?controller=post&action=searchID&id=<?php echo $featuredPost->getPostID(); ?>"' class="btn btn-outline-secondary align-self-end featured-btn">Read More</button>
                                    </div>
                                </div>
                            </div>
                            <?php
                            $i++;
                        }
                        ?>
                    </div>
                </div>



                <a class="carousel-control-prev icon" href="#carouselExampleControls" role="button" data-slide="prev">
                    <span class="fas fa-angle-left fa-3x"" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next icon" href="#carouselExampleControls" role="button" data-slide="next">
                    <span class="fas fa-angle-right fa-3x"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>

        </div>
    </div>



        <div class="spacer"></div>


        <div class="container-fluid latestPosts">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <h1>Latest Posts:</h1>
                    </div>
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