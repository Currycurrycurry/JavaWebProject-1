package servlet;

import bean.UserEntry;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author: YXH
 * @date: 2019/7/19
 * @time: 13:23
 */
@WebServlet(name = "CollectServlet",value = "/collect")
public class CollectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(request.getSession().getAttribute("user") == null){
            response.sendRedirect("/login.jsp");
        }
        try {
            int userId = ((UserEntry)request.getSession().getAttribute("user")).getId();
            int itemId = Integer.parseInt(request.getParameter("itemId"));
        }catch (Exception e){
            e.getCause();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
}
