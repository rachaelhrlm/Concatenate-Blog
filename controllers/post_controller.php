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
            require_once('views/posts/read.php');
        } catch (Exception $ex) {
            return call('pages', 'error');
        }
    }

        public function test() {
            require_once('views/posts/test.php');
        }

    }
    