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
        $req = $db->query('SELECT * FROM postInfo WHERE visibility = 1 ORDER BY postID DESC');
        foreach ($req->fetchAll() as $post) {
            $list[] = new Post($post['postID'], $post['memberID'], $post['categoryID'], $post['title'], $post['author'], $post['about'], $post['category'], $post['datePosted'], $post['dateUpdated'], $post['excerpt'], $post['content']);
        }
        return $list;
    }

    public static function searchLatest() {
        $list = [];
        $db = Db::getInstance();
        $req = $db->query('SELECT * FROM postInfo WHERE visibility = 1 ORDER BY postID DESC LIMIT 3');
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
                ?>
                <div class="card customcard" onclick="location.href = '?controller=post&action=searchID&id=<?php echo $post['postID'] ?>'" style="width: 20rem;">
                    <img src="<?php echo $img ?>"  class="card-img-top">
                    <div class="card-body">
                        <p class="card-text"><small class="text-muted"><?php echo $post['datePosted'] . '&emsp; &emsp;' . $post['author'] ?></small></p>
                        <h5 class="card-title"><?php echo ucwords(Post::censor($post['title'])) ?></h5>
                        <hr>
                        <p class="card-text"><?php echo ucfirst(Post::censor($post['excerpt'])) ?> </p>
                        <button><?php echo $post['category'] ?></button>
                    </div></div>
                <?php
            }
            echo '</div></div>';
        } else { //if there are no results, echo 'No results found.'
            echo 'No results found.';
        }
    }

//    method for searching post by its postid
    public static function searchID($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('SELECT * FROM postinfo WHERE postID = :id AND visibility = 1');
        $req->execute(array('id' => $id));
        $post = $req->fetch();
        if (!empty($post)) {
            return new Post($post['postID'], $post['memberID'], $post['categoryID'], $post['title'], $post['author'], $post['about'], $post['category'], $post['datePosted'], $post['dateUpdated'], $post['excerpt'], $post['content']);
        } else {
            return $post = NULL;
        }
    }

