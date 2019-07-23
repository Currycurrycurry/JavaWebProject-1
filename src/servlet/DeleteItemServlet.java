package servlet;

import bean.UserEntry;
import dao.CollectionDaoImpl;
import dao.ItemDaoImpl;
import factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author: YXH
 * @date: 2019/7/24
 * @time: 1:21
 */
@WebServlet(name = "DeleteItemServlet",value = "/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserEntry user = (UserEntry) request.getSession().getAttribute("user");
            if (!user.isAdmin()) {
                response.sendRedirect("index.jsp");
                return;
            }
            System.out.println(request.getParameter("itemId"));
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();
            itemDao.deleteById(itemId);
            CollectionDaoImpl collectionDao = DaoFactory.getCollectionDaoInstance();
            collectionDao.deleteByItemId(itemId);
            response.sendRedirect("index.jsp");
        }catch (Exception e){
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
    }
}
