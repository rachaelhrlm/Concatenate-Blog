<?php
require_once 'models/exceptions.php';

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

    public static function subscribe($email) {
        $db = Db::getInstance();
        $req = $db->prepare("SELECT email FROM subscriber WHERE email= ?");
        $req->execute([$email]);
        $data = $req->fetch(PDO::FETCH_ASSOC);
        if (isset($data['email'])) {
            ?>
            <div class='alert alert-primary' role='alert'>
                Email address is already subscribed.
                <button type='button' class='close' data-dismiss='alert'aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
        <?php
        } else {
            $db = Db::getInstance();
            $req = $db->prepare("INSERT INTO subscriber(email) VALUES (?)");
            $req->execute([$email]);
            ?>
            <div class='alert alert-primary' role='alert'>
                Email successfully subscribed.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div> 
            <?php
        }
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

    public static function login() {
        $login_username = $_POST['userName'];
        $login_password = $_POST['password'];
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

    public static function register() {
        $db = Db::getInstance();
        $username = $_POST['userName'];
        $req = $db->prepare("SELECT userName FROM member WHERE userName = ?");
        $req->execute([$username]);
        $count = $req->rowCount();
        if ($count > 0) {
            ?>
            <div class='alert alert-primary' role='alert'>
                Username already in use, please chose another one.
                <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                    <span aria-hidden='true'>&times;</span>
                </button>
            </div>
            <?php
        } else {
            if ($_POST['password'] != $_POST['confirmPassword']) {
                ?>
                <div class='alert alert-primary' role='alert'>
                    Passwords do not match. Please try it again.
                    <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                        <span aria-hidden='true'>&times;</span>
                    </button>
                </div> <?php
            } else {
                $uppercase = preg_match('@[A-Z]@', $_POST['password']);
                $lowercase = preg_match('@[a-z]@', $_POST['password']);
                $number = preg_match('@[0-9]@', $_POST['password']);
                $specialChars = preg_match('@[^\w]@', $_POST['password']);
                if (!$uppercase || !$lowercase || !$number || !$specialChars || strlen($_POST['password']) < 8) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        Password should be at least 8 characters in length and should include at least one upper case letter, one number, and one special character.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button> 




                        <?php
                    } else {
                        $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
                        $email = $_POST ['email'];
                        $stmt = $db->prepare("INSERT INTO member (email, userName,passwords) VALUES (? ,?,?)");
                        $stmt->execute([$email, $username, $password]);
                        $id = $db->lastInsertId();
                        $count = $stmt->rowCount();
                        if ($count > 0) {
                            $securityid = intval($_POST['securityID']);
                            $securityanswer = $_POST['securityAnswer'];
                            $req2 = $db->prepare("INSERT INTO security (memberID, securityID, securityanswer) VALUES (?, ?, ?)");
                            $req2->execute([intval($id), $securityid, $securityanswer]);
                            $req2 = $db->prepare("INSERT INTO bio (bioID, memberID, name) VALUES (?, ?, ?)");
                            $req2->execute([intval($id), intval($id), $username]);
                            self::login();
                        }
                    }
                }
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

        public function searchFavourites() {
            $db = Db::getInstance();
            $id = intval($this->getMemberID());
            $req = $db->prepare('SELECT * FROM favourite WHERE memberID = ? ');
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

        public function fav($id) {
            $db = Db::getInstance();
            $user = $this->getMemberID();
            $id = intval($id);
            $req = $db->prepare('call addFavourite(?,?)');
            $req->execute([$user, $id]);
        }

        public function unfav($id) {
            $db = Db::getInstance();
            $user = $this->getMemberID();
            $id = intval($id);
            $req = $db->prepare('DELETE FROM favourite WHERE memberID = ? AND postID = ?;');
            $req->execute([$user, $id]);
        }

        public static function security() {
            $db = Db::getInstance();
            $req = $db->prepare("SELECT * FROM securityquestions");
            $req->execute();
            return $req->fetchall();
        }

        const AllowedTypes = ['image/jpeg', 'image/jpg'];
        const InputKey = 'myUploader';

        public static function updateProfilePic() {

            if (!empty($_FILES[self::InputKey]['name'])) {
                try {
                    list($width, $height, $type, $attr) = getimagesize($_FILES[self::InputKey]['tmp_name']);
                    if (empty($_FILES[self::InputKey])) {
                        throw new NoFileException();
                    } else if (!in_array($_FILES[self::InputKey]['type'], self::AllowedTypes)) {
                        throw new WrongFileTypeException();
                    } else if ($_FILES[self::InputKey]['error'] > 0) {
                        throw new Exception();
                    } else {
                        $tempFile = $_FILES[self::InputKey]['tmp_name'];
                        $path = "C:/xampp/htdocs/MVC/MVC-Skeleton/views/images/members/";
                        $destinationFile = $path . $_SESSION['user']->getMemberID() . '.jpeg';
                        move_uploaded_file($tempFile, $destinationFile);
                        if (file_exists($tempFile)) {
                            unlink($tempFile);
                        }
                        ?>
                        <div class='alert alert-primary' role='alert'>
                            Profile Picture successfully updated.
                            <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                                <span aria-hidden='true'>&times;</span>
                            </button>
                        </div> <?php
                    }
                } catch (NoFileException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        File missing! Please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                    <?php
                } catch (WrongFileTypeException $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        You cannot upload this file type <?php echo $_FILES[self::InputKey]['type'] ?>, please try again.
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div>
                <?php } catch (Exception $ex) {
                    ?>
                    <div class='alert alert-primary' role='alert'>
                        oops something went wrong
                        <button type='button' class='close' data-dismiss='alert' aria-label='Close'>
                            <span aria-hidden='true'>&times;</span>
                        </button>
                    </div><?php
                }
            }
        }

    }
    