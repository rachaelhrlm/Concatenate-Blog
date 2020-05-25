<?php
include_once 'models/exceptions.php';

//require_once 'models/member.php';


class PostController {

    public function searchAll() {
        $posts = Post::searchAll();
        require_once('views/posts/searchAll.php');
    }

    public function searchID() {
        if (!isset($_GET['id'])) {
            return call('pages', 'error');
        } else {
            $post = Post::searchID($_GET['id']);
            if (isset($_SESSION['user'])) {
                $user = $_SESSION['user']->searchID();
            }
            if (isset($post)) {
                $comments = Post::searchComments($_GET['id']);
                $socials = Post::searchSocial($post->getMemberID());
                require_once('views/posts/read.php');
            } else {
                return call('pages', 'error');
            }
        }
    }

    public function edit() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 3) {
            if ($_SERVER['REQUEST_METHOD'] == 'GET') {
                if (!isset($_GET['id'])) {
                    return call('pages', 'error');
                }

                $post = Post::searchID($_GET['id']);
                if (isset($post)) {
                    $categories = Post::categories();
                    require_once('views/posts/edit.php');
                } else {
                    return call('pages', 'error');
                }
            } else {
                Post::edit($_GET['id']);

                $post = Post::searchID($_GET['id']);
                $socials = Post::searchSocial($post->getMemberID());
                require_once('views/posts/read.php');
            }
        } else {
            return call('pages', 'home');
        }
    }

    public function create() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 3) {
            if ($_SERVER['REQUEST_METHOD'] == 'GET') {
                if (isset($_SESSION['user'])) {
                    $user = Member::searchID();

                    $categories = Post::categories();
                    require_once('views/posts/create.php');
                }
            } else {

                $memberID = $_SESSION['user']->getMemberID();
                $_GET['id'] = Post::create($memberID);

                if (!empty($_GET['id'])) {
                    $post = Post::searchID($_GET['id']);
                    $socials = Post::searchSocial($_SESSION['user']->getMemberID());
                    require_once('views/posts/read.php');
                }
            }
        } else {
            return call('pages', 'home');
        }
    }

    public function delete() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 3) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                Post::delete($_GET['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Post successfully deleted.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                return call('member', 'account');
            }
        } else {
            return call('pages', 'home');
        }
    }

    public function restore() {
        if(isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 3) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                Post::restore($_GET['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Post successfully restored.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                return call('member', 'account');
            }
        } else {
            return call('pages', 'home');
        }
    }
    
    
    
    public function feature() {
        if(isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() == 1) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                Post::feature($_GET['id'],$_GET['post']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Post successfully featured.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                return call('member', 'account');
            }
        } else {
            return call('pages', 'home');
        }
    }
    
    public function createComment() {
        if(isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                $success=Post::createComment($_GET['id'], $_SESSION['user']->getMemberID());
                if(isset($success)){
                ?>
                <div class='alert alert-primary' role='alert'>
                    Comment successfully added.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php }
                return call('post', 'searchID');
            }
        }
    }

}
