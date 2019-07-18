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
    <script type = "text/javascript">
        function safe() {
            account1();pass1();pass2();name1();email();code1();
            if(account1()&&pass1()&&pass2()&&name1()&&code1()&&email()){
                var form = document.getElementById('form');
                form.submit();
            } else {
                document.getElementById('safe').innerHTML="请确认信息非空！";
            }
        }

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

        function pass2() {
            var pass1 = document.getElementById('password').value;
            var pass2 = document.getElementById('password_again').value;
            if(pass2==pass1){
                document.getElementById('tic3').innerHTML="";
                return true;
            }
            else{
                document.getElementById('tic3').innerHTML="两次密码不相同";
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

        function email(){
            var t = document.getElementById('email').value;
            var pattern = /^[0-9a-zA-Z_]{5,18}@[0-9a-z]+.com$/;
            if(pattern.test(t)){
                document.getElementById('tic5').innerHTML="";
                return true}
            else{
                document.getElementById('tic5').innerHTML="x(5-18位)@x.com";
                return false;
            }
        }

        function code1() {
            var code = document.getElementById('code').value;
            return code!="";
        }

        function _change() {
            var imgEle = document.getElementById('vCode');
            imgEle.src = "VerifyCodeServlet?"+new Date().getTime();
        }

    </script>
</head>
<body>
<%
    Object o = request.getAttribute("array");
    String[] array = {"","","","",""};
    if(o!=null){
        array=(String[])o;
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
            <form action="/sign" method="post" class="container" id="form">
                <table>
                    <tr>
                        <td>账号:</td>
                        <td><input class="form-control" type="text" name = "account" id = "account" placeholder="account[4-15]"
                                   value="<%=array[0]%>">
                        <td><span id="tic1">
                        <%if(request.getAttribute("account_exist")!=null) out.print((String)request.getAttribute("account_exist"));%>
                    </span></td>
                    </tr>
                    <tr>
                        <td>密码:</td>
                        <td><input class="form-control" type="password" name="password" id = "password" placeholder="password[6-10]"
                                   value="<%=array[1]%>"></td>
                        <td><span id="tic2"></span></td>
                    </tr>
                    <tr>
                        <td>确认密码:</td>
                        <td><input class="form-control" type="password" name="password_again" id = "password_again" placeholder="password again"
                                   value="<%=array[1]%>"></td>
                        <td><span id="tic3"></span></td>
                    </tr>
                    <tr>
                        <td>昵称:</td>
                        <td><input class="form-control" type="text" name = "name" id = "name" placeholder="username"
                                   value="<%=array[2]%>"></td>
                        <td><span id="tic4"></span></td>
                    </tr>
                    <tr>
                        <td>邮箱:</td>
                        <td><input class="form-control" type="email" name="email" id = "email" placeholder="Email address"
                                   value="<%=array[3]%>"></td>
                        <td><span id="tic5"></span></td>
                    </tr>
                    <tr>
                        <td>验证码:</td>
                        <td><input class="form-control" type="text" name="code" id = "code" placeholder="Verification code"
                                   value="<%=array[4]%>"></td>
                        <td><img id="vCode" src="VerifyCodeServlet" />
                        <a href="javascript:_change()">看不清，换一张</a></td>
                        <td><span id="tic6">
                            <%if(request.getAttribute("vCode")!=null)
                                out.print((String)request.getAttribute("vCode"));%></span></td>
                    </tr>
                </table>
                <div class="text-center text-danger" id="safe"></div>
                <br>
                <div class="row">
                    <div class="col">
                        <input type="button" onclick="safe()" class="btn btn-info" value="Sign">
                    </div>
                    <div class="col">
                        <input type="reset"class="btn btn-info" value="Reset">
                    </div>
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
