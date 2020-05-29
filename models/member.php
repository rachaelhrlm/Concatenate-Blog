<?php

class Member {

//    attributes
    private $memberID;
    private $userName;
//    private $passwords;
    private $email;
    private $accessLevelID;

//    constructor
    public function __construct($memberID, $userName, $email, $accessLevelID) {
        $this->memberID = $memberID;
        $this->userName = $userName;
//        $this->passwords = $passwords;
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

//    public function getPasswords() {
//        return $this->passwords;
//    }

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

//    public function setPasswords($passwords) {
//        $this->passwords = $passwords;
//    }

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
                $_SESSION['user'] = new Member($data['memberID'], $data['userName'], $data['email'], $data['accessLevelID']);
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

//    method for getting all security questions.
    public static function security() {
        $db = Db::getInstance();
        $req = $db->prepare("SELECT * FROM securityquestions");
        $req->execute();
        $count = $req->rowCount();
        return $security = $req->fetchAll(PDO::FETCH_ASSOC);
    }

    public function register() {
        if (isset($_POST['confirm'])) {
            if ($_POST['password'] != $_POST['confirm_password']) {
                echo "Passwords do not match. Please try it again.";
            } else {
                $register_username = $_POST['login_username'];
                $register_password = password_hash($_POST['login_password'], PASSWORD_DEFAULT);
                $register_email = $_POST ['login_email'];
                $req = $db->prepare("INSERT INTO member (email, userName,passwords) VALUES (?,?,?)");
                $req->execute([$register_email, $register_username, $register_password]);
                $id = intval($db->lastInsertId());
                $count = $req->rowCount();
                if ($count > 0) {
                    $securityid = intval($_POST['securityID']);
                    $securityanswer = $_POST['securityanswer'];
                    $req2 = $db->prepare("INSERT INTO security (memberID, securityID, securityanswer) VALUES (?, ?, ?)");
                    $req2->execute([$id, $securityid, $securityanswer]);
                    $data = array("memberID" => $id, "userName" => $register_username, "email" => $register_email, "acccessLevelID" => 3);
                    $_SESSION['user'] = new Member($data['memberID'], $data['userName'], $data['email'], $data['accessLevelID']);
                    $_SESSION['start'] = time();
                    $_SESSION['expire'] = $_SESSION['start'] + (15 * 60);
                    header("location: dashboard.php");
                    echo "Hello " . $_SESSION["username"] . ". Registration Successful";
                } else {
                    echo "Registration Unsuccessful";
                }
            }
        } else {
            echo "whaaaaaaaaaaaaaaaaaaaaaaaaaaaat?";
        }
    }

}
