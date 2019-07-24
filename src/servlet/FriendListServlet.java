package servlet;

import bean.UserEntry;
import dao.UserDaoImpl;
import factory.DaoFactory;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FriendListServlet",value = "/friendList")
public class FriendListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry user= (UserEntry)session.getAttribute("user");
        int userID= user.getId();

        String friend = request.getParameter("friendID");
        int friendID  = Integer.parseInt(friend);

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            userDao.deleteFriend(userID,friendID);
            userDao.close();
            doGet(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserEntry user= (UserEntry)session.getAttribute("user");
        int userID= user.getId();

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            //更新表
            List<UserEntry> friendLists= userDao.findFriend(userID);
            userDao.close();
            request.setAttribute("friendLists",friendLists);
            request.getRequestDispatcher("/friendList.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
