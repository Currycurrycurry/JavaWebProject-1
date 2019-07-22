<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Item" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 14:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的收藏</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<%
    UserEntry user = (UserEntry) session.getAttribute("user");
    List<Item> publicCollection = new ArrayList<>();
    List<Item> privateCollection = new ArrayList<>();
    if(user==null){
        response.sendRedirect("/login.jsp");
    }else {
        if(request.getAttribute("publicCollection") == null){
            request.getRequestDispatcher("/collection").forward(request,response);
            System.out.println("1");
        }else {
            publicCollection =  (ArrayList<Item>)request.getAttribute("publicCollection");
            privateCollection =  (ArrayList<Item>)request.getAttribute("privateCollection");
        }
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
                                <li><a class="dropdown-item" href="collection.jsp">我的收藏</a></li>
                                <li class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/LoginOutServlet">登    出</a></li>
                            </ul>
                        </li>
                        <%
                            if(user!=null&&user.isAdmin()){
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
        <div class="col-6">
            <h4>公开收藏夹</h4>
        </div>
    </div>
    <br>
    <div class="row">
        <%
            if(publicCollection.size() == 0){
                %>
        <div class="col-12">
            <br><br><br>
            <h3 class="text-center">你的公开收藏夹为空，试着收藏一些展品吧。</h3>
        </div>
        <%
            }
        %>
    </div>
    <%
        for(Item item : publicCollection){
            %>
    <div class="card">
        <div class="row">
            <div class="col-2">
                <a href="detail.jsp?id=">
                    <img class="card-img" src="<%=item.getImagePath()%>" alt="<%=item.getImagePath()%>">
                </a>
            </div>
            <div class="col-8">
                <table class="table" style="table-layout:fixed;">
                    <tbody>
                    <tr>
                        <td class="font-weight-bold">名称</td>
                        <td class="font-weight-bold">收藏时间</td>
                        <td class="font-weight-bold">馆藏地点</td>
                        <td class="font-weight-bold">热度</td>
                    </tr>
                    <tr>
                        <td>
                            <a href="detail.jsp?id=" class="card-link text-dark">
                                <%=item.getName()%>
                            </a>
                        </td>
                        <td><%=item.getTimeReleased()%></td>
                        <td><%=item.getAddress()%></td>
                        <td><%=item.getView()%></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-2 text-center">
                <br>
                <div class="btn-group-vertical">
                    <a href="/collect?itemId=<%=item.getItemId()%>&change=true&collectionPage=true" class="btn btn-outline-dark">
                        改为私有
                    </a>
                    <a href="/collect?itemId=<%=item.getItemId()%>&delete=true&collectionPage=true" class="btn btn-outline-info">
                        取消收藏
                    </a>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
    <br>
    <div class="row">
        <div class="col-6">
            <h4>私有收藏夹</h4>
        </div>
    </div>
    <br>
    <div class="row">
        <%
            if(privateCollection.size() == 0){
        %>
        <div class="col-12">
            <br><br><br>
            <h3 class="text-center">私有收藏夹只有自己可见，试着收藏一些展品吧。</h3>
        </div>
        <%
            }
        %>
    </div>
    <%
        for(Item item : privateCollection){
    %>
    <div class="card">
        <div class="row">
            <div class="col-2">
                <a href="detail.jsp?id=">
                    <img class="card-img" src="<%=item.getImagePath()%>" alt="<%=item.getImagePath()%>">
                </a>
            </div>
            <div class="col-8">
                <table class="table" style="table-layout:fixed;">
                    <tbody>
                    <tr>
                        <td class="font-weight-bold">名称</td>
                        <td class="font-weight-bold">收藏时间</td>
                        <td class="font-weight-bold">馆藏地点</td>
                        <td class="font-weight-bold">热度</td>
                    </tr>
                    <tr>
                        <td>
                            <a href="detail.jsp?id=" class="card-link text-dark">
                                <%=item.getName()%>
                            </a>
                        </td>
                        <td><%=item.getTimeReleased()%></td>
                        <td><%=item.getAddress()%></td>
                        <td><%=item.getView()%></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-2 text-center">
                <br>
                <div class="btn-group-vertical">
                    <a href="/collect?itemId=<%=item.getItemId()%>&change=true&collectionPage=true" class="btn btn-outline-dark">
                        改为公共
                    </a>
                    <a href="/collect?itemId=<%=item.getItemId()%>&delete=true&collectionPage=true" class="btn btn-outline-info">
                        取消收藏
                    </a>
                </div>
            </div>
        </div>
    </div>
    <%
        }
    %>
</div>



<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

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
