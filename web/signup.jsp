<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/13
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>您需要一个新的帐号</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
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
                        <li class="nav-item">
                            <a href="login.jsp" class="nav-link text-dark navitems">
                                <span class=""> 登录 </span></a>
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
    <div class="row">
        <div class="col-3"></div>
        <div class="col-6" style="background-color:lavender;">
            <br><br>
            <form action="/sign" method="post" class="container">
                <table>
                    <tr>
                        <td>账号:</td>
                        <td><input class="form-control" type="text" name = "account" placeholder="account[4-15]">
                        <td>不能为空!</td>
                    </tr>
                    <tr>
                        <td>密码:</td>
                        <td><input class="form-control" type="password" name="password" placeholder="password[6-10]"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>确认密码:</td>
                        <td><input class="form-control" type="password" name="password_again" placeholder="password again"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>昵称:</td>
                        <td><input class="form-control" type="text" name = "name" placeholder="username"></td>
                    </tr>
                    <tr>
                        <td>邮箱:</td>
                        <td><input class="form-control" type="email" name="email_address" placeholder="Email address"></td>
                        <td>请输入正确格式xx@xx.com</td>
                    </tr>
                    <tr>
                        <td>验证码:</td>
                        <td><input class="form-control" type="text" name="code" placeholder="Verification code"></td>
                        <td><%

                        %></td>
                    </tr>
                </table>
                <button type="submit">Sign</button>
                <button href="index.jsp">Back to Home</button>
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
