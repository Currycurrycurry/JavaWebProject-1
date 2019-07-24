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

@WebServlet(name = "InsertUserServlet",value = "/insertUser")
public class InsertUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//      request.setCharacterEncoding("UTF-8");
//      response.setContentType("text/html;charset=utf8");

        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String sName = request.getParameter("name");
        String name = new String(sName.getBytes("ISO8859_1"), StandardCharsets.UTF_8);
        String email = request.getParameter("email");
        String is = request.getParameter("isAdmin");
        int isAdmin = Integer.parseInt(is);

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(account);
            if(userEntry == null){
                //注册成功
                userEntry = new UserEntry(account,password,name,email,"",isAdmin==1);
                userEntry.updateLoginTime();
                userDao.insertAccount(userEntry);
                userDao.close();
                response.getWriter().print("success");
            }else {
                //用户名已经存在
                response.getWriter().print("exist");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
