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
                                // Taking now logged in time.
                $_SESSION['start'] = time();
                // Ending a session in 15 minutes from the starting time.
                $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
                echo "Hello " . $_SESSION['user']->getUserName() . ". Login Successful <br>" .
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

    public function register() {
        $register_username = $_POST['register_username'];
        $register_password = password_hash($_POST['register_password'], PASSWORD_DEFAULT);
        $email = $_POST ['email'];
        $req = $pdo->prepare("INSERT INTO member (userName,passwords,email) VALUES (?,?,?)");
        $req->execute([$register_username,$email,$register_password]);
        if ($count > 0) {
            $_SESSION['user'] = new Member($data['userName'], $data['passwords'], $data['email']);
            // Taking now logged in time.
            $_SESSION['start'] = time();
            // Ending a session in 15 minutes from the starting time.
            $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
echo "Hello " . $_SESSION['user']->getUserName() . ". Login Successful <br>" .
                "Redirecting to home page in 3 seconds."
                        . "<a href='?controller=pages&action=home'><div class='smalltext' href='?controller=pages&action=home'>(or click here to go now)</div></a>";
        } else {
            echo "Registration Unsuccessful";
        }
    }
}
    