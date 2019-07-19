<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>请先登录吧</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<div id="nav-back">
    <div id="navitems-row">
        <div class="container">
            <div class="row">
                <div class="col-2">
                    <a href="index.jsp" class="nav-link text-dark"><span class="h3">Logo</span></a>
                </div>
                <div class="col-10 text-right">
                    <ul class="nav justify-content-end">
                        <li class="nav-item">
                            <a href="index.jsp" class="nav-link text-dark navitems">
                                <span class=""> 主页 </span></a>
                        </li>
                        <li class="nav-item">
                            <a href="signup.jsp" class="nav-link text-dark navitems">
                                <span class=""> 注册 </span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <br><br><br>
    <div class="container">
        <div class="row">
            <div class="col-8"></div>
            <div class="col-3">
                <form><input type="text" class="form-control" id="search-input" placeholder="想要找什么展品呢"></form>
            </div>
            <div class="col-1">
                <button class="btn btn-default" id="search-button">搜索</button>
            </div>
        </div>
    </div>
</div>
<br>
<div class="container">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-4">
            <form method="post" action="/login" id="form">
                <h3 class="text-center">登录</h3>
                <br>
                <div class="form-group">
                    <label for="account">帐号:</label>
                    <input type="text" class="form-control" id="account" name="account">
                </div>
                <div class="form-group">
                    <label for="password">密码:</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <div class="text-center">
                    <span id="tic"><%if(request.getAttribute("error")!=null) out.print((String)request.getAttribute("error"));%></span>
                    <br>
                    <input type="button" id="btLogin" class="btn btn-info" value="登录">
                </div>
            </form>
        </div>
        <div class="col-1"></div>
        <div class="col-4">
            <br><br><br><br><br><br>
            <p class="h4 text-center">还没有博物馆的帐号?还不赶紧来
                <a href="signup.jsp" class="nav-link text-muted">注册一个!</a></p>
        </div>

    </div>

</div>


<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>


<script type="text/javascript">
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    var btLogin = document.getElementById('btLogin');
    btLogin.onclick = function () {
        not_null();
    };

    function not_null() {
        var account = document.getElementById('account').value;
        var password = document.getElementById('password').value;
        if(account!=""&&password!=""){
            document.getElementById('tic').innerHTML="";
            var form = document.getElementById('form');
            form.submit();
        }else{
            document.getElementById('tic').innerHTML="信息不能为空!";
        }
    }
</script>
</body>
</html>
