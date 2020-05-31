<nav class="navbar navbar-default navbar-expand-sm customnav ">
    <div class="container ">
    <div class="navbar-header ">
        <a class="navbar-brand" href='?controller=pages&action=home'><img class="logo" src="views/images/standard/logo-inline.png"></a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <i class="fas fa-bars"></i>
        </button>
    </div>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class=" nav navbar-nav navbar-right ml-auto">
            <li><a class="nav-link" href='?controller=pages&action=home'> Home</a></li>
            <li><i class="fas fa-circle navcircle "></i><a  class="nav-link" href='?controller=post&action=searchAll'>Blogs</a></li>

            <?php if (isset($_SESSION['user'])) { ?>
                <li>
                    <i class="fas fa-circle navcircle "></i><a class="nav-link" href='?controller=member&action=account'>My Account</a> 
                </li>
                <li>
                    <i class="fas fa-circle navcircle "></i><a class="nav-link" href="?controller=member&action=logout">Log Out</a>
                </li>
            <?php } else {
                ?>
                <li><i class="fas fa-circle navcircle "></i>
                    <a class="nav-link" href='?controller=member&action=loginForm'>Login </a></li><?php
                }
                ?>  
        </ul>
    </div>
    </div>
</nav>