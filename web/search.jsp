<%@ page import="bean.UserEntry" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Item" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static dao.ItemDaoImpl.PAGE_SIZE" %><%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/14
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>展品搜索</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
</head>
<%

    List<Item> items;
    if(request.getAttribute("items") == null){
        response.sendRedirect("/search?keyword=");
    }
    items = (List<Item>)request.getAttribute("items");
    int pageSize = PAGE_SIZE;
    int num = items.size();
    String keyword = request.getParameter("keyword");
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
                                <li><a class="dropdown-item" href="itemsManage.jsp">展品管理</a></li>
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
                    <input type="text" class="form-control" id="search-input" placeholder="想要找什么展品呢" name="keyword" value="<%=request.getAttribute("keyword")%>">
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
            <h4>
                搜索到<%=request.getAttribute("numOfItems")%>条关于"<%=request.getAttribute("keyword")%>"的展品
            </h4>
        </div>
    </div>
    <br>
    <div id="showResult">
        <%
            for(int i = 0 ; i < (num-1)/pageSize+1 ;i++){
        %>
        <div class="row">
            <%
                for(int j = 0 ; j < ((num-i*pageSize)>pageSize?pageSize:(num-i*pageSize)); j++){
            %>
            <div class="col-3">
                <div class="card">
                    <a href="detail.jsp?id=<%=items.get(i*pageSize+j).getItemId()%>"><img class="card-img-top" src="<%=items.get(i*pageSize+j).getImagePath()%>" alt="<%=items.get(i*pageSize+j).getImagePath()%>.jpg"></a>
                    <div class="card-body">
                        <a class="card-link" href="detail.jsp?id=<%=items.get(i*pageSize+j).getItemId()%>">
                            <h5 class="text-muted"><%=items.get(i*pageSize+j).getName()%></h5>
                            <p class="text-dark"><%=items.get(i*pageSize+j).getDescription().substring(0,20)%>...</p>
                        </a>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div><br>
        <%
            }
        %>
    </div>
    <div class="row">
        <div class="col-8">
            <p class="float-right form-text h4">
                <span id="nowPage">1</span>/<span id="totalPage"><%=request.getAttribute("totalPage")%></span>页
            </p>
        </div>
        <div class="col-1">
            <input class="form-control" title="" placeholder="页数" id="pageInput">
        </div>
        <div class="col-3">
            <button class="btn btn-dark float-right" id="btNext">下一页</button>
            <button class="btn btn-dark float-right" id="btPrevious">上一页</button>
            <button class="btn btn-dark float-left" id="btJump">GO!</button>
        </div>
    </div>
    <br>
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
    alert(keyword);
    form.submit();
}

</script>
<script type="text/javascript" src="js/search.js"></script>
</body>
</html>
