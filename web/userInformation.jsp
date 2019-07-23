<%@ page import="bean.UserEntry" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的信息</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
    Object o = session.getAttribute("user");
    UserEntry user = null;
    boolean isAdmin = false;
    if(o!=null){
        user = (UserEntry)o;
        isAdmin = user.isAdmin();
    }

    // 未登录！
    if(user==null){
        response.sendRedirect("/login.jsp");
    }
%>
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
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link text-dark navitems dropdown-toggle" data-toggle="dropdown">
                                <span class="">${user.name}</span></a>
                            <b class="caret"></b>
                            <ul class="dropdown-menu text-center">
                                <li><a class="dropdown-item" href="userInformation.jsp">个人信息</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="friendList.jsp">好友列表</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="collection.jsp">我的收藏</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/LoginOutServlet">登    出</a></li>
                            </ul>
                        </li>

                        <%if(isAdmin){%>
                        <li class="nav-item dropdown">
                            <a href="" class="nav-link text-dark navitems dropdown-toggle" data-toggle="dropdown">
                                <span class=""> 管    理 </span></a>
                            <b class="caret"></b>
                            <ul class="dropdown-menu text-center">
                                <li><a class="dropdown-item" href="userManage.jsp">用户管理</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="uploadItem.jsp">上传展品</a></li>
                            </ul>
                        </li>
                        <%}%>
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
                <form method="get" id="search-form" action="/search">
                    <input type="text" class="form-control" id="search-input" placeholder="想要找什么展品呢" name="keyword">
                </form>
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
        <div class="col-4" style="background-color:lavender;">
            <br>
            <form class="container" action="/UserInfo" id="form" method="post">
                <div class="form-group">
                    <label>账号:</label> ${user.account}
                </div>
                <div class="form-group">
                    <label>昵称:</label>
                    <input type="text" class="form-control" name="name" id="name" value="${user.name}">
                </div>
                <div>
                    <label>个性签名:</label>
                    <textarea type="textarea" class="form-control" name="textarea" id="signature" rows="3">${user.signature}</textarea>
                </div>
                <div class="form-group">
                    <label>邮箱:</label>
                    <input type="text" class="form-control" id="email" name="email" value="${user.email}">
                </div>
                <div class="form-group">
                    <label>请输入密码进行修改:</label>
                    <input type="password" name = "password" id="password">
                </div>
                <div class="form-group">
                    <input type="button" id="btSub" class="btn btn-dark" value="修改信息">
                </div>
                <div class="form-group">
                    <span id="tip"></span>
                </div>
            </form>
        </div>

    </div>
</div>


<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">

    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    var btSearch = document.getElementById("search-button");
    btSearch.onclick = function () {
        var keyword = document.getElementById("search-input").value;
        var form =  document.getElementById("search-form");
        form.submit();
    };

    var btSub = document.getElementById('btSub');
    btSub.onclick = function (){
        sub();
    };

    function sub() {
        if(name()&&email()&&password()){
            var form = document.getElementById('form');
            form.submit();
        }
    }

    function email(){
        var t = document.getElementById('email').value;
        var pattern = /^[0-9a-zA-Z_]{2,18}@[0-9a-z]+.com$/;
        if(pattern.test(t)){
            document.getElementById('tip').innerHTML="";
            return true;
        }
        else{
            document.getElementById('tip').innerHTML="x(2-18位)@x.com";
            return false;
        }
    }

    function name() {
        var name= document.getElementById('name').value;
        if(name==""){
            document.getElementById('tip').innerHTML="昵称不能为空!";
            return false;
        }else{
            document.getElementById('tip').innerHTML="";
            return true;
        }
    }

    function password() {
        var password = document.getElementById('password').value;
        if(password==""){
            document.getElementById('tip').innerHTML = "密码不能为空";
            return false;
        }else{
            document.getElementById('tip').innerHTML = "";
            return true;
        }
    }

</script>
</body>
</html>
