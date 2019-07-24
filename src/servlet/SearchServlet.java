package servlet;

import bean.Item;
import dao.ItemDaoImpl;
import factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.List;

import static dao.ItemDaoImpl.PAGE_SIZE;

/**
 * @author: YXH
 * @date: 2019/7/21
 * @time: 13:34
 */
@WebServlet(name = "SearchServlet",value = "/search")
public class SearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //System.out.println(request.getParameter("keyword"));
        //System.out.println(request.getParameter("page"));
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            response.sendRedirect("/index.jsp");
            return;
        }
        response.setCharacterEncoding("utf-8");
        String keyword = request.getParameter("keyword");
        PrintWriter out = response.getWriter();
        try{
            ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();
            List<Item> items = itemDao.findByKeywordAndPage(keyword,page);
            itemDao.close();
            int num = items.size();
            StringBuilder resultHTML = new StringBuilder();
            for(int i = 0 ; i < (num-1)/PAGE_SIZE+1 ;i++){
                resultHTML.append("<div class=\"row\">");
                for(int j = 0 ; j < ((num-i*PAGE_SIZE)>PAGE_SIZE?PAGE_SIZE:(num-i*PAGE_SIZE)); j++){
                    resultHTML.append("<div class=\"col-3\">\n" +
                            "                <div class=\"card\">\n" +
                            "                    <a href=\"detail.jsp?id=").append(items.get(i*PAGE_SIZE+j).getItemId()).append("\"><img class=\"card-img-top\" src=\"").append(items.get(i*PAGE_SIZE+j).getImagePath()).append("\" alt=\"").append(items.get(i*PAGE_SIZE+j).getImagePath()).append(".jpg\"></a>")
                                            .append("<div class=\"card-body\">\n" +
                                    "                        <a class=\"card-link\" href=\"detail.jsp?id=").append(items.get(i*PAGE_SIZE+j).getItemId()).append("\">")
                                                            .append("<h5 class=\"text-muted\">").append(items.get(i*PAGE_SIZE+j).getName()).append("</h5>")
                                                            .append("<p class=\"text-dark\">").append(items.get(i*PAGE_SIZE+j).getDescription().substring(0,20)).append("...</p>")
                                                        .append("</a>\n" +
                            "                    </div>\n" +
                            "                </div>\n" +
                            "            </div>");
                }
                resultHTML.append("</div><br>");
            }
            out.println(resultHTML);
        }catch (Exception e){
            e.printStackTrace();
            out.flush();
            out.close();
            response.sendRedirect("/index.jsp");
        }

        out.flush();
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        String keyword;
        if(request.getParameter("keyword") == null)
            keyword = "";
        else{
            keyword = request.getParameter("keyword");
            PrintWriter out = response.getWriter();
            out.println(keyword);
        }
        try{
            ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();
            List<Item> allItems = itemDao.findByKeyword(keyword);
            int totalNum = allItems.size();
            request.setAttribute("numOfItems",totalNum);
            request.setAttribute("keyword",keyword);
            request.setAttribute("totalPage",(totalNum-1)/PAGE_SIZE+1);
            request.setAttribute("items",allItems.subList(0,totalNum>PAGE_SIZE?PAGE_SIZE:totalNum));
            request.getRequestDispatcher("/search.jsp?keyword="+keyword).forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("/index.jsp");
        }
    }
}
