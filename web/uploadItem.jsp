<%@ page import="bean.UserEntry" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/22
  Time: 17:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>上传新的展品</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
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
%>
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
                        <%
                            Object o = session.getAttribute("user");
                            if(o!=null){
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
                        <%
                            UserEntry userEntry = (UserEntry)o;
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
                        </li>
                        <%
                            }}else{
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
            <div class="card">
                <div class="card-header">
                    <h4 class="text-center">上传的展品信息</h4>
                </div>
                <div class="card-body p-5">
                    <form method="post" action="/upload" id="uploadForm" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="h5">名称:&nbsp;&nbsp;&nbsp;
                                <span id="warnName" class="h6 text-danger"></span>
                            </label>
                            <input type="text" class="form-control" id="uploadName" name="uploadName">
                        </div>
                        <div class="form-group">
                            <label class="h5">馆藏:&nbsp;&nbsp;&nbsp;
                                <span id="warnAddress" class="h6 text-danger"></span>
                            </label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                        <div class="form-group">
                            <label class="h5">年代:&nbsp;&nbsp;&nbsp;
                                <span id="warnYear" class="h6 text-danger"></span>
                            </label>
                            <input type="text" class="form-control" id="year" name="year">
                        </div>
                        <div class="form-group">
                            <label class="h5">描述:&nbsp;&nbsp;&nbsp;
                                <span id="warnDescription" class="h6 text-danger"></span>
                            </label>
                            <textarea class="form-control" style="height: 250px" id="description" name="description"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="h5">图片:&nbsp;&nbsp;&nbsp;
                                <span id="warnImage" class="h6 text-danger"></span>
                            </label><br>
                            <input type="file" accept="image/*" id="itemImageFile" name="itemImageFile">
                        </div>
                        <img src="" class="img-fluid" id="itemImage">
                        <br>
                        <div class="form-group">
                            <label class="h5">视频:&nbsp;&nbsp;&nbsp;
                                <span id="warnVideo" class="h6 text-danger"></span>
                            </label><br>
                            <input type="file" accept="video/*" id="itemVideoFile" name="itemVideoFile">
                        </div>
                    </form>

                </div>
                <div class="card-footer text-center">
                    <button class="btn btn-dark" id="btUpload">确认上传</button>
                </div>
            </div>
        </div>
        <div class="col-2"></div>
    </div>
</div><br>







<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/upload.js"></script>
<script>/*下拉菜单*/
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
