<section class="container"> 


    <div class=" row justify-content-center">
        <div class="col-md-7">
            <h1>Editing Post #<?php echo $post->getPostID() ?></h1>
        </div>
        <div class="col-md-2 text-right">
            <a href="?controller=member&action=account#actions"><i class="far fa-times-circle fa-3x icon" data-toggle="tooltip" data-placement="top" title="Cancel Edit"></i></a>
        </div>
    </div>    
    <div class=" row justify-content-center">
        <div class="col-md-9">
        <hr>
        </div>
    </div>
    
    
    
    
    <div class="spacer"></div>
    
    
    
    <div class=" row justify-content-center">





        <form action="" method="POST" enctype="multipart/form-data" class="col-md-9">

            <!--Title Input-->
            <div class="form-group row justify-content-between">
                <label for="title" class="col-md-2 col-form-label">Title</label>
                <div class="col-md-9">
                    <input type="title" name="title" class="form-control" id="title" value="<?php echo $post->getTitle() ?>" required>
                </div>
            </div>


            <!--Author Input-->
            <div class="form-group row justify-content-between ">
                <label for="author" class="col-md-2 col-form-label">Author</label>
                <div class="col-md-9">
                    <input type="author" name="author" class="form-control" id="author" value="<?php echo $post->getAuthor() ?>" disabled>
                </div>
            </div>



            <!--Category Input-->
            <div class="form-group row justify-content-between">
                <label for="category" class="col-md-2 col-form-label">Category</label>
                <div class="col-md-9">
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
            <div class="form-group row justify-content-between">
                <label for="excerpt" class="col-md-2 col-form-label" >Excerpt</label>
                <div class="col-md-9">
                    <input type="excerpt" name="excerpt" class="form-control" id="excerpt" value="<?php echo $post->getExcerpt() ?>" required>
                </div>
            </div>



            <input type="hidden" name="MAX_FILE_SIZE" value="10000000" />
            <!--Image Input-->
            <div class="form-group row justify-content-between">
                <label for="image" class="col-md-2 col-form-label" >Image</label>
                <div class="col-md-9">
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
            <div class="form-group row justify-content-between">
                <label for="content" class="col-md-2 col-form-label" >Content</label>
                <div class="col-md-9">
                    <input type="content" name="content" class="textarea" id="content" value="<?php echo $post->getContent() ?>" required>
                </div>
            </div>




            <div class="form-row justify-content-end">
                <input type="submit" value="Submit" class="btn btn-success">
            </div>
        </form>

    </div>
</section>