<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>展品详情</title>
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
                        <li class="nav-item dropdown">
                            <a href="#" class="nav-link text-dark navitems dropdown-toggle" data-toggle="dropdown">
                                <span class=""> Admin001 </span></a>
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
                                <li><a class="dropdown-item" href="#">登    出</a></li>
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
    <div class="row">
        <div class="col-6">
            <p class="h3">玉鹿</p>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <div class="card">
                <img class="card-img" src="images/工艺/玉鹿.jpg">
            </div>
        </div>
        <div class="col-6">
            <div class="card">
                <div class="card-body">
                    <table class="table table-hover" style="table-layout:fixed;">
                        <thead>
                        <tr>
                            <th class="text-center h4" colspan="3">展品详情</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="font-weight-bold">名称</td>
                            <td colspan="2">玉鹿</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">馆藏地点</td>
                            <td colspan="2">233博物馆</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">出土年份</td>
                            <td colspan="2">2233年</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">热度</td>
                            <td colspan="2">2233</td>
                        </tr>
                        <tr>
                            <td class="font-weight-bold">简介</td>
                            <td colspan="2">黄褐色，扁体片状。呈站立状。长角粗壮，分两杈向左右平展，前杈上扬，卷成两个大圆孔，后杈向后勾曲。臣字目，大耳，吻部前突，前胸挺出，后背拱起，短尾，体态丰润，蹄趾明显。体肌以两道圆弧线表现，简练明快。后肢前曲，表现了鹿昂首观望，蓄势待发的神态，富有活力。</td>
                        </tr>
                        </tbody>
                    </table>
                    <form action="index.jsp">
                        <input name="itemName" value="玉鹿" type="text" class="text-hide" readonly>
                        <input type="submit" class="btn btn-dark float-right" value="收藏">
                    </form>
                </div>
            </div>
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
