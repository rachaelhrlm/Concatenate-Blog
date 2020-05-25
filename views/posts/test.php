<section> 
    <form>
        <div class="form-group row">
            <label for="title" class="col-sm-2 col-form-label">Title</label>
            <div class="col-md-10">
                <input type="title" class="form-control" id="title" placeholder="title">
            </div>
        </div>
        <div class="form-group row">
            <label for="category" class="col-sm-2 col-form-label">Category</label>
            <div class="col-md-10">
                <select class="custom-select">
                    <?php foreach ($categories as $category) { ?>
                        <option value="<?php echo $category['categoryID'] ?>"><?php echo $category['category'] ?></option>
                    <?php } ?>
                </select>
            </div>
        </div>
        <div class="form-group row">
            <label for="" class="col-sm-2 col-form-label">Excerpt</label>
            <div class="col-sm-10">
                <input type="excerpt" class="form-control" id="inputPassword3" placeholder="excerpt">
            </div>
        </div>
    </form>


</section>