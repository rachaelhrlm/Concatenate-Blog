<?php

class Post {

//    attributes
    private $postID;
    private $memberID;
    private $categoryID;
    private $title;
    private $author;
    private $about;
    private $category;
    private $datePosted;
    private $dateUpdated;
    private $excerpt;
    private $content;

//    constructor
    public function __construct($postID, $memberID, $categoryID, $title, $author, $about, $category, $datePosted, $dateUpdated, $excerpt, $content) {
        $this->postID = $postID;
        $this->memberID = $memberID;
        $this->categoryID = $categoryID;
        $this->title = $title;
        $this->author = $author;
        $this->about = $about;
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

    public function getAbout() {
        return $this->about;
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

    public function setAbout($about) {
        $this->author = $about;
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

//    method for selecting all posts
    public static function searchAll() {
        $list = [];
        $db = Db::getInstance();
        $req = $db->query('SELECT * FROM postInfo ORDER BY postID DESC');
        foreach ($req->fetchAll() as $post) {
            $list[] = new Post($post['postID'], $post['memberID'], $post['categoryID'], $post['title'], $post['author'], $post['about'], $post['category'], $post['datePosted'], $post['dateUpdated'], $post['excerpt'], $post['content']);
        }
        return $list;
    }

//    method for selecting post via Ajax where keyword matches anything
    public static function searchAny($keyword) {
        $db = Db::getInstance();
        $req = $db->prepare('CALL searchPost(?)');
        $req->execute([$keyword]);
        $posts = $req->fetchAll(PDO::FETCH_ASSOC); //specifying that I want the results to be associative arrays
        if (!empty($posts)) { //if there are results, echo out a container along with a loop of Post Cards
            echo '<div class="container"><div class="row justify-content-center">';
            foreach ($posts as $post) {
                $img = "views/images/{$post['postID']}.jpeg";
                echo '<div class="card customcard" onclick="location.href = ' . "'?controller=post&action=searchID&id=" . $post['postID'] . "'" . '"' . '; style="width: 20rem;">';
                echo '<img src="' . $img . '"  class="card-img-top" alt="Image for ' . $post['title'] . '">';
                echo '<div class="card-body">';
                echo '<p class="card-text"><small class="text-muted">' . $post['datePosted'] . '&emsp; &emsp;' . $post['author'] . '</small></p>';
                echo '<h5 class="card-title">' . $post['title'] . '</h5>';
                echo '<p class="card-text">' . $post['excerpt'] . '</p>';
                echo '<button>' . $post['category'] . '</button>';
                echo '</div></div>';
            }
            echo '</div></div>';
        } else { //if there are no results, echo 'No results found.'
            echo 'No results found.';
        }
    }

//    method for searching post by its postid
    public static function searchID($id) {
        $db = Db::getInstance();
//use intval to make sure $id is an integer
        $id = intval($id);
        $req = $db->prepare('SELECT * FROM postinfo WHERE postID = :id');
//the query was prepared, now replace :id with the actual $id value
        $req->execute(array('id' => $id));
        $post = $req->fetch();
        if (!empty($post)) {
            return new Post($post['postID'], $post['memberID'], $post['categoryID'], $post['title'], $post['author'], $post['about'], $post['category'], $post['datePosted'], $post['dateUpdated'], $post['excerpt'], $post['content']);
        } else {
            return $post = NULL;
        }
    }

//    method for finding all socials for chosen member
    public static function searchSocial($id) {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT * from socialLink WHERE memberID = ?');
        $req->execute([$id]);
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }

//    method for getting all categories (for dropdown)
    public static function categories() {
        $db = Db::getInstance();
        $req = $db->query('SELECT * FROM category');
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }

//     method for editing post
    public static function edit($id) {
        $db = Db::getInstance();
        $req = $db->prepare("call editPost(?,?,?,?,?)");

        if (!empty($_POST)) {
            if (isset($_POST['title']) && $_POST['title'] != "") {
                $filteredTitle = filter_input(INPUT_POST, 'title', FILTER_SANITIZE_SPECIAL_CHARS);
            }
            if (isset($_POST['excerpt']) && $_POST['excerpt'] != "") {
                $filteredExcerpt = filter_input(INPUT_POST, 'excerpt', FILTER_SANITIZE_SPECIAL_CHARS);
            }
            if (isset($_POST['content']) && $_POST['content'] != "") {
                $filteredContent = filter_input(INPUT_POST, 'content', FILTER_SANITIZE_SPECIAL_CHARS);
            }

            $title = $filteredTitle;
            $categoryID = $_POST['categoryID'];
            $excerpt = $filteredExcerpt;
            $content = $filteredContent;
            $req->execute([$id, $title, $categoryID, $excerpt, $content]);



            if (!empty($_FILES[self::InputKey]['name'])) {

                try {


                    if (empty($_FILES[self::InputKey])) {
//die("File Missing!");
                        throw new NoFileException();
                    } else if (!in_array($_FILES[self::InputKey]['type'], self::AllowedTypes)) {
                        throw new WrongFileTypeException();
                    } else if ($_FILES[self::InputKey]['error'] > 0) {
                        throw new Exception();
                    } else {
                        Post::uploadFile($id);
                    }
                } catch (NoFileException $ex) {
                    echo "File missing! Please try again.";
                } catch (WrongFileTypeException $ex) {
                    echo "You cannot upload this file type {$_FILES[self::InputKey]['type']}, please try again.";
                } catch (Exception $ex) {
                    echo "oops something went wrong";
                }
            } else {
                trigger_error("Post Info Missing!");
            }
        }
    }

//    method and constants for uploadFile
    const AllowedTypes = ['image/jpeg', 'image/jpg'];
    const InputKey = 'myUploader';

    public static function uploadFile(string $postID) {






        $tempFile = $_FILES[self::InputKey]['tmp_name'];
        $path = "C:/xampp/htdocs/MVC/MVC-Skeleton/views/images/";
        $destinationFile = $path . $postID . '.jpeg';

        if (!move_uploaded_file($tempFile, $destinationFile)) {
            throw new NotMovedToDestinationException();
        }

//Clean up the temp file
        if (file_exists($tempFile)) {
            unlink($tempFile);
        }
    }

}
