<script>
function searchPost(str) {
    let xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            document.querySelector(".results").innerHTML = this.responseText;
        }
    };
    xhr.open("GET", "views/scripts/searchAny.php?search=" + str, true);
    xhr.send();
} 
</script>
<div class="container">
<h1>Looking for something?</h1>
<label class="sr-only" for="inlineFormInputGroup">Search</label>
<div class="input-group">
    <div class="input-group-prepend">
        <div class="input-group-text"><i class="fas fa-search"></i></div>
    </div>
    <input type="text" class="form-control" id="inlineFormInputGroup" placeholder="search" onkeyup="searchPost(this.value)">
</div>
<p class="smalltext"><b>try:</b> motivational, career, lifestyle</p> 




<section>
    <div class="row justify-content- results">
    </div>
</section>

</div>
