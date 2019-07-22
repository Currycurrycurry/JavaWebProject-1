package servlet;

import bean.Item;
import bean.UserEntry;
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
 * @date: 2019/7/19
 * @time: 11:12
 */
@WebServlet(name = "DetailServlet",value = "/detail")
public class DetailServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int itemId;
            if(request.getParameter("id") == null){
                itemId = 1;
            }else {
                try{
                    itemId = Integer.parseInt(request.getParameter("id"));
                }catch (NumberFormatException e){
                    itemId = 1;
                }

            }
            ItemDaoImpl itemDao = DaoFactory.getItemDaoInstance();
            itemDao.addView(itemId,1);
            Item item = itemDao.findById(itemId);

            boolean isCollected = false;
            if(request.getSession().getAttribute("user") != null){
                isCollected = itemDao.isCollectedByUser(itemId,((UserEntry)request.getSession().getAttribute("user")).getId());
            }
            request.setAttribute("item",item);
            request.setAttribute("isCollected",isCollected);
            request.getRequestDispatcher("/detail.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
