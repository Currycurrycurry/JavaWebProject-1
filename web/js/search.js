
var btNext = document.getElementById("btNext");
var btPrevious = document.getElementById("btPrevious");
var btJump = document.getElementById("btJump");



function changePage(page) {
    var nowPage = document.getElementById("nowPage").innerText;
    var totalPage = document.getElementById("totalPage").innerText;

    $.ajax({
        "url":"/search",
        "type":"POST",
        "data":{
            "keyword":document.getElementById("search-input").value,
            "page": page
        },
        "success":function (res) {
            var showResult = document.getElementById("showResult");
            showResult.innerHTML = res;
            document.getElementById("nowPage").innerText = page;
        },
        "error":function (e) {
            alert(e);
        }
    })
}

btJump.onclick = function () {
    var r = /^\+?[1-9][0-9]*$/;
    var nowPage = (document.getElementById("nowPage").innerText);
    var totalPage = (document.getElementById("totalPage").innerText);
    var jumpPage = document.getElementById("pageInput").value;
    if(r.test(jumpPage) && jumpPage<= totalPage && jumpPage !== nowPage){
        changePage(jumpPage);
    }
};

btNext.onclick = function () {
    var nowPage = document.getElementById("nowPage").innerText;
    var totalPage = document.getElementById("totalPage").innerText;
    if(totalPage > nowPage){
        changePage(parseInt(nowPage)+1);
    }
};

btPrevious.onclick = function () {
    var nowPage = document.getElementById("nowPage").innerText;
    var totalPage = document.getElementById("totalPage").innerText;
    if(nowPage > 1){
        changePage(parseInt(nowPage)-1);
    }
};