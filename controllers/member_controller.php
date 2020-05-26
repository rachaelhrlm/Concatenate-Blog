<?php

class MemberController {

    public function login() {

        if (!isset($_SESSION['user'])) {
            if (isset($_POST['login'])) {
                $result = Member::login();
                ?>

                <?php
                return call('member', 'account');
            } elseif (isset($_POST['register'])) {
                Member::register();
                ;
            }
        } else {
            return call('pages', 'home');
            ;
        }
    }

    public function logout() {
        if (isset($_SESSION['user'])) {
            ob_start();
            session_unset();
            session_destroy();
            header('Refresh: 3');
            ob_end_flush();
            ?>
            <div class='alert alert-primary' role='alert'>
                Logout successful. Page will reload in 3 seconds, or close the alert to reload now.
                <button type='button' class='close' data-dismiss='alert' onclick="location.reload()" aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div> <?php
            return call('pages', 'home');
        } else {
            return call('pages', 'home');
            ;
        }
    }

    public function account() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            $user = $_SESSION['user']->searchID();
            if ($_SESSION['user']->getAccessLevelID() == 1) {
                $members = $_SESSION['user']->searchAllMembers();
                $posts = $_SESSION['user']->searchAll();
                $featuredPost1 = Member::searchFeaturedPosts(1);
                $featuredPost2 = Member::searchFeaturedPosts(2);
                $featuredPost3 = Member::searchFeaturedPosts(3);
                require_once('views/members/account.php');
            } else {
                $posts = $_SESSION['user']->searchAuthor();
                require_once('views/members/account.php');
            }
        } else {
            header("Location: ?controller=pages&action=home");
        }
    }

    public function updateName() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_GET['name'])) {
                $_SESSION['user']->updateName();
            
            ?>
            <div class='alert alert-primary' role='alert'>
                Name successfully updated.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
            return call('member', 'account');
            } else {
                return call('pages', 'error');
            }
        } else {
            return call('pages', 'home');
        }
    }
    public function updateAbout() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_GET['about'])) {
                $_SESSION['user']->updateAbout();
            
            ?>
            <div class='alert alert-primary' role='alert'>
                About Me successfully updated.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
            return call('member', 'account');
            } else {
                return call('pages', 'error');
            }
        } else {
            return call('pages', 'home');
        }
    }
    public function updateProfilePic() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_FILES['myUploader'])) {
                $_SESSION['user']->updateProfilePic();
            
            ?>
            <div class='alert alert-primary' role='alert'>
                Profile Picture successfully updated.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
            return call('member', 'account');
            } else {
                return call('pages', 'error');
            }
        } else {
            return call('pages', 'home');
        }
    }
    public function promoteMember() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_POST['id'])) {
                $_SESSION['user']->promoteMember($_POST['id']);
            
            ?>
            <div class='alert alert-primary' role='alert'>
                Member successfully promoted to blogger.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
            return call('member', 'account');
            } else {
                return call('pages', 'error');
            }
        } else {
            return call('pages', 'home');
        }
    }
    public function demoteMember() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_POST['id'])) {
                $_SESSION['user']->demoteMember($_POST['id']);
            
            ?>
            <div class='alert alert-primary' role='alert'>
                Blogger successfully demoted to member.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
            return call('member', 'account');
            } else {
                return call('pages', 'error');
            }
        } else {
            return call('pages', 'home');
        }
    }

}
