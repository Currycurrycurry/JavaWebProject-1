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
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "UserManageServlet",value="/userManage")
public class UserManageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            String account = request.getParameter("account");
            String password = request.getParameter("password");
            String sName = request.getParameter("name");
            String name = new String(sName.getBytes("ISO8859_1"), StandardCharsets.UTF_8);
            String email = request.getParameter("email");
            String admin = request.getParameter("isAdmin");
            boolean isAdmin = "1".equals(admin);

            UserEntry userEntry = new UserEntry(account,password,name,email,"",isAdmin);
            userEntry.updateLoginTime();
            userDao.insertAccount(userEntry);
            response.sendRedirect("/userManage.jsp");

        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            String deleteUserString = request.getParameter("deleteUserId");
            String userIdString = request.getParameter("userId");
            String changeAdmin = request.getParameter("changeAdmin");

            if(deleteUserString!=null){
                int deleteUserId = Integer.parseInt(deleteUserString);
                userDao.deleteAccount(deleteUserId);
                request.removeAttribute("deleteUserId");
            }

            if(userIdString!=null){
                int userID = Integer.parseInt(userIdString);
                if("false".equals(changeAdmin)){
                    userDao.updateAdmin(userID,false);
                }else{
                    userDao.updateAdmin(userID,true);
                }
                request.removeAttribute("userId");
                request.removeAttribute("changeAdmin");
            }

            HttpSession session = request.getSession();
            UserEntry user= (UserEntry)session.getAttribute("user");
            List<UserEntry> userEntries= userDao.findAll(user.getId());
            request.setAttribute("userManage",userEntries);
            request.getRequestDispatcher("/userManage.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
