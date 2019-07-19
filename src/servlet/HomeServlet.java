package servlet;

import bean.Item;
import dao.ItemDao;
import dao.ItemDaoImpl;
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
 * @date: 2019/7/18
 * @time: 18:04
 */
@WebServlet(name = "HomeServlet",value = "/home")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();
            List<Item> mostViewItems = itemDao.getItemsOrdered(4,"view");
            List<Item> mostNewItems = itemDao.getItemsOrdered(4,"timeReleased");
            request.setAttribute("mostViewItems",mostViewItems);
            request.setAttribute("mostNewItems",mostNewItems);
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
