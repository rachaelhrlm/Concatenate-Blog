<?php

class PostController {
    public function searchAll() {
      $posts = Post::searchAll();
      require_once('views/posts/searchAll.php');
    }
    
    
    
    
    public function test() {
      require_once('views/posts/test.php');
    }
    
}

