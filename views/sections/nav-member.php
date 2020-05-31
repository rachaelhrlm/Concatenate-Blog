<div class="container-fluid customnav">
    <div class="container">
            <div class="col-md-2">
                <a href='?controller=pages&action=home'><img class="logo" src="views/images/standard/logo-inline.png"></a>
            </div>
            <div class="links">
                <ul class="nav ">
                    <li class="nav-item">
                        <a class="nav-link active" href='?controller=pages&action=home'> Home</a>
                    </li>
                    <li><i class="fas fa-circle navcircle "></i></li>
                    <li class="nav-item">
                        <a class="nav-link" href='?controller=post&action=searchAll'>Blogs</a>
                    </li>
                    <li><i class="fas fa-circle navcircle "></i></li>
                    <?php if (isset($_SESSION['user'])) { ?>
                        <li class="nav-item">
                            <a class="nav-link" href='?controller=member&action=account'>My Account</a> 
                        </li>
                        <li><i class="fas fa-circle navcircle "></i></li>
                        <li class="nav-item">
                            <a class="nav-link" href="?controller=member&action=logout">Log Out</a>
                        </li>
                    <?php } else {
                        ?>
                        <a class="nav-link" id="loginButton" href='?controller=member&action=loginForm'>Login </a><?php
                    }
                    ?>  
                </ul>
        </div>
    </div>
</div>