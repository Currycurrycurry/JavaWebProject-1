<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: AdminDD
  Date: 2019/7/22
  Time: 21:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查找用户</title>
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

    String searchName = "";
    if(request.getAttribute("searchName")!=null){
        searchName = (String)request.getAttribute("searchName");
    }

    System.out.println(searchName);

    if(request.getAttribute("userLists")==null||request.getAttribute("sameFriendLists")==null){
        request.getRequestDispatcher("/searchUser?searchName="+searchName).forward(request,response);
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
                        <%
                            if(session.getAttribute("user")!=null){
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
                                <li><a class="dropdown-item" href="collection.jsp">我的收藏</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/LoginOutServlet">登    出</a></li>
                            </ul>
                        </li>
                        <%  UserEntry userEntry = (UserEntry)session.getAttribute("user");
                            if(userEntry.isAdmin()){%>
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
                        <%}}%>
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
        <input type="text" class="form-control col-4" placeholder="输入关键词查找" id = "searchUser" name="searchName" value="<%=searchName%>">
        <button type="button" class="btn btn-secondary col-1" id ="search">搜索</button>
    </div>
    <br>
    <div class="row">
        <h3>搜索结果:</h3>
    </div>
    <br>
    <div class="row">
        <div class="col-12 card-body" style="min-height: 400px">
            <ul class="list-group">
                <li class="list-group-item" style="background-color:lightskyblue;">
                    <div class="row">
                        <div class="col-2 text-center">
                            用户账号
                        </div>
                        <div class="col-2 text-center">
                            用户昵称
                        </div>
                        <div class="col-4 text-center">
                            个性签名
                        </div>
                        <div class="col-4 text-center">
                            操作
                        </div>
                    </div>
                </li>
                <%
                    HashMap<UserEntry,Integer> userLists = (HashMap<UserEntry, Integer>) request.getAttribute("userLists");
                    for(Map.Entry<UserEntry, Integer> entry:userLists.entrySet()){
                %>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-2 text-center">
                            <a class="btn" href="friendInformation.jsp?friendId=<%=entry.getKey().getId()%>">
                                <%=entry.getKey().getAccount()%></a>
                        </div>
                        <div class="col-2 text-center">
                            <a class="btn" href="friendInformation.jsp?friendId=<%=entry.getKey().getId()%>">
                            <%=entry.getKey().getName()%></a>
                        </div>
                        <div class="col-4 text-center"><%=entry.getKey().getSignature()%></div>
                        <%if(entry.getValue()==0){%>
                        <div class="col-2 text-center">
                            <a class="btn btn-info" href="message.jsp?friend=<%=entry.getKey().getId()%>">发送消息</a>
                        </div>
                        <div class="col-2 text-center">
                            <form action="/searchUser" method="post">
                                <input value="<%=entry.getKey().getId()%>" name = "deleteFriendID" hidden>
                                <button type="submit" class="btn btn-danger">删除好友</button>
                            </form>
                        </div>
                        <%}else if(entry.getValue()==1){%>
                        <div class="col-4 text-center">
                            <a class="btn">已申请</a>
                        </div>
                        <%}else if(entry.getValue()==2){%>
                        <div class="col-2 text-center">
                            <form action="/searchUser" method="post">
                                <input value="<%=entry.getKey().getId()%>" name = "agreeID" hidden>
                                <button type="submit" class="btn btn-info">接受请求</button>
                            </form>
                        </div>
                        <div class="col-2 text-center">
                            <form action="/searchUser" method="post">
                                <input value="<%=entry.getKey().getId()%>" name = "rejectID" hidden>
                                <button type="submit" class="btn btn-info">拒绝请求</button>
                            </form>
                        </div>
                        <%}else{%>
                        <div class="col-2"></div>
                        <div class="col-2 text-center">
                            <form action="/searchUser" method="post">
                                <input value="<%=entry.getKey().getId()%>" name="addUserID" hidden>
                                <button type="submit" class="btn btn-info">申请好友</button>
                            </form>
                        </div>
                        <%}%>
                    </div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>


    <div class="row">
        <div class="col-12 card-body" style="min-height: 400px;">
            <ul class="list-group">
                <li class="list-group-item" style="background-color:lightskyblue;">
                    <div class="row">
                        <div class="col-2 text-center">
                            推荐好友
                        </div>
                        <div class="col-6"></div>
                        <div class="col-4 text-center">
                            操作
                        </div>
                    </div>
                </li>
                <%
                    HashMap<UserEntry,Integer> sameFriendLists = (HashMap<UserEntry,Integer>) request.getAttribute("sameFriendLists");
                    for(Map.Entry<UserEntry, Integer> sameFriend:sameFriendLists.entrySet()){
                %>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-2 text-center">
                            <a class="btn" href="friendInformation.jsp?friendId=<%=sameFriend.getKey().getId()%>">
                                <%=sameFriend.getKey().getName()%></a></div>
                        <%
                            if(sameFriend.getValue()==0){
                        %>
                        <div class="col-6 text-center">来自随机推荐</div>
                        <%}else{%>
                        <div class="col-6 text-center">你们有<%=sameFriend.getValue()%>个共同的好友</div>
                        <%}%>
                        <div class="col-4 text-center">
                            <form action="/searchUser" method="post">
                                <input value="<%=sameFriend.getKey().getId()%>" name="addUserID" hidden>
                                <button class="btn btn-info" type="submit">申请好友</button>
                            </form>
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


    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    var btSearch = document.getElementById("search-button");
    btSearch.onclick = function () {
        var keyword = document.getElementById("search-input").value;
        var form =  document.getElementById("search-form");
        form.submit();
    }
</script>

</body>
</html>
