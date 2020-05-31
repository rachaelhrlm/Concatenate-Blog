<?php
?>
<!--AJAX Search onMouseUp-->
<script>
    function searchPost(str) {

        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
//          put the results of the query inside .results div
                document.querySelector(".results").innerHTML = this.responseText;
            }
//          if there is something written inside .results div, hide the .postAll div
            if (document.querySelector(".results").innerHTML !== '') {
                document.querySelector(".postAll").style.display = 'none';
            }
        };
        xhr.open("GET", "views/scripts/searchAny.php?search=" + str, true);
        xhr.send();
    }
</script>








<!--Search Bar Section-->
<div class="container-fluid animated">
    <div class="container">
        <div class="row ">
            <div class="col-md-3"></div>
            <div class="col-md-6 animated-container">
                <div class="search"><h1 >Looking for something?</h1></div>
                <label class="sr-only" for="inlineFormInputGroup">Search</label>
                <div class=" searchbar">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <div class="input-group-text"><i class="fas fa-search"></i></div>
                    </div>
                    <input type="text" class="form-control" id="inlineFormInputGroup" placeholder="search" onkeyup="searchPost(this.value)">
                    
                </div>
                <div class="circle"></div>
                </div>
                <div class="search"><p><b>try:</b> motivational, career, lifestyle</p> </div>
            </div>
            <div class="col-md-3"></div>
        </div>
    </div>
</div>
<hr>

<!--Padding-->
<div class="spacer"></div>


<!--Search Results Section-->
<div class="container">
    <div class="row justify-content-center results"></div>
</div>


<!--All Posts Section-->
<div class="container">
    <div class="row justify-content-center postAll">
        <?php foreach ($posts as $post) { ?>
            <?php
            $img = "views/images/{$post->getPostID()}.jpeg";
            ?>
            <div class="card customcard" onclick="location.href = '?controller=post&action=searchID&id=<?php echo $post->getPostID(); ?>';" style="width: 20rem;">
                <img src="<?php echo $img ?>"  class="card-img-top" alt="Image for <?php ucwords(Post::censor($post->getTitle())) ?>">
                <div class="card-body">
                    <p class="card-text"><small class="text-muted"><?php echo $post->getDatePosted() . '&emsp; &emsp;' . $post->getAuthor() ?></small></p>
                    <h5 class="card-title"><?php echo ucwords(Post::censor($post->getTitle())) ?></h5>
                    <hr>
                    <p class="card-text"><?php echo ucfirst(Post::censor($post->getExcerpt())) ?></p>
                    <button><?php echo $post->getCategory() ?></button>
                </div>
            </div>
        <?php } ?>
    </div>
</div>

<!--Padding-->
<div class="spacer"></div>