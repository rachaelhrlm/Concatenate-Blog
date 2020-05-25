<!DOCTYPE html>
<?php 
require_once 'models/member.php';
session_start(); ?>
<html>
    <head>
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="theme-color" content="#ffffff">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--bootstrap stylesheet-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <!--fontawesome stylesheet: for icons-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <!--custom style sheet-->
        <link rel="stylesheet" href="views/css/styles.css">


        <title>Concatenate</title>
    </head>


    <body>
        <!--Logo Bar-->
        <div class="container-fluid logo">
            <div class="row justify-content-center">
                <img src="views/images/standard/logo.png" height="80px">
            </div>
        </div>

        <!--divider-->
        <hr>


        <!--Navbar Switch-->
        <?php
//        $_COOKIE['user'] = 'uncomment to test log in switch';
        if (isset($_SESSION['user'])) {
            require_once 'views/sections/nav-member.php';
        } else {
            require_once 'views/sections/nav-default.php';
//            require_once 'views/sections/nav-test.php';
        }
        ?>





        <!-- Modal -->
        <div class="modal fade" id="login" tabindex="-1" role="dialog" aria-labelledby="login" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="loginLabel">Login</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action = "?controller=member&action=login" method = "POST">
                            <div class="form-group row">
                                <label for="username"  class="col-sm-2 col-form-label" required>Username:</label>
                                <div class="col-md-10">
                                    <input type="text" name="login_username" class="form-control" id="username">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="password"  class="col-sm-2 col-form-label" required>Password:</label>
                                <div class="col-md-10">
                                    <input type="password" name="login_password"  class="form-control" id="password">
                                </div>
                            </div>
                            <input type="hidden" name='login' value="true">
                            <button type = 'submit' class="btn btn-primary" >Log In</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>









        <!--Content-->
        <?php require_once('routes.php'); ?>


        <!--divider-->
        <hr>


        <!--Footer-->
        <div class="container-fluid">
            <div class="row justify-content-around">
                <div class="col-md-3">
                    <ul>
                        <li><h5>Resources</h5></li>
                        <!--<li><hr></li>-->
                        <li>Example</li>
                        <li>Example</li>
                        <li>Example</li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <ul>
                        <li><h5>Contact</h5></li>
                        <!--<li><hr></li>-->
                        <li>Example</li>
                        <li>Example</li>
                        <li>Example</li>
                    </ul>
                </div>
                <div class="col-md-3"><ul>
                        <li><h5>Events</h5></li>
                        <!--<li><hr></li>-->
                        <li>Example</li>
                        <li>Example</li>
                        <li>Example</li>
                    </ul></div>
                <div class="col-md-3">
                    <ul>
                        <li><h5>Socials</h5></li>
                        <!--<li><hr></li>-->
                        <li><i class="fab fa-discord"></i></li>
                        <li><i class="fab fa-facebook"></i></li>
                        <li><i class="fab fa-github"></i></li>
                    </ul>
                </div>
            </div>
        </div>
        
        
        <hr>
        
        
        
        <div class="container-fluid">
            <div class="row justify-content-end align-content-middle">
                <div class="col-md-2">
                    <img src="views/images/standard/graphiclogo.png" width="30px">
                    <i class="far fa-copyright"></i> <?php echo date('Y') ?></div>

            </div>
        </div>

        <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
        <script src='https://cdn.tiny.cloud/1/tsm4jflxmwzdk9w9ws3pt5kefzwep82nt1bcq1rduh7w70lu/tinymce/5/tinymce.min.js' referrerpolicy="origin"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
        <script>
            tinymce.init({
                selector: '.textarea',
                plugins: 'a11ychecker advcode casechange formatpainter linkchecker autolink lists checklist media mediaembed pageembed permanentpen powerpaste table advtable tinycomments tinymcespellchecker',
                toolbar: 'a11ycheck addcomment showcomments casechange checklist code formatpainter pageembed permanentpen table',
                toolbar_mode: 'floating',
                tinycomments_mode: 'embedded',
                tinycomments_author: 'Author name',
            });
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            })



            document.querySelector('.custom-file-input').addEventListener('change', function (e) {
                var fileName = document.getElementById("image").files[0].name;
                var nextSibling = e.target.nextElementSibling
                nextSibling.innerText = fileName
//                $('#image').on('change', function() { $(this).attr('name', 'image') });
            })
        </script>
    </body>
</html>