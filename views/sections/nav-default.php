<div class="container-fluid customnav">
    <div class="row justify-content-center align-content-middle">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link active" href='?controller=pages&action=home'> Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href='?controller=post&action=searchAll'>Blogs</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" id="loginButton" onclick="loginForm('overall')">Login </a>
            </li>
        </ul>
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