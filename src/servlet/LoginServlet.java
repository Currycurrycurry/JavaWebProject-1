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

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:01
 */
@WebServlet(name = "LoginServlet",value = "/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        request.setCharacterEncoding("UTF-8");
//        response.setContentType("text/html;charset=utf8");

        String account = request.getParameter("account");
        String password = request.getParameter("password");

        System.out.println(account);
        System.out.println(password);

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(account);
            if(userEntry!=null){
                String pass = userEntry.getPassword();
                MD5Test md5Test = new MD5Test();
                String pwd = md5Test.getMD5(pass);
                System.out.println(pwd);

                if(pwd.equalsIgnoreCase(password)){
                    //正确的登录
                    userEntry.updateLoginTime();
                    userDao.updateLoginTime(userEntry);
                    HttpSession session = request.getSession();
                    session.setAttribute("user",userEntry);
                    response.getWriter().print(true);
                }

            }else{
                response.getWriter().print(false);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
}
