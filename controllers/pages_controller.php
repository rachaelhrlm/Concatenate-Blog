<?php
include_once 'models/post.php';

class PagesController {

    public function home() {
        $featuredPosts = 
        [$fpost1 = Post::searchID(intval(Member::searchFeaturedPosts(1)['postID'])),
        $fpost2 = Post::searchID(intval(Member::searchFeaturedPosts(2)['postID'])),
        $fpost3 = Post::searchID(intval(Member::searchFeaturedPosts(3)['postID']))];

        require_once('views/pages/home.php');
    }

    public function error() {
        require_once('views/pages/error.php');
    }

}
