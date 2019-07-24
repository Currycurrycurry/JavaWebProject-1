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
import java.nio.charset.StandardCharsets;

@WebServlet(name = "SignServlet",value = "/sign")
public class SignServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

//      request.setCharacterEncoding("UTF-8");
//      response.setContentType("text/html;charset=utf8");

        HttpSession session = request.getSession();

        String account = request.getParameter("account");
        String password = request.getParameter("password");
        String sName = request.getParameter("name");
        String name = new String(sName.getBytes("ISO8859_1"),StandardCharsets.UTF_8);
        String email = request.getParameter("email");
        String code  = request.getParameter("code");

        String sessionVerifyCode = (String)request.getSession().getAttribute("vCode");
        boolean isTrue = code.equalsIgnoreCase(sessionVerifyCode);

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            UserEntry userEntry = userDao.findByAccount(account);
            if(userEntry == null){
                if(!isTrue){
                    response.getWriter().print("vCode");
                }else{
                    //注册成功
                    userEntry = new UserEntry(account,password,name,email,"",false);
                    userEntry.updateLoginTime();
                    userDao.insertAccount(userEntry);
                    session.setAttribute("user",userEntry);
                    response.getWriter().print("success");
                    userDao.close();
                }
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
