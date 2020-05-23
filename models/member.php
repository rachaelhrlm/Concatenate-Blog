<?php

class Member {

//    attributes
    private $memberID;
    private $userName;
    private $passwords;
    private $email;
    private $accessLevelID;

//    constructor
    public function __construct($memberID, $userName, $passwords, $email, $accessLevelID) {
        $this->memberID = $memberID;
        $this->userName = $userName;
        $this->passwords = $passwords;
        $this->email = $email;
        $this->accessLevelID = $accessLevelID;
    }

//    getters
    public function getMemberID() {
        return $this->memberID;
    }

    public function getUserName() {
        return $this->userName;
    }

    public function getPasswords() {
        return $this->passwords;
    }

    public function getEmail() {
        return $this->email;
    }

    public function getAccessLevelID() {
        return $this->accessLevelID;
    }

    //    setters
    public function setMemberID($memberID) {
        $this->memberID = $memberID;
    }

    public function setUserName($userName) {
        $this->userName = $userName;
    }

    public function setPasswords($passwords) {
        $this->passwords = $passwords;
    }

    public function setEmail($email) {
        $this->email = $email;
    }

    public function setAccessLevelID($accessLevelID) {
        $this->accessLevelID = $accessLevelID;
    }

    public function login() {
        $login_username = $_POST['login_username'];
        $login_password = $_POST['login_password'];
        $db = Db::getInstance();
        $req = $db->prepare("SELECT * FROM member WHERE userName =?");
        $req->execute([$login_username]);
        $data = $req->fetch(PDO::FETCH_ASSOC);
        if (isset($data)) {
            if (password_verify($login_password, $data['passwords'])) {
                $_SESSION['user'] = new Member($data['memberID'], $data['userName'], $data['passwords'], $data['email'], $data['accessLevelID']);
                echo "Hello " . $_SESSION['user']->getUserName() . ". Login Successful <br>".
                        "Redirecting to home page in 3 seconds."
                    . "<a href='?controller=pages&action=home'><div class='smalltext' href='?controller=pages&action=home'>(or click here to go now)</div></a>";
            } else {
                echo "Password is incorrect. Redirecting to home page in 3 seconds."
                    . "<a href='?controller=pages&action=home'><div class='smalltext' href='?controller=pages&action=home'>(or click here to go now)</div></a>";
            }
        } else {
            echo "Username does not exist."
            . "<a href='?controller=pages&action=home'><div class='smalltext'>(or click here to go now)</div></a>";
        }
    }
    
    public function searchID() {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT * FROM bio WHERE memberID = ?');
        $req->execute([$_SESSION['user']->getMemberID()]);
        $post = $req->fetch(PDO::FETCH_ASSOC);
        if (!empty($post)) {
            return $post;
        } else {
            return $post = NULL;
        }
    
    }

}
