<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>好友列表</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
    if (session.getAttribute("user")==null){
        response.sendRedirect("/index.jsp");
    }

    if(request.getAttribute("friendLists") == null||request.getAttribute("strangeLists")==null){
        request.getRequestDispatcher("/friendList").forward(request,response);
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

                        <%
                            UserEntry userEntry = (UserEntry)session.getAttribute("user");
                            if(userEntry.isAdmin()){
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
                        </li><%}%>
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
        <input type="text" class="form-control col-4" placeholder="输入关键词查找" id = "searchUser" name="searchName">
        <button type="button" class="btn btn-secondary col-1" id ="search">搜索</button>
    </div>
    <br>

    <div class="row">
        <div class="col-6" style="min-height: 700px;">
            <div class="card-body">
                <ul class="list-group">
                    <li class="list-group-item" style="background-color:#b3d7ff;">
                        <div class="row">
                            <div class="col-3 text-center">
                                好友
                            </div>
                            <div class="col-9 text-center">
                                操作
                            </div>
                        </div>
                    </li>
                    <%
                        List<UserEntry> friendLists = (List<UserEntry>) request.getAttribute("friendLists");
                        for(UserEntry friend:friendLists){
                    %>
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-3 text-center"><%=friend.getName()%></div>
                            <div class="col-3 text-center"><a class="btn btn-secondary" href="friendInformation.jsp?friendId=<%=friend.getId()%>">前往主页</a></div>
                            <div class="col-3 text-center"><a class="btn btn-info" href="message.jsp?friend=<%=friend.getId()%>">发送消息</a></div>
                            <div class="col-3 text-center">
                                <a class="btn btn-danger" href="friendList?deleteFriend_ID=<%=friend.getId()%>">删除好友</a>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
        <div class="col-6">
            <div class="card-body" style="min-height: 700px">
                <ul>
                    <li class="list-group-item" style="background-color:grey;">
                        <div class="row">
                            <div class="col-3 text-center">
                                陌生人请求
                            </div>
                            <div class="col-9 text-center">
                                操作
                            </div>
                        </div>
                    </li>
                    <%
                        List<UserEntry> strangeLists = (List<UserEntry>) request.getAttribute("strangeLists");
                        for(UserEntry strange:strangeLists){
                    %>
                    <li class="list-group-item">
                        <div class="row">
                            <div class="col-3 text-center"><%=strange.getName()%></div>
                            <div class="col-3 text-center"><a class="btn btn-secondary" href="friendInformation.jsp?friendId=<%=strange.getId()%>">前往主页</a></div>
                            <div class="col-3 text-center">
                                <a class="btn btn-info" href="friendList?agree_ID=<%=strange.getId()%>">同意</a>
                            </div>
                            <div class="col-3 text-center">
                                <a class="btn btn-danger" href="friendList?reject_ID=<%=strange.getId()%>">拒绝</a>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">

    //查找用户
    function searchUser(){
        var searchName = document.getElementById('searchUser').value;
        location.href = "/searchUser?searchName="+searchName;
    }

    var search = document.getElementById("search");
    search.onclick=function () {
        searchUser();
    };

    var btSearch = document.getElementById("search-button");
    btSearch.onclick = function () {
        var keyword = document.getElementById("search-input").value;
        var form =  document.getElementById("search-form");
        form.submit();
    }

    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });
</script>

</body>
</html>
