<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.Map" %>
<%@ page import="bean.Message" %>
<%--
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

    String friend =request.getParameter("friend");
    int friendID = Integer.parseInt(friend);

    if(request.getAttribute("messageLists")==null){
        request.getRequestDispatcher("/message").forward(request,response);
    }

    UserEntry user = (UserEntry) session.getAttribute("user");
    String userName = user.getName();
    String friendName =(String) request.getAttribute("friendName");
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
            <form class="form-control">
                <h3 style="color: dodgerblue">与<%=friendName%>的聊天记录</h3>
                <div style="min-height: 500px">
                    <%
                        List<Message> messageLists = (List<Message>) request.getAttribute("messageLists");
                        for(Message message:messageLists){
                            if( friendID == message.getUserID()){
                    %>
                    <div class="row">
                        <div class="col-6">
                            <label style="color: cornflowerblue"><%=friendName%>&emsp;&emsp;<%=message.getSendTime()%></label><br>
                            <label><%=message.getMess()%></label>
                        </div>
                        <div class="col-6"></div>
                    </div>
                    <%}else{%>
                    <div class="row">
                        <div class="col-6"></div>
                        <div class="col-6">
                            <label style="color: cornflowerblue"><%=userName%>&emsp;&emsp;<%=message.getSendTime()%></label><br>
                            <label><%=message.getMess()%></label>
                        </div>
                    </div>
                    <%}}%>
                </div>
                <div class="row">
                    <input class="input-group col-9" type="text" id="mess" name ="mess">
                    <button type="button" id="bt1" value="<%=friendID%>"
                            onclick="sendMess()" class="btn btn-secondary col-3 text-center">发送</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

<script type="text/javascript">
    function sendMess(){
        var s = document.getElementById("mess").value;
        var f = document.getElementById("bt1").value;
        location.href = "/message?friend="+f+"&message="+s;
    }

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
