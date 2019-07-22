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
        <div class="col-8" style="background-color:lavender;">
            <br>
            <form action="/sign" method="post" class="container" id="form">
                <div class="form-group row">
                    <div class="col-2">账号:</div>
                    <div class="col-5"><input class="form-control" type="text" name = "account" id = "account"
                                placeholder="account[4-15]" value="<%=array[0]%>"></div>
                    <div class="col-5"><span id="tic1">
                        <%if(request.getAttribute("account_exist")!=null) out.print((String)request.getAttribute("account_exist"));%>
                    </span></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">密码:</div>
                    <div class="col-5"> <input class="form-control" type="password" name="password" id = "password" placeholder="password[6-10]"
                                               value="<%=array[1]%>"></div>
                    <div class="col-5"><span id="tic2"></span></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">确认密码:</div>
                    <div class="col-5"><input class="form-control" type="password" name="password_again" id = "password_again" placeholder="password again"
                                              value="<%=array[1]%>"></div>
                    <div class="col-5"><span id="tic3"></span></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">昵称:</div>
                    <div class="col-5"><input class="form-control" type="text" name = "name" id = "name" placeholder="username"
                                              value="<%=array[2]%>"></div>
                    <div class="col-5"><span id="tic4"></span></div>
                </div>
                <div class="form-group row ">
                    <div class="col-2">邮箱:</div>
                    <div class="col-5"><input class="form-control" type="email" name="email" id = "email" placeholder="Email address"
                                              value="<%=array[3]%>"></div>
                    <div class="col-5"><span id="tic5"></span></div>
                </div>
                <div class="form-group row">
                    <div class="col-2">验证码:</div>
                    <div class="col-5"><input class="form-control" type="text" name="code" id = "code" placeholder="Verification code"
                                              value="<%=array[4]%>"></div>
                    <div class="col-2"><img id="vCode" src="VerifyCodeServlet" /></div>
                    <div class="col-3">
                        <a href="javascript:_change()">看不清，换一张</a>
                        <span id="tic6">
                            <%if(request.getAttribute("vCode")!=null)
                                out.print((String)request.getAttribute("vCode"));
                            %>
                        </span>
                    </div>
                </div>
                <div class="text-center text-danger" id="safe"></div>
                <br>
                <div class="form-group text-center row">
                    <div class="col-5"></div>
                    <input type="button" onclick="safe()" class="btn btn-info col-2" value="Sign">
                </div>
            </form>
        </div>
    </div>
</div>


<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/user.js"></script>
<script type = "text/javascript">
    //下拉菜单
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
