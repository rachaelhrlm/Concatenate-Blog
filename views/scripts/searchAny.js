
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
