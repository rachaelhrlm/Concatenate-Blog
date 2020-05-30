<div class="container-fluid customnav">
    <div class="container">
    <div class="row justify-content-between">
        <div class="col-md-2">
            <a href='?controller=pages&action=home'><img  class="logo" src="views/images/standard/logo-inline.png"></a>
        </div>
        <div class="links">
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link active" href='?controller=pages&action=home'> Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href='?controller=post&action=searchAll'>Blogs</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="loginButton" href='?controller=member&action=loginForm'">Login </a>
                </li>
            </ul>
        </div>
    </div>
    </div>
</div>

<script>
    function loginForm(div) {
        x = document.getElementById(div).style;
        if (x.display === 'none' || x.display === '') {
            x.display = 'flex';
        } else {
            x.display = 'none';
        }
    }


</script>