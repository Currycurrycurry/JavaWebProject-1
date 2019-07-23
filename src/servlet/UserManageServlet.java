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

        HttpSession session = request.getSession();
        UserEntry userEntry1 = (UserEntry)session.getAttribute("user");

        if(userEntry1.isAdmin()){
            try{
                UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

                //删除用户
                if (request.getParameter("deleteUserId") != null) {
                    String deleteUserString = request.getParameter("deleteUserId");
                    int deleteUserId = Integer.parseInt(deleteUserString);
                    userDao.deleteAccount(deleteUserId);
                }

                //提升管理
                if (request.getParameter("improveAdmin")!= null) {
                    String improveAdmin = request.getParameter("improveAdmin");
                    int id = Integer.parseInt(improveAdmin);
                    userDao.updateAdmin(id,true);
                }

                //降级
                if(request.getParameter("changeAdmin")!=null){
                    String changeAdmin = request.getParameter("changeAdmin");
                    int id = Integer.parseInt(changeAdmin);
                    userDao.updateAdmin(id,false);
                }

                response.sendRedirect("/userManage.jsp");
            }catch (Exception e){
                e.printStackTrace();
            }
        }else{
            response.sendRedirect("/index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry user = (UserEntry)session.getAttribute("user");
        if(user.isAdmin()){
            try{
                UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

                List<UserEntry> userEntries= userDao.findAll(user.getId());
                request.setAttribute("userManage",userEntries);
                request.getRequestDispatcher("/userManage.jsp").forward(request,response);
            }catch (Exception e){
                e.printStackTrace();
            }
        }else{
            response.sendRedirect("/index.jsp");
        }
    }
}
