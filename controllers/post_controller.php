<?php

class PostController {

    public function searchAll() {
        $posts = Post::searchAll();
        require_once('views/posts/searchAll.php');
    }

    public function searchID() {
        if (!isset($_GET['id']))
            return call('pages', 'error');
        try {
            $post = Post::searchID($_GET['id']);
            $socials = Post::searchSocial($post->getMemberID());
            require_once('views/posts/read.php');
        } catch (Exception $ex) {
            return call('pages', 'error');
        }
    }

    public function edit() {

        if ($_SERVER['REQUEST_METHOD'] == 'GET') {
            if (!isset($_GET['id']))
                return call('pages', 'error');


            $post = Post::searchID($_GET['id']);
            $categories = Post::categories();
            require_once('views/posts/edit.php');
        }
        else {
            try {



                
                // check if length over 255
                If (strlen($_POST['title']) > 40) {
// throw exception if title > 100
                    throw new WordingTooLongException('of 10 for your title');
                } else If (strlen($_POST['excerpt']) > 50) {
// throw exception if excerpt > 255
                    throw new WordingTooLongException('of 10 for your excerpt');
                } else {
                    $id = $_GET['id'];
                    Post::edit($id);

                    $post = Post::searchID($_GET['id']);
                    $socials = Post::searchSocial($post->getMemberID());
                    require_once('views/posts/read.php');
                }
            } catch (WordingTooLongException $e) {
                ?> <div class='alert alert-primary' role='alert'>
                    You have exceeded the character limit <?php echo $e->getMessage() ?>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div> <?php
            }
        }
    }

}
