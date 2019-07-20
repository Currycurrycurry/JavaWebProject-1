<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="bean.UserEntry" %>
<%@ page import="bean.Item" %>
<%--
  Created by IntelliJ IDEA.
  User: YXH
  Date: 2019/7/13
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title>欢迎来到2233博物馆</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap-grid.css">
    <link rel="stylesheet" href="css/bootstrap-reboot.css">
    <link rel="stylesheet" href="css/index.css">
  </head>
  <%
    if(request.getAttribute("mostViewItems") == null){
      request.getRequestDispatcher("/home").forward(request,response);
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
                    <li><a class="dropdown-item" href="Message.jsp">消    息</a></li>
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
      <div class="col-11">
        <h4>热门展品</h4>
      </div>
      <div class="col-1">
        <a class="btn page-link h5 text-dark" href="#">更多<</a>
      </div>
    </div>
    <div class="row" id="hot-item-row">
      <%
        List<Item> items = (ArrayList<Item>)request.getAttribute("mostViewItems");
      %>
      <div class="col-2"></div>
      <div class="col-8 text-center">
        <br>
        <div id="homePageCarousel" class="carousel slide" data-ride="carousel">
          <!--指示符-->
          <ul class="carousel-indicators">
            <li data-target="#homePageCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#homePageCarousel" data-slide-to="1"></li>
            <li data-target="#homePageCarousel" data-slide-to="2"></li>
            <li data-target="#homePageCarousel" data-slide-to="3"></li>
          </ul>
          <!-- 轮播图片 -->
          <div class="carousel-inner">
            <div class="carousel-item active">
              <a href="detail.jsp?id=<%=items.get(0).getItemId()%>">
                <img src="<%=items.get(0).getImagePath()%>" class="img-fluid img-home">
                <div class="carousel-caption">
                  <h4 class="font-italic"><%=items.get(0).getName()%></h4>
                  <p class="font-italic">
                    <%=items.get(0).getDescription().substring(0,80)%>
                  </p>
                </div>
              </a>
            </div>
            <%
              for(int i = 1 ; i < items.size() ; ++i){
            %>
            <div class="carousel-item">
              <a href="detail.jsp?id=<%=items.get(i).getItemId()%>">
                <img src="<%=items.get(i).getImagePath()%>" class="img-fluid img-home">
                <div class="carousel-caption">
                  <h4 class="font-italic"><%=items.get(i).getName()%></h4>
                  <p class="font-italic">
                    <%=items.get(i).getDescription().substring(0,80)%>
                  </p>
                </div>
              </a>
            </div>
            <%
              }
            %>
          </div>
          <!-- 左右切换按钮 -->
          <a class="carousel-control-prev" href="#homePageCarousel" data-slide="prev">
            <span class="carousel-control-prev-icon"></span>
          </a>
          <a class="carousel-control-next" href="#homePageCarousel" data-slide="next">
            <span class="carousel-control-next-icon"></span>
          </a>
        </div>
      </div>
      <div class="col-2"></div>
    </div>
  </div>

  <br>
    <div class="container">
      <div class="row">
        <div class="col-11">
          <h4>最新展品</h4>
        </div>
        <div class="col-1">
          <a class="btn page-link h5 text-dark" href="#">更多<</a>
        </div>
      </div>
      <div class="row">
        <%
          List<Item> newItems = (ArrayList<Item>)request.getAttribute("mostNewItems");
          for(Item item : newItems){
        %>
        <div class="col-3">
          <div class="card">
            <a href="detail.jsp?id=<%=item.getItemId()%>"><img class="card-img-top" src="<%=item.getImagePath()%>" alt="<%=item.getName()%>.jpg"></a>
            <div class="card-body">
              <a class="card-link" href="detail.jsp?id=<%=item.getItemId()%>">
                <h5 class="text-muted"><%=item.getName()%></h5>
                <p class="text-dark"><%=item.getDescription().substring(0,25)%>...</p>
              </a>
            </div>
          </div>
        </div>
        <%
          }
        %>
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
