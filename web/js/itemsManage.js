
var btUpload = document.getElementById("btUpload");

btUpload.onclick = function () {
    var name = document.getElementById("uploadName");
    var address = document.getElementById("address");
    var year = document.getElementById("year");
    var description = document.getElementById("description");
    if(name.value == ""){
        document.getElementById("warnName").innerText = "展品名字不能为空!";
        name.focus();
        return;
    }else {
        document.getElementById("warnName").innerText = "";
    }
    if(address.value == ""){
        document.getElementById("warnAddress").innerText = "馆藏地点不能为空!";
        address.focus();
        return;
    }else {
        document.getElementById("warnAddress").innerText = "";
    }
    if(year.value == ""){
        document.getElementById("warnYear").innerText = "展品年代不能为空!";
        year.focus();
        return;
    }else {
        document.getElementById("warnYear").innerText = "";
    }
    if(description.value == ""){
        document.getElementById("warnDescription").innerText = "展品描述不能为空!";
        description.focus();
        return;
    }else {
        document.getElementById("warnDescription").innerText = "";
    }
    document.getElementById("uploadForm").submit();
};

var itemImageFile = document.getElementById("itemImageFile");
itemImageFile.onchange = function () {
    if(itemImageFile.files[0] != null){
        document.getElementById("itemImage").setAttribute("src",getPath(itemImageFile));
    }
};

var itemVideoFile = document.getElementById("itemVideoFile");
var itemVideo = document.getElementById("itemVideo");
itemVideoFile.onchange = function () {
    if(itemVideoFile.files[0] != null){
        itemVideo.setAttribute("style","width: 100%; height: auto; object-fit: fill;display: block");
        itemVideo.setAttribute("src",getPath(itemVideoFile));
    } else {
        itemVideo.setAttribute("style","width: 100%; height: auto; object-fit: fill;display: none");
    }
};


function getPath(node) {//获得文件的url
    var path = "";
    try{
        var file = null;
        if(node.files && node.files[0] ){
            file = node.files[0];
        }else if(node.files && node.files.item(0)) {
            file = node.files.item(0);
        }
        try{
            path =  file.getAsDataURL();
        }catch(e){
            path = window.URL.createObjectURL(file);
        }
    }catch(e){
        if (node.files && node.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                path = e.target.result;
            };
            reader.readAsDataURL(node.files[0]);
        }
    }
    return path;
}