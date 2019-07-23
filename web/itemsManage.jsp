<%@ page import="bean.UserEntry" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>展品管理</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<%
    Object object = session.getAttribute("user");
    if(object==null){
        response.sendRedirect("/login.jsp");
        return;
    }else{
        UserEntry userEntry = (UserEntry) object;
        if(!userEntry.isAdmin()){
            response.sendRedirect("/index.jsp");
            return;
        }
    }
    if(request.getAttribute("item") == null){
        request.getRequestDispatcher("/itemsManage").forward(request,response);
        return;
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
        <div class="col-6">
            <p class="h3">${requestScope.item.name}</p>
        </div>
        <div class="col-6">
            <a href="" class="btn btn-danger float-right">
                删除展品
            </a>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <div class="card">
                <img class="card-img" src="${requestScope.item.imagePath}" id="itemImage">
            </div>
            <hr>
            <h4>相关视频</h4>
            <div class="media border p-1">
                <video src="${requestScope.item.videoPath}" controls="controls" style="width: 100%; height: auto; object-fit: fill" id="itemVideo">
                    您的浏览器不支持 video 标签。
                </video>
            </div>
        </div>
        <div class="col-6">
            <div class="card">
                <div class="card-body">
                    <form method="post" id="uploadForm" action="/itemsManage"  enctype="multipart/form-data">
                        <input value="${requestScope.item.itemId}" name="itemId" style="display: none" readonly>
                        <table class="table table-hover" style="table-layout:fixed;">
                            <thead>
                            <tr>
                                <th class="text-center h4" colspan="3">修改信息</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="font-weight-bold">
                                    名称
                                    <div id="warnName" class="h6 text-danger"></div>
                                </td>
                                <td colspan="2">
                                    <input type="text" class="form-control" id="uploadName" name="uploadName" value="${requestScope.item.name}">
                                </td>
                            </tr>
                            <tr>
                                <td class="font-weight-bold">
                                    馆藏
                                    <div id="warnAddress" class="h6 text-danger"></div>
                                </td>
                                <td colspan="2">
                                    <input type="text" class="form-control" id="address" name="address" value="${requestScope.item.address}">
                                </td>
                            </tr>
                            <tr>
                                <td class="font-weight-bold">
                                    年代
                                    <div id="warnYear" class="h6 text-danger"></div>
                                </td>
                                <td colspan="2">
                                    <input type="text" class="form-control" id="year" name="year" value="${requestScope.item.year}">
                                </td>
                            </tr>
                            <tr>
                                <td class="font-weight-bold">
                                    简介
                                    <div id="warnDescription" class="h6 text-danger"></div>
                                </td>
                                <td colspan="2">
                                    <textarea class="form-control" style="height: 350px" id="description" name="description">${requestScope.item.description}</textarea>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <br>
                        <div class="form-group">
                            <label class="h5 font-weight-bold">修改图片</label>&nbsp;&nbsp;
                            <input type="file" accept="image/*" id="itemImageFile" name="itemImageFile">
                        </div>
                        <div class="form-group">
                            <label class="h5 font-weight-bold">修改视频</label>&nbsp;&nbsp;
                            <input type="file" accept="video/*" id="itemVideoFile" name="itemVideoFile">
                        </div>
                    </form>
                    <button class="btn btn-dark float-right" id="btUpload">
                        保存修改
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>




<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/itemsManage.js"></script>

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
