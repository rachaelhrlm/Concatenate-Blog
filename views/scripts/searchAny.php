<?php
require_once 'C:\\xampp\\htdocs\\MVC\\MVC-Skeleton\\models\\post.php';
require_once 'C:\\xampp\\htdocs\\MVC\\MVC-Skeleton\\connection.php';
if (isset($_GET['search'])) {
Post::searchAny($_GET['search']);
}
    
