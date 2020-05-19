<?php

class PostController {
    public function searchAll() {
      $posts = Post::all();
      require_once('views/posts/searchAll.php');
    }
    
    
    
    
    
    
}

