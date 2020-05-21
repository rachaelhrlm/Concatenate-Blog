<section> 
    <form action="" method="POST" enctype="multipart/form-data">

        <!--Title Input-->
        <div class="form-group row">
            <label for="title" class="col-sm-2 col-form-label">Title</label>
            <div class="col-md-10">
                <input type="title" name="title" class="form-control" id="title" value="<?php echo $post->getTitle() ?>" required>
            </div>
        </div>


        <!--Author Input-->
        <div class="form-group row">
            <label for="author" class="col-sm-2 col-form-label">Author</label>
            <div class="col-md-10">
                <input type="author" name="author" class="form-control" id="author" value="<?php echo $post->getAuthor() ?>" disabled>
            </div>
        </div>



        <!--Category Input-->
        <div class="form-group row">
            <label for="category" class="col-sm-2 col-form-label">Category</label>
            <div class="col-md-10">
                <select class="custom-select" name="categoryID">
                    <?php
                    foreach ($categories as $category) {
                        if ($category['categoryID'] === $post->getCategoryID()) {
                            ?>
                            <option value="<?php echo $category['categoryID'] ?>" selected><?php echo $category['category'] ?></option>
                        <?php } else { ?>
                            <option value="<?php echo $category['categoryID'] ?>"><?php echo $category['category'] ?></option>
                            <?php
                        }
                    }
                    ?>
                </select>
            </div>
        </div>



        <!--Excerpt Input-->
        <div class="form-group row">
            <label for="excerpt" class="col-sm-2 col-form-label" >Excerpt</label>
            <div class="col-sm-10">
                <input type="excerpt" name="excerpt" class="form-control" id="excerpt" value="<?php echo $post->getExcerpt() ?>" required>
            </div>
        </div>



        <input type="hidden" name="MAX_FILE_SIZE" value="10000000" />
        <!--Image Input-->
        <div class="form-group row">
            <label for="image" class="col-sm-2 col-form-label" >Image</label>
            <div class="col-sm-10">
                <?php
                $file = 'views/images/' . $post->getPostID() . '.jpeg';
                if (file_exists($file)) {
                    $img = "<img src='$file?=Date('U')' width='500' />";
                    echo $img;
                } else {
                    echo "<img src='views/images/standard/_noproductimage.png' width='150' />";
                }
                ?>
                <div class="custom-file">
                    <input type="file" name="myUploader" class="custom-file-input" id="image">
                    <label class="custom-file-label" for="image">Choose file</label>
                </div>
            </div>
        </div>





        <!--Content Input-->
        <div class="form-group row">
            <label for="content" class="col-sm-2 col-form-label" >Content</label>
            <div class="col-sm-10">
                <input type="content" name="content" class="textarea" id="content" value="<?php echo $post->getContent() ?>" required>
            </div>
        </div>




        <div class="form-row justify-content-end">
            <input type="submit" value="Submit" class="btn btn-primary">
        </div>
    </form>


</section>