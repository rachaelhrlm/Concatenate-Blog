<?php
class MemberController {

    public function login() {

        if (!isset($_SESSION['user'])) {
            if (isset($_POST['login'])) {
                ob_start();
                $result = Member::login();
                header('Refresh:3, ?controller=pages&action=home');
                require_once('views/members/access.php');
                ob_end_flush();
            } elseif (isset($_POST['register'])) {
                Member::register();
                require_once('views/members/access.php');
            } else {
                require_once('views/members/access.php');
            }
        } else {
            header("Location: ?controller=member&action=account");
        }
    }

    public function logout() {
        if (isset($_SESSION['user'])) {
            ob_start();
            session_unset();
            session_destroy();
            $result = "Logout successful. Redirecting to home page in 3 seconds.<br>"
                    . "<a  href='?controller=pages&action=home'><div class='smalltext'>(or click here to go now)</a></div>";
            header('Refresh:3, ?controller=pages&action=home');
            ob_end_flush();
            require_once('views/members/access.php');
        } else {
            header("Location: ?controller=pages&action=home");
        }
    }

    public function account() {
        if (isset($_SESSION['user']) && $_SESSION['user']->getAccessLevelID() < 4) {
            if ($_SESSION['user']->getAccessLevelID() == 1) {
                $posts = $_SESSION['user']->searchAll();
                $featuredPost1 = $_SESSION['user']->searchFeaturedPosts(1);
                $featuredPost2 = $_SESSION['user']->searchFeaturedPosts(2);
                $featuredPost3 = $_SESSION['user']->searchFeaturedPosts(3);
                require_once('views/members/account.php');
            } else {
                $posts = $_SESSION['user']->searchAuthor();
                require_once('views/members/account.php');
            }
            
        } else {
            header("Location: ?controller=pages&action=home");
        }
    }

}
