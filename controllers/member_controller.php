  
<?php

class MemberController {

    public function login() {
        $security = Member::security();
        if (!isset($_SESSION['user'])) {
            if (isset($_POST['login'])) {
                $result = Member::login();
                header('Refresh:3, ?controller=pages&action=home');
                require_once('views/members/access.php');
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
            session_unset();
            session_destroy();
            $result = "Logout successful. Redirecting to home page in 3 seconds.<br>"
                    . "<a  href='?controller=pages&action=home'><div class='smalltext'>(or click here to go now)</a></div>";
            header('Refresh:3, ?controller=pages&action=home');
            require_once('views/members/access.php');
        } else {
            header("Location: ?controller=pages&action=home");
        }
    }

    public function account() {
        if (isset($_SESSION['user'])) {
            require_once('views/members/account.php');
        } else {
            header("Location: ?controller=pages&action=home");
        }
    }

}
