package servlet;

import bean.UserEntry;
import dao.UserDaoImpl;
import factory.DaoFactory;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "SignServlet",value = "/sign")
public class SignServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String email_address = request.getParameter("email_address");

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(account);
            if(userEntry == null){
                //注册成功
                HttpSession session = request.getSession();
                UserDaoImpl userDao1 = DaoFactory.getUserDaoInstance();
                UserEntry user1 = new UserEntry(account,password,name,email_address,"",false);
                userDao1.insertAccount(user1);
                session.setAttribute("user",user1);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
                dispatcher.forward(request,response);
            }else {
                //用户名已经存在
                System.out.println("account is exist");
                request.setAttribute("exist",account);
                request.getRequestDispatcher("signup.jsp").forward(request,response);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
