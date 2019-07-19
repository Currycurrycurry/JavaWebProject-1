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
    <script type="text/javascript">
        function sub() {
            var sub = document.getElementById('sub');
            sub.removeAttribute("hidden");
        }
    </script>
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
        request.getRequestDispatcher("signup.jsp").forward(request,response);
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
                                <li><a class="dropdown-item" href="Message.jsp">消    息</a></li>
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
                                <li><a class="dropdown-item" href="itemsManage.jsp">展品管理</a></li>
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
        <div class="col-4" style="background-color:lavender;">
            <br>
            <form class="container" action="" type="post">
                <div class="form-group">
                    <label>账号:</label> ${user.account}
                </div>
                <div class="form-group">
                    <label>昵称:</label>
                    <input type="text" class="form-control" value="${user.name}">
                </div>
                <div>
                    <label>个性签名:</label>
                    <textarea type="textarea" class="form-control" rows="3">${user.signature}</textarea>
                </div>
                <div class="form-group">
                    <label>邮箱:</label>
                    <input type="text" class="form-control" value="${user.email}">
                </div>
                <div class="form-group">
                    <button type="button" onclick="sub()" class="btn btn-dark">修改信息</button>
                </div>
                <div hidden class="form-group" id="sub">
                    <label>请输入密码:</label>
                    <input type="password" name = "password">
                    <button type="submit" href="#" class="btn btn-dark">提交</button>
                </div>
            </form>
        </div>

    </div>
</div>


<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script>/*下拉菜单*/
$(document).ready(function(){
    $(document).off('click.bs.dropdown.data-api');
});</script>
</body>
</html>