//    method for searching for all comments of a post
    public static function searchComments($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('call searchComment(?)');
        $req->execute([$id]);
        return $req->fetchAll(PDO::FETCH_ASSOC);
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
            $content = $filteredContent;
            $title = $filteredTitle;
            $categoryID = $_POST['categoryID'];
            $excerpt = $filteredExcerpt;

            try {
                if (strlen($_POST['title']) > 100) {
                    throw new WordingTooLongException('of 100 for your title');
                } else if (strlen($_POST['excerpt']) > 250) {
                    throw new WordingTooLongException('of 250 for your excerpt');
                } else {

                    $req->execute([$id, $title, $categoryID, $excerpt, $content]);
                    $postID = $req->fetch(PDO::FETCH_ASSOC);
                }
            } catch (WordingTooLongException $e) {
                ?> <div class='alert alert-primary' role='alert'>
                    You have exceeded the character limit <?php echo $e->getMessage() ?>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div> <?php
            }
            if (!empty($_FILES[self::InputKey]['name'])) {
                try {
                    list($width, $height, $type, $attr) = getimagesize($_FILES[self::InputKey]['tmp_name']);
                    if (empty($_FILES[self::InputKey])) {
                        throw new NoFileException();
                    } else if (!in_array($_FILES[self::InputKey]['type'], self::AllowedTypes)) {
                        throw new WrongFileTypeException();
                    } else if ($height > $width) {
                        throw new PortraitException();
//                    } else if ($height < '530' || $width < '790') {
//                        throw new LowResolutionException();
                    } else if ($_FILES[self::InputKey]['error'] > 0) {
                        throw new Exception();
                    } else {
                        Post::uploadFile($id);
                    }
                } catch (PortraitException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Only landscape photos are allowed. Please choose another image. The recommended size is 800 x 534 pixels, 72 dpi.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (LowResolutionException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Resolution too low. Please choose another image. The recommended size is 800 x 534 pixels, 72 dpi.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (NoFileException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        File missing! Please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (WrongFileTypeException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        You cannot upload this file type <?php echo $_FILES[self::InputKey]['type'] ?>, please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                <?php } catch (Exception $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        oops something went wrong
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div><?php
                }
            } if (isset($postID['postID'])) {
                return $postID['postID'];
            } else {
                return null;
            }
        }
    }

    public static function create($id) {
        $db = Db::getInstance();
        $req = $db->prepare("call createPost(?,?,?,?,?)");

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
            $categoryID = intval($_POST['categoryID']);
            $excerpt = $filteredExcerpt;
            $content = $filteredContent;

            try {
                if (strlen($_POST['title']) > 100) {
                    throw new WordingTooLongException('of 100 for your title');
                } else if (strlen($_POST['excerpt']) > 250) {
                    throw new WordingTooLongException('of 250 for your excerpt');
                } else {

                    $req->execute([$id, $title, $categoryID, $excerpt, $content]);
                    $postID = $req->fetch(PDO::FETCH_ASSOC);
                }
            } catch (WordingTooLongException $e) {
                ?> <div class='alert alert-primary' role='alert'>
                    You have exceeded the character limit <?php echo $e->getMessage() ?>
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div> <?php
            }
            if (!empty($_FILES[self::InputKey]['name'])) {
                try {
                    list($width, $height, $type, $attr) = getimagesize($_FILES[self::InputKey]['tmp_name']);
                    if (empty($_FILES[self::InputKey])) {
                        throw new NoFileException();
                    } else if (!in_array($_FILES[self::InputKey]['type'], self::AllowedTypes)) {
                        throw new WrongFileTypeException();
                    } else if ($height > $width) {
                        throw new PortraitException();
                    } else if ($_FILES[self::InputKey]['error'] > 0) {
                        throw new Exception();
                    } else {
                        Post::uploadFile($postID['postID']);
                    }
                } catch (PortraitException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Only landscape photos are allowed. Please choose another image. The recommended size is 800 x 534 pixels, 72 dpi.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (LowResolutionException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Resolution too low. Please choose another image. The recommended size is 800 x 534 pixels, 72 dpi.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (NoFileException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        File missing! Please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (WrongFileTypeException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        You cannot upload this file type <?php echo $_FILES[self::InputKey]['type'] ?>, please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                <?php } catch (Exception $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        oops something went wrong
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div><?php
                }
            }
        } if (isset($postID['postID'])) {
            return $postID['postID'];
        } else {
            return null;
        }
    }

    public static function delete($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE post SET visibility = 0 WHERE postID = ?');
        $req->execute([$id]);
    }

    public static function restore($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE post SET visibility = 1 WHERE postID = ?');
        $req->execute([$id]);
    }

    public static function feature($id, $feature) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE featuredPost SET postID = ? WHERE featuredPostID = ?');
        $req->execute([$id, $feature]);
    }

    public static function censor($message) {
        return str_replace(Post::Curses, '<i class="curses"> meow</i>', strtolower($message));
    }

    public static function createComment($id, $member) {
        $db = Db::getInstance();
        $id = intval($id);
        $member = intval($member);
        $req = $db->prepare('INSERT INTO postComment (postID, memberID, message, dateCommented) VALUES(?,?,?,CURDATE())');
        if (isset($_GET['message']) && $_GET['message'] != "") {
            $filteredMessage = filter_input(INPUT_GET, 'message', FILTER_SANITIZE_SPECIAL_CHARS);
        }

        try {
            if (strlen($_GET['message']) > 200) {
                throw new WordingTooLongException('of 200 for your comment.');
            } else {
                $message = $filteredMessage;
                $req->execute([$id, $member, $message]);
                return true;
            }
        } catch (WordingTooLongException $e) {
            ?> <div class='alert alert-primary' role='alert'>
                You have exceeded the character limit <?php echo $e->getMessage() ?>
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div> <?php
            return null;
        }
    }

//    method and constants for uploadFile
    const AllowedTypes = ['image/jpeg', 'image/jpg'];
    const InputKey = 'myUploader';
    const Curses = ['shit', 'Shit', 'fuck', 'Fuck'];

    public static function uploadFile(string $postID) {
        $tempFile = $_FILES[self::InputKey]['tmp_name'];
        $path = "C:/xampp/htdocs/MVC/MVC-Skeleton/views/images/";
        $destinationFile = $path . $postID . '.jpeg';
        move_uploaded_file($tempFile, $destinationFile);
        if (file_exists($tempFile)) {
            unlink($tempFile);
        }
    }

}
