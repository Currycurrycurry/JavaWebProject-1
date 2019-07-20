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
import java.nio.charset.StandardCharsets;

@WebServlet(name = "SignServlet",value = "/sign")
public class SignServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] array = new String[5];

        array[0] = request.getParameter("account");
        array[1] = request.getParameter("password");
        String sName = request.getParameter("name");
        array[2] = new String(sName.getBytes("ISO8859_1"),StandardCharsets.UTF_8);
        array[3] = request.getParameter("email");
        array[4] = request.getParameter("code");

        String sessionVerifyCode = (String)request.getSession().getAttribute("vCode");
        boolean isTrue = array[4].equalsIgnoreCase(sessionVerifyCode);

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(array[0]);
            if(userEntry == null){
                if(!isTrue){
                    System.out.println("code is not current");
                    request.setAttribute("array",array);
                    request.setAttribute("vCode","验证码错误！");
                    request.getRequestDispatcher("signup.jsp").forward(request,response);
                }else{
                    //注册成功
                    HttpSession session = request.getSession();
                    userEntry = new UserEntry(array[0],array[1],array[2],array[3],"",false);
                    userEntry.updateLoginTime();
                    userDao.insertAccount(userEntry);
                    session.setAttribute("user",userEntry);
                    response.sendRedirect("/index.jsp");}
            }else {
                //用户名已经存在
                System.out.println("account is exist");
                request.setAttribute("array",array);
                request.setAttribute("account_exist","账号已经存在！");
                request.getRequestDispatcher("signup.jsp").forward(request,response);
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
