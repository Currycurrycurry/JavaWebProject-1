<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
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

    if(request.getAttribute("friendLists") == null||request.getAttribute("strangeLists")==null
            ||request.getAttribute("userLists")==null){
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
                                <li><a class="dropdown-item" href="Message.jsp">消    息</a></li>
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
                                <li><a class="dropdown-item" href="itemsManage.jsp">展品管理</a></li>
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
                <form>
                    <%if(request.getAttribute("searchName")!=null){%>
                    <input type="text" class="form-control" id="search-input"
                           value="<%=request.getAttribute("searchName")%>">
                    <%}else{%>
                    <input type="text" class="form-control" id="search-input"
                           placeholder="搜索用户名">
                    <%}%>
                </form>
            </div>
            <div class="col-1">
                <button class="btn btn-default" onclick="searchUser()" id="search-button">搜索</button>
            </div>
        </div>
    </div>
</div>

<br>
<div class="container">
    <div class="row">
        <div class="col-6" style="height: 700px;">
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
                            <div class="col-3 text-center"><button class="btn btn-secondary" href="#">前往主页</button></div>
                            <div class="col-3 text-center"><button class="btn btn-info" href="/Message.jsp?id=<%=friend.getId()%>">发送消息</button></div>
                            <div class="col-3 text-center">
                                <button class="btn btn-danger" onclick="deleteFriend(<%=friend.getId()%>)">删除好友</button>
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
            <div class="card-body" style="min-height: 300px;">
                <ul>
                    <li class="list-group-item" style="background-color:lightgray;">
                        <div class="row">
                            <div class="col-3 text-center">
                                搜索结果
                            </div>
                            <div class="col-9 text-center">
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
                            <div class="col-3 text-center"><%=entry.getKey().getName()%></div>
                            <div class="col-3 text-center"></div>
                            <div class="col-3 text-center"><button class="btn btn-secondary" href="#">前往主页</button></div>
                            <div class="col-3 text-center">
                                <%if(entry.getValue()==1){%>
                                <button class="btn" onclick="deleteFriend(<%=entry.getKey().getId()%>)">删除好友</button>
                                <%}else if(entry.getValue()==0){%>
                                <button class="btn">已申请</button>
                                <%}else{%>
                                <button class="btn btn-info" onclick="addUser(<%=entry.getKey().getId()%>)">添加好友</button>
                                <%}%>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <div class="card-body" style="min-height: 300px">
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
                            <div class="col-3 text-center"><button class="btn btn-secondary" href="#">前往主页</button></div>
                            <div class="col-3 text-center">
                                <button class="btn btn-info" onclick="agreeUser(<%=strange.getId()%>)">同意</button>
                            </div>
                            <div class="col-3 text-center">
                                <button class="btn btn-danger" onclick="rejectUser(<%=strange.getId()%>)">拒绝</button>
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

    //删除好友
    function deleteFriend(friendID) {
        location.href = "/friendList?deleteFriend_ID="+friendID;
    }

    //查找用户
    function searchUser(){
        var searchName = document.getElementById('search-input').value;
        location.href = "/friendList?searchName="+searchName;
    }

    //添加用户
    function addUser(userID) {
        location.href="/friendList?addUser_ID="+userID;
    }

    //拒绝
    function rejectUser(reject_ID){
        location.href = "/friendList?reject_ID="+reject_ID;
    }

    //同意
    function agreeUser(agree_ID){
        location.href = "/friendList?agree_ID="+agree_ID;
    }

    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });
</script>

</body>
</html>
