<?php
require_once 'models/post.php';

class MemberController {

    public function login() {
        if (!isset($_SESSION['user'])) {
            Member::login();
            return call('pages', 'home');
        } else {
            return call('pages', 'home');
        }
    }

    public function register() {
        if (!isset($_SESSION['user'])) {
            Member::register();
            return call('pages', 'home');
        } else {
            return call('pages', 'home');
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
            $favs = $_SESSION['user']->searchFavourites();
            $favposts = $_SESSION['user']->searchAll();
            if ($_SESSION['user']->getAccessLevelID() == 1) {
                $posts = $_SESSION['user']->searchAll();
                $members = $_SESSION['user']->searchAllMembers();
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

    public function updateEmail() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_GET['name'])) {
                $_SESSION['user']->updateEmail();
                ?>
                <div class='alert alert-primary' role='alert'>
                    Email successfully updated.
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
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() === 1) {
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
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() === 1) {
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

    public function banMember() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() == 1) {
            if (isset($_POST['id'])) {
                $_SESSION['user']->banMember($_POST['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Member successfully banned.
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

    public function unbanMember() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() == 1) {
            if (isset($_POST['id'])) {
                $_SESSION['user']->demoteMember($_POST['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Member successfully unbanned.
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

    public function changeEmail() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_POST['confirmLogin'])) {
                $result = $_SESSION['user']->confirmLogin();
                if (!empty($result)) {
                    $_SESSION['verification'] = true;
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Login successfully verified.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>  <?php
                    return call('member', 'account');
                } else {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Login verification unsuccessful.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>  
                    <?php
                    return call('member', 'account');
                }
            } else if (isset($_SESSION['verification']) && isset($_POST['changeEmail'])) {
                $_SESSION['user']->updateEmail();
                ?>
                <div class='alert alert-primary' role='alert'>
                    Email successfully updated.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                unset($_SESSION['verification']);
                unset($_POST['confirmLogin']);
                return call('member', 'account');
            }
        } else {
            return call('pages', 'home');
        }
    }

    public function changePassword() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (isset($_POST['confirmLogin'])) {
                $result = $_SESSION['user']->confirmLogin();
                if (!empty($result)) {
                    $_SESSION['verification'] = true;
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Login successfully verified.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>  <?php
                    return call('member', 'account');
                } else {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Login verification unsuccessful.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>  
                    <?php
                    return call('member', 'account');
                }
            } else if (isset($_SESSION['verification']) && isset($_POST['changePassword'])) {
                $_SESSION['user']->updatePassword();
                ?>
                <div class='alert alert-primary' role='alert'>
                    Password successfully updated.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                unset($_SESSION['verification']);
                return call('member', 'account');
            }
        } else {
            return call('pages', 'home');
        }
    }

    public function fav() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                $_SESSION['user']->fav($_GET['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Post successfully added to favourites.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                return call('post', 'searchID');
            }
        }
    }

    public function unfav() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if (!isset($_GET['id'])) {
                return call('pages', 'error');
            } else {
                $_SESSION['user']->unfav($_GET['id']);
                ?>
                <div class='alert alert-primary' role='alert'>
                    Post successfully removed from favourites.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                return call('post', 'searchID');
            }
        }
    }

}
