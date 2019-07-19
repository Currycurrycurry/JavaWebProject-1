package servlet;

import bean.UserEntry;
import dao.CollectionDaoImpl;
import factory.DaoFactory;

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
        int userId,itemId = 1;
        try {
            userId = ((UserEntry)request.getSession().getAttribute("user")).getId();
            itemId = Integer.parseInt(request.getParameter("itemId"));

            CollectionDaoImpl collectionDao = DaoFactory.getCollectionDaoInstance();
            if("true".equals(request.getParameter("delete"))){
                collectionDao.deleteCollection(userId,itemId);
            }else {
                boolean isPublic = "true".equalsIgnoreCase(request.getParameter("isPublic"));
                collectionDao.insertCollection(userId,itemId,isPublic);
            }
            request.getRequestDispatcher("/detail.jsp?id="+itemId).forward(request,response);
        }catch (Exception e){
            request.getRequestDispatcher("/detail.jsp?id="+itemId).forward(request,response);
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request,response);
    }
}
