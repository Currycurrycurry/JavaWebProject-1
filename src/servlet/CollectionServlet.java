package servlet;

import bean.Item;
import bean.UserEntry;
import dao.CollectionDaoImpl;
import factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/20
 * @time: 20:02
 */
@WebServlet(name = "CollectionServlet",value = "/collection")
public class CollectionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserEntry user = (UserEntry) request.getSession().getAttribute("user");
            int userId = user.getId();
            CollectionDaoImpl collectionDao = DaoFactory.getCollectionDaoInstance();
            List<Item> publicCollection =  collectionDao.findCollection(userId,true);
            List<Item> privateCollection =  collectionDao.findCollection(userId,false);
            collectionDao.close();
            request.setAttribute("publicCollection",publicCollection);
            request.setAttribute("privateCollection",privateCollection);
            request.getRequestDispatcher("/collection.jsp").forward(request,response);
        }catch (Exception e){
            response.sendRedirect("index.jsp");
            e.printStackTrace();
        }
    }
}
