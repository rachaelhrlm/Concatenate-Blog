<?php

class MemberController {

    public function login() {
        if (isset($_POST['login'])) {
            Member::login();
            require_once('views/members/access.php');
        } elseif (isset($_POST['register'])) {
            Member::register();
            require_once('views/members/access.php');
        } else {
            require_once('views/members/access.php');
        }
    }

    public function logout() {
            session_unset();
            session_destroy();
    }

}
