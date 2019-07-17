<%@ page import="java.io.ObjectInputStream" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %><%--
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
                    <span class=""> ${user.name} </span></a>
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
        <div class="col-11">
          <h4>热门展品</h4>
        </div>
        <div class="col-1">
          <a class="btn page-link h5 text-dark" href="#">更多<</a>
        </div>
      </div>
      <div class="row">
        <%!
          private boolean isCollected(HttpSession session, String itemName){
            String strCollections = (String)session.getAttribute("collections");
            if(strCollections == null) strCollections = "";
            String[] collections = strCollections.split("&");
            List<String> list = Arrays.asList(collections);
            return list.contains(itemName);
          }
        %>
        <%

          String strCollections = (String)session.getAttribute("collections");
          if(strCollections == null) strCollections = "";
          String itemName = request.getParameter("itemName");
          if(itemName != null && !isCollected(session,itemName))strCollections += itemName+"&";
          session.setAttribute("collections",strCollections);
          for(int i = 0 ; i < 4 ; i++){
            %>
        <div class="col-3">
          <div class="card">
            <a href="detail.jsp"><img class="card-img-top" src="images/工艺/玉鹿.jpg" alt="玉鹿.jpg"></a>
            <div class="card-body">
              <a class="card-link" href="detail.jsp">
                <h5 class="text-muted">玉鹿</h5>
                <p class="text-dark">描述..........</p>
              </a>
              <%
                if(isCollected(session,"玉鹿")){
              %>
              <div class="btn btn-light">已收藏</div>
              <%
                }else {
                    %>
              <form action="index.jsp">
                <input name="itemName" value="玉鹿" type="text" class="text-hide" readonly>
                <input type="submit" class="btn btn-dark" value="收藏">
              </form>
              <%
                }
              %>
            </div>
          </div>
        </div>
        <%}
        %>
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
          for(int i = 0 ; i < 4 ; i++){
        %>
        <div class="col-3">
          <div class="card">
            <a href="detail.jsp"><img class="card-img-top" src="images/工艺/鸟纹玉璧.jpg" alt="鸟纹玉璧.jpg"></a>
            <div class="card-body">
              <a class="card-link" href="detail.jsp">
                <h5 class="text-muted">鸟纹玉璧</h5>
                <p class="text-dark">描述..........</p>
              </a>
              <%
                if(isCollected(session,"鸟纹玉璧")){
              %>
              <div class="btn btn-light">已收藏</div>
              <%
              }else {
              %>
              <form action="index.jsp">
                <input name="itemName" value="鸟纹玉璧" type="text" class="text-hide" readonly>
                <input type="submit" class="btn btn-dark" value="收藏">
              </form>
              <%
                }
              %>
            </div>
          </div>
        </div>
        <%}
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
