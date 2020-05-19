<?php

class Post {

//    attributes
    private $postID;
    private $memberID;
    private $categoryID;
    private $title;
    private $author;
    private $category;
    private $datePosted;
    private $dateUpdated;
    private $excerpt;
    private $content;

//    constructor
    public function __construct($postID, $memberID, $categoryID, $title, $author, $category, $datePosted, $dateUpdated, $excerpt, $content) {
        $this->postID = $postID;
        $this->memberID = $memberID;
        $this->categoryID = $categoryID;
        $this->title = $title;
        $this->author = $author;
        $this->category = $category;
        $this->datePosted = $datePosted;
        $this->dateUpdated = $dateUpdated;
        $this->excerpt = $excerpt;
        $this->content = $content;
    }
    
    
//    getters
    public function getPostID() {
        return $this->postID;
    }
    public function getMemberID() {
        return $this->memberID;
    }
    public function getCategoryID() {
        return $this->categoryID;
    }
    public function getTitle() {
        return $this->title;
    }
    public function getAuthor() {
        return $this->author;
    }
    public function getCategory() {
        return $this->category;
    }
    public function getDatePosted() {
        return $this->datePosted;
    }
    public function getDateUpdated() {
        return $this->dateUpdated;
    }
    public function getExcerpt() {
        return $this->excerpt;
    }
    public function getContent() {
        return $this->content;
    }
    
    
 //    setters
    public function setPostID($postID) {
        $this->postID = $postID;
    }
    public function setMemberID($memberID) {
        $this->memberID = $memberID;
    }
    public function setCategoryID($categoryID) {
        $this->categoryID = $categoryID;
    }
    public function setTitle($title) {
        $this->title = $title;
    }
    public function setAuthor($author) {
        $this->author = $author;
    }
    public function setCategory($category) {
        $this->category = $category;
    }
    public function setDatePosted($datePosted) {
        $this->datePosted = $datePosted;
    }
    public function setDateUpdated($dateUpdated) {
        $this->dateUpdated = $dateUpdated;
    }
    public function setExcerpt($excerpt) {
        $this->excerpt = $excerpt;
    }   
    public function setContent($content) {
        $this->content = $content;
    }   
    
    
    
//    methods
    public static function all() {
        $list = [];
        $db = Db::getInstance();
        $req = $db->query('SELECT * FROM postInfo ORDER BY postID DESC');
        foreach ($req->fetchAll() as $post) {
            $list[] = new Post($post['postID'], $post['memberID'], $post['categoryID'], $post['title'], $post['author'], $post['category'], $post['datePosted'], $post['dateUpdated'], $post['excerpt'], $post['content']);
        }
        return $list;
    }
    
    
    
    
    
}
