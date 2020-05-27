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

    public function confirmLogin() {
        $username = $this->getUserName();
        $password = $_POST['password'];
        $db = Db::getInstance();
        $req = $db->prepare("SELECT * FROM member WHERE userName =?");
        $req->execute([$username]);
        $data = $req->fetch(PDO::FETCH_ASSOC);
        if (isset($data)) {
            if (password_verify($password, $data['passwords'])) {
                return $data;
            }
        } else {
            return null;
        }
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
                ob_start();
                header("Refresh: 3; url=?controller=member&action=account");
                ?>
                <div class='alert alert-primary' role='alert'>
                    Login successful. Page will reload in 3 seconds, or close the alert to reload now.
                    <button type='button' class='close' data-dismiss='alert' onclick="location.href = '?controller=member&action=account'" aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
                ob_end_flush();
            } else {
                ?>
                <div class='alert alert-primary' role='alert'>
                    Password is incorrect.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div>
                <?php
            }
        } else {
            ?>
            <div class='alert alert-primary' role='alert'>
                Username does not exist.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
        }
    }

    public function searchID() {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT * FROM bio WHERE memberID = ?');
        $req->execute([$_SESSION['user']->getMemberID()]);
        $user = $req->fetch(PDO::FETCH_ASSOC);
        if (!empty($user)) {
            return $user;
        } else {
            return $user = NULL;
        }
    }

    public function searchAuthor() {
        $db = Db::getInstance();
        $id = intval($this->getMemberID());
        $req = $db->prepare('SELECT * FROM postinfo WHERE memberID = ? ORDER BY postID ASC');
        $req->execute([$id]);
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }

    public function searchAll() {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT * FROM postinfo ORDER BY postID ASC');
        $req->execute();
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }

    public function searchAllMembers() {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT * FROM member ORDER BY memberID ASC');
        $req->execute();
        return $req->fetchAll(PDO::FETCH_ASSOC);
    }

    public static function searchFeaturedPosts($id) {
        $db = Db::getInstance();
        $req = $db->prepare('SELECT postID FROM featuredPost WHERE featuredPostID=?');
        $req->execute([intval($id)]);
        return $req->fetch(PDO::FETCH_ASSOC);
    }

    public function updateEmail() {
        $db = Db::getInstance();
        if (isset($_POST['newemail']) && $_POST['newemail'] != "") {
            $filteredEmail = filter_input(INPUT_POST, 'newemail', FILTER_SANITIZE_EMAIL);
        }
        $this->setEmail($filteredEmail);
        $req = $db->prepare("UPDATE member SET email =? WHERE userName =?");
        $req->execute([$this->getEmail(), $this->getUserName()]);
    }
    public function updatePassword() {
        $db = Db::getInstance();
        if (isset($_POST['newpassword']) && $_POST['newpassword'] != "" && $_POST['newpassword'] === $_POST['confirmpassword']) {
            $newpassword = password_hash($_POST['newpassword'], PASSWORD_DEFAULT);
        }
        $this->setPasswords($newpassword);
        $req = $db->prepare("UPDATE member SET passwords =? WHERE userName =?");
        $req->execute([$newpassword, $this->getUserName()]);
    }

    public function updateName() {
        $db = Db::getInstance();
        if (isset($_GET['name']) && $_GET['name'] != "") {
            $filteredName = filter_input(INPUT_GET, 'name', FILTER_SANITIZE_SPECIAL_CHARS);
        }
        $name = $filteredName;
        $id = intval($_SESSION['user']->getMemberID());
        $req = $db->prepare('INSERT INTO bio (bioID, memberID, name) VALUE (?,?,?) ON DUPLICATE KEY UPDATE name = ?');
        $req->execute([$id, $id, $name, $name]);
    }

    public function updateAbout() {
        $db = Db::getInstance();
        if (isset($_GET['about']) && $_GET['about'] != "") {
            $filteredAbout = filter_input(INPUT_GET, 'about', FILTER_SANITIZE_SPECIAL_CHARS);
        }
        $about = $filteredAbout;
        $id = intval($_SESSION['user']->getMemberID());
        $req = $db->prepare('INSERT INTO bio (bioID, memberID, about) VALUE (?,?,?) ON DUPLICATE KEY UPDATE about = ?');
        $req->execute([$id, $id, $about, $about]);
    }

    public function promoteMember($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE member SET accessLevelID = 2 WHERE memberID = ?');
        $req->execute([$id]);
    }

    public function demoteMember($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE member SET accessLevelID = 3 WHERE memberID = ?');
        $req->execute([$id]);
    }
    public function banMember($id) {
        $db = Db::getInstance();
        $id = intval($id);
        $req = $db->prepare('UPDATE member SET accessLevelID = 4 WHERE memberID = ?');
        $req->execute([$id]);
    }

    const AllowedTypes = ['image/jpeg', 'image/jpg'];
    const InputKey = 'myUploader';

    public static function updateProfilePic() {
        $tempFile = $_FILES[self::InputKey]['tmp_name'];
        $path = "C:/xampp/htdocs/MVC/MVC-Skeleton/views/images/members/";
        $destinationFile = $path . $_SESSION['user']->getMemberID() . '.jpeg';
        move_uploaded_file($tempFile, $destinationFile);
        if (file_exists($tempFile)) {
            unlink($tempFile);
        }
    }

}
