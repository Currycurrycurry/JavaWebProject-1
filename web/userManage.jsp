<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="servlet.UserInfoServlet" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>

<%

    Object object = session.getAttribute("user");
    if(object==null){
        response.sendRedirect("/login.jsp");
    }else{
        UserEntry userEntry = (UserEntry) object;
        if(!userEntry.isAdmin()){
            response.sendRedirect("/index.jsp");
        }
    }

    if(request.getAttribute("userManage") == null){
        request.getRequestDispatcher("/userManage").forward(request,response);
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
                                <li><a class="dropdown-item" href="message.jsp">消    息</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="collection.jsp">我的收藏</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/LoginOutServlet">登    出</a></li>
                            </ul>
                        </li>
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
    <div>
        <ul class="list-group">
            <li class="list-group-item" style="background-color:lavender;">
                <div class="row">
                    <div class="col-1 text-center">
                        账号
                    </div>
                    <div class="col-2 text-center">
                        名字
                    </div>
                    <div class="col-2 text-center">
                        邮箱
                    </div>
                    <div class="col-3 text-center">
                        最近登录时间
                    </div>
                    <div class="col-4 text-center">
                        操作
                    </div>
                </div>
            </li>
            <%
                List<UserEntry> userEntries = (List<UserEntry>) request.getAttribute("userManage");
                for(UserEntry userEntry:userEntries){
            %>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-1 text-center">
                        <%=userEntry.getAccount()%>
                    </div>
                    <div class="col-2 text-center">
                        <%=userEntry.getName()%>
                    </div>
                    <div class="col-2 text-center">
                        <%=userEntry.getEmail()%>
                    </div>
                    <div class="col-3 text-center">
                        <%=userEntry.getLoginTime()%>
                    </div>
                    <div class="col-2 text-center">
                        <% if(!userEntry.isAdmin()){ %>
                        <button class="btn btn-info" id="<%=userEntry.getId()%>"
                                value="true" onclick="changePower(<%=userEntry.getId()%>)">提升管理员</button>
                        <%}else{%>
                        <button class="btn btn-danger" id="<%=userEntry.getId()%>"
                                value="false" onclick="changePower(<%=userEntry.getId()%>)">降级为普通</button>
                        <%}%>
                    </div>
                    <div class="col-2 text-center">
                        <button class="btn btn-secondary" onclick="deleteAccount(<%=userEntry.getId()%>)">
                            删除用户
                        </button>
                    </div>
                </div>
            </li>
            <%
                }
            %>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-8"></div>
                    <div class="col-4 text-center">
                        <button class="btn" onclick="showForm()" id="btForm">增加用户</button>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <br>
    <div class="row" style="display: none" id="formDiv">
        <div class="col-6"></div>
        <div class="col-6" style="background-color:lavender;">
            <br>
            <form action="/userManage" class="container" method="post" id="form1">
                <div class="form-group row">
                    <div class="col-2">账号:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="account" id="account">
                    </div>
                    <div>
                        <%if(request.getAttribute("isExist")!=null){%>
                        <%=request.getAttribute("isExist")%>
                        <%}%>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-2">密码:</div>
                    <div class="col-5">
                        <input type="password" class="form-control" name="password" id="password">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-2">邮箱:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="email" id="email">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-2">昵称:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="name" id="name">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-2">是否为管理:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="isAdmin" id="isAdmin" placeholder="1为管理员 0为普通用户">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-2"></div>
                    <div class="col-4"><input type="button" class="btn" onclick="can_sub()" value="提交"></div>
                </div>
                <br>
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
    function can_sub(){
        var account = document.getElementById('account').value;
        var password = document.getElementById('password').value;
        var name = document.getElementById('name').value;
        var email = document.getElementById('email').value;
        var isAdmin = document.getElementById('isAdmin').value;

        if(account==null||password==null||name==null||email==null||isAdmin==null){
            document.getElementById('tip').innerHTML="信息不能为空！";
        }

        if(account==""||password==""||name==""||email==""||isAdmin==""){
            document.getElementById('tip').innerHTML="信息不能为空！";
        }else{
            document.getElementById('tip').innerHTML="";
            var form = document.getElementById('form1');
            form.submit();
        }
    }

    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    function changePower(userID){
        var isAdmin = document.getElementById(userID).value;
        location.href = "/userManage?userId="+userID+"&changeAdmin="+ (isAdmin);
    }

    function deleteAccount(userID) {
        location.href="/userManage?deleteUserId="+userID;
    }

    function showForm() {
        var div= document.getElementById("formDiv");
        div.style.display='block';
        document.getElementById("btForm").innerHTML="取消操作";
    }

    function hideForm() {
        var div = document.getElementById("formDiv");
        div.style.display = 'none';
        document.getElementById("btForm").innerHTML="增加用户";
    }

</script>
</body>
</html>
