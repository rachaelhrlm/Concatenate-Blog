<?php

class PostController {
    public function searchAll() {
      $posts = Post::searchAll();
      require_once('views/posts/searchAll.php');
    }
    
     public function update() {
        
      if($_SERVER['REQUEST_METHOD'] == 'GET'){
          if (!isset($_GET['id']))
        return call('pages', 'error');


        $post = Post::find($_GET['id']);
      
        require_once('views/posts/update.php');
        }
      else
          { 
            $id = $_GET['id'];
            Post::update($id);
                        
            $posts = Post::all();
            require_once('views/posts/readAll.php');
      }
      
    }
    
    
    public function test() {
      $categories = Post::categories();  
      require_once('views/posts/test.php');
    }
    
}

