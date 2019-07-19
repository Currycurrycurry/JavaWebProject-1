<%@ page import="bean.UserEntry" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>展品详情</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<%
    if(request.getAttribute("item") == null){
        request.getRequestDispatcher("/detail").forward(request,response);
    }
%>
<body>
<%
    UserEntry user = (UserEntry)session.getAttribute("user");
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
                        <%
                            if(user!=null){
                        %>
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
                                <li><a class="dropdown-item" href="#">登    出</a></li>
                            </ul>
                        </li>
                        <%
                            }else{
                        %>
                        <li class="nav-item">
                            <a href="signup.jsp" class="nav-link text-dark navitems">
                                <span class=""> 注册 </span></a>
                        </li>
                        <li class="nav-item">
                            <a href="login.jsp" class="nav-link text-dark navitems">
                                <span class=""> 登录 </span></a>
                        </li>
                        <%
                            }
                            if(user!=null&&user.isAdmin()){
                        %>
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
        <div class="col-6">
            <p class="h3">${requestScope.item.name}</p>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <div class="card">
                <img class="card-img" src="${requestScope.item.imagePath}">
            </div>
        </div>
        <div class="col-6">
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover" style="table-layout:fixed;">
                        <thead>
                        <tr>
                            <th class="text-center h4" colspan="3">展品详情</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="font-weight-bold">名称</td>
                            <td colspan="2">${requestScope.item.name}</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">馆藏地点</td>
                            <td colspan="2">${requestScope.item.address}</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">年份</td>
                            <td colspan="2">${requestScope.item.year}</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">热度</td>
                            <td colspan="2">${requestScope.item.view}</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">简介</td>
                            <td colspan="2">${requestScope.item.description}</td>
                        </tr>
                        </tbody>
                    </table>
                    <br>
                    <%
                        if(request.getAttribute("isCollected") != null &&
                                (boolean)request.getAttribute("isCollected")){
                            %>
                    <form class="text-right" method="post" action="/collect">
                        <input name="itemId" value="${requestScope.item.itemId}" class="disabled text-hide">
                        <button type="submit" class="btn btn-info">取消收藏</button>
                    </form>
                    <%
                        }else {
                            %>
                    <form class="text-right" method="post" action="/collect">
                        <input name="itemId" value="${requestScope.item.itemId}" class="disabled text-hide">
                        <button type="submit" class="btn btn-info">收    藏</button>
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
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
