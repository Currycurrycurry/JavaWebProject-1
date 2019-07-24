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
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if(request.getSession().getAttribute("user") == null){
            response.sendRedirect("/login.jsp");
            System.out.println("please login.");
            return;
        }
        int userId,itemId;
        try {
            userId = ((UserEntry)request.getSession().getAttribute("user")).getId();
            itemId = Integer.parseInt(request.getParameter("itemId"));
            CollectionDaoImpl collectionDao = DaoFactory.getCollectionDaoInstance();
            if("true".equals(request.getParameter("delete"))){
                collectionDao.deleteCollection(userId,itemId );
            }else if("true".equals(request.getParameter("newCollect"))){
                boolean isPublic = "true".equalsIgnoreCase(request.getParameter("isPublic"));
                collectionDao.insertCollection(userId,itemId,isPublic);
            }else if("true".equals(request.getParameter("change"))){
                collectionDao.changePublicity(userId,itemId);
            }
            collectionDao.close();
            if("true".equals(request.getParameter("collectionPage")))
                response.sendRedirect("/collection.jsp");
            else
                response.sendRedirect("/detail.jsp?id="+itemId);
        }catch (Exception e){
            request.getRequestDispatcher("/index.jsp").forward(request,response);
            e.printStackTrace();
        }
    }
}
