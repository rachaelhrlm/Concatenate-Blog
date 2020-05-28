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
                                    <div class="col-md-8 featured">
                                        <img class="featured-img" src="views/images/<?php echo $featuredPost->getPostID() ?>.jpeg">
                                    </div>
                                    <div class="col-md-4 featured-text">
                                        <h2><?php echo $featuredPost->getTitle() ?></h2>
                                        <div class="smalltext"><?php echo $featuredPost->getDatePosted() . '&emsp; &emsp;' . $featuredPost->getAuthor() ?></div>
                                       
                                        <p><?php echo $featuredPost->getExcerpt() ?></p>
                                        <button onclick='location.href ="?controller=post&action=searchID&id=<?php echo $featuredPost->getPostID();?>"' class="btn btn-success align-self-end featured-btn">Read More</button>
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