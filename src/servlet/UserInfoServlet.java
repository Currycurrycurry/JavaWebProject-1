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

@WebServlet(name = "UserInfoServlet", value="/UserInfo")
public class UserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String sName = request.getParameter("name");
        String name = new String( sName.getBytes("ISO8859_1"), StandardCharsets.UTF_8);
        String email = request.getParameter("email");
        String signature1 = request.getParameter("textarea");
        String signature = new String(signature1.getBytes("ISO8859_1"),StandardCharsets.UTF_8);

        HttpSession session = request.getSession();
        UserEntry userEntry = (UserEntry)session.getAttribute("user");

        userEntry.setName(name);
        userEntry.setEmail(email);
        userEntry.setSignature(signature);

        try {
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            userDao.updateInfo(userEntry);
            response.sendRedirect("/userInformation.jsp");
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
