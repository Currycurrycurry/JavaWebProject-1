<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%--
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
                                <li><a class="dropdown-item" href="uploadItem.jsp">上传展品</a></li>
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
                <input type="text" class="form-control" id="search-input" placeholder="想要找什么展品呢">
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
                    <form class="col-2 text-center" method="post" action="/userManage">
                        <% if(!userEntry.isAdmin()){ %>
                        <input type="text"  name = "improveAdmin" value="<%=userEntry.getId()%>" hidden>
                        <button type="submit" class="btn btn-info">提升管理员</button>
                        <%}else{%>
                        <input type="text" name = "changeAdmin" value="<%=userEntry.getId()%>" hidden>
                        <button type="submit" class="btn btn-danger">降级为普通</button>
                        <%}%>
                    </form>
                    <form class="col-2 text-center" method="post" action="/userManage">
                        <input type="text" name = "deleteUserId" value="<%=userEntry.getId()%>" hidden>
                        <button type="submit" class="btn btn-secondary">删除用户</button>
                    </form>
                </div>
            </li>
            <%
                }
            %>
            <li class="list-group-item">
                <div class="row">
                    <div class="col-9"></div>
                    <div class="col-3 text-center">
                        <button class="btn" id="show-form" style="display: block">增加用户</button>
                        <button class="btn" id="close-form" style="display: none">取消操作</button>
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
            <form class="container" id="form1">
                <div class="form-group row">
                    <div class="col-2">账号:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="account" id="account" placeholder="account[4-15]">
                    </div>
                    <div class="text-center text-danger" id = "tic1"></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">密码:</div>
                    <div class="col-5">
                        <input type="password" class="form-control" name="password" id="password" placeholder="password[6-10]">
                    </div>
                    <div class="text-center text-danger" id = "tic2"></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">邮箱:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="email" id="email" placeholder="Email address">
                    </div>
                    <div class="text-center text-danger" id = "tic3"></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">昵称:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="name" id="name" placeholder="name">
                    </div>
                    <div class="text-center text-danger" id = "tic4"></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">是否为管理:</div>
                    <div class="col-5">
                        <input type="text" class="form-control" name="isAdmin" id="isAdmin" value="0">
                    </div>
                    <div class="text-center text-info">1-管理员 0-普通</div>
                </div>
                <div class="form-group row text-danger" id="safe"></div>
                <div class="form-group row">
                    <div class="col-2"></div>
                    <div class="col-4"><input type="button" class="btn" id="btSub" value="提交"></div>
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
    var ajax;

    function account1(){
        var account = document.getElementById('account').value;
        if(account.length>15){
            document.getElementById('tic1').innerHTML="账号不能超过15位";
            return false;
        } else if(account.length<4){
            document.getElementById('tic1').innerHTML="账号不能小于4位";
            return false;
        } else {
            document.getElementById('tic1').innerHTML="";
            return true;
        }
    }

    function pass1() {
        var pass1 = document.getElementById('password').value;
        if(pass1.length<6||pass1.length>10){
            document.getElementById('tic2').innerHTML="密码在6-10位之间";
            return false;
        } else {
            document.getElementById('tic2').innerHTML="";
            return true;
        }
    }

    function email(){
        var t = document.getElementById('email').value;
        var pattern = /^[0-9a-zA-Z_]{2,18}@[0-9a-z]+.com$/;
        if(pattern.test(t)){
            document.getElementById('tic3').innerHTML="";
            return true}
        else{
            document.getElementById('tic3').innerHTML="x(2-18位)@x.com";
            return false;
        }
    }

    function name1() {
        var y = document.getElementById('name').value;
        if(y==""){
            document.getElementById('tic4').innerHTML="昵称不能为空";
            return false;
        }
        else {document.getElementById('tic4').innerHTML="";return true;}
    }

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
        ajax.open("POST", "/insertUser", true);
        ajax.onreadystatechange = function() {
            if (ajax.readyState == 4 && ajax.status == 200) {
                var result = ajax.responseText;
                if (result == "success") {
                    alert("添加成功！");
                    location.href = "/userManage.jsp";
                } else if(result=="exist") {
                    document.getElementById("tic1").innerHTML = "用户名已存在！";
                }
            }
        };
        ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        var account = document.getElementById('account').value;
        var password = document.getElementById('password').value;
        var email = document.getElementById('email').value;
        var name = document.getElementById('name').value;
        var isAdmin = document.getElementById('isAdmin').value;
        var param = "account="+account+"&password="+password+"&name="+name+"&email="+email+"&isAdmin="+isAdmin;
        ajax.send(param);
    }

    var bt = document.getElementById("btSub");
    bt.onclick = function() {
        account1();pass1();name1();email();
        if(account1()&&pass1()&&name1()&&email()){
            document.getElementById('safe').innerHTML="";
            jump();
        } else {
            document.getElementById('safe').innerHTML="请确认信息正确！";
        }
    };

    /*下拉菜单*/
    $(document).ready(function(){
        $(document).off('click.bs.dropdown.data-api');
    });

    var btSearch = document.getElementById("search-button");
    btSearch.onclick = function () {
        var keyword = document.getElementById("search-input").value;
        window.location.href = "/search?keyword="+keyword;
    };

    var showForm = document.getElementById("show-form");
    showForm.onclick=function () {
        document.getElementById("show-form").style.display="none";
        document.getElementById("close-form").style.display = "block";
        document.getElementById("formDiv").style.display = "block";
    };

    var closeForm = document.getElementById("close-form");
    closeForm.onclick=function () {
        document.getElementById("show-form").style.display = "block";
        document.getElementById("close-form").style.display="none";
        document.getElementById("formDiv").style.display = "none";
    };

</script>
</body>
</html>
