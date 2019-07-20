package servlet;

import bean.UserEntry;
import dao.UserDaoImpl;
import factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManageServlet",value="/userManage")
public class UserManageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            int userID = (int)session.getAttribute("user");
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            List<UserEntry> userEntries= userDao.findAll(userID);
            request.setAttribute("userManage",userEntries);
            request.getRequestDispatcher("/userManage.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
