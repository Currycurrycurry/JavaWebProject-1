<%@ page import="bean.UserEntry" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的消息</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
    if(session.getAttribute("user")==null){
        System.out.println("请登录！");
        response.sendRedirect("/login.jsp");
    }

    if(request.getParameter("friend")==null){
        System.out.println("未选择好友");
        response.sendRedirect("/friendList.jsp");
    }

    if(request.getAttribute("error")!=null){
        System.out.println("不是好友！");
        response.sendRedirect("/friendList.jsp");
    }

    String friendID = request.getParameter("friend");
    UserEntry user = (UserEntry) session.getAttribute("user");
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

                        <%
                            if(user.isAdmin()){
                        %>
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
                        <%
                            }
                        %>
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
        <div class="col-2"></div>
        <div class="col-8">
            <form style="border: solid 3px darkgray">
                <h3 style="color: dodgerblue">聊天记录</h3>
                <div id="chat"  style="min-height:300px;max-height: 500px;overflow-x:hidden;overflow-y:auto">
                </div>
                <div class="container" style="border-top: solid darkgray 3px">
                    <div class="row">
                        <input class="col-8" type="text" id="mess" name ="mess">
                        <button type="button" id="bt1" value="<%=friendID%>" class="btn btn-secondary col-4 text-center">发送消息</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript">
    var ajax;

    function getAjax() {
        try {
            ajax = new XMLHttpRequest();
        } catch (e) {
            ajax = new ActiveXObject("Microsoft.XMLHTTP");
        }
        return ajax;
    }

    function jump() {
        ajax = getAjax();
        ajax.open("POST", "/message", true);
        ajax.onreadystatechange = function() {
            if (ajax.readyState == 4 && ajax.status == 200) {
                document.getElementById("mess").value ="";
            }
        };
        ajax.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var message = document.getElementById("mess").value;
        var friend = document.getElementById("bt1").value;
        var param = "friend="+friend+"&message=" + message;
        ajax.send(param);
    }

    var bt1 = document.getElementById("bt1");
    bt1.onclick = function(){
        jump();
    };

    $('#mess').bind('keypress',function (event) {
       if(event.keyCode==13){
           jump();
       }
    });

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


    /*局部自动刷新页面数据*/
    $(document).ready(function(){
        setTimeout('updateShow()',0);
    });

    function updateShow(){
        var ajax1 = getAjax();
        var friend = document.getElementById("bt1").value;
        var url = "/message?friend="+friend;

        ajax1.open("GET",url,true);
        ajax1.send();
        ajax1.onreadystatechange = function () {
            if (ajax1.readyState == 4 && ajax1.status == 200) {
                var result = ajax1.responseText;
                document.getElementById("chat").innerHTML = result;
                $('#content').scrollTop( $('#content')[0].scrollHeight);
            }
        };

        setTimeout('updateShow()',2000);
    }
</script>
</body>
</html>
