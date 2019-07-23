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
import java.util.List;

@WebServlet(name = "UserInfoServlet", value="/userInfo")
public class UserInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserEntry userEntry = (UserEntry)session.getAttribute("user");

        try {
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

            //修改信息
            if(request.getParameter("name")!=null){
                String sName = request.getParameter("name");
                String name = new String( sName.getBytes("ISO8859_1"), StandardCharsets.UTF_8);
                String email = request.getParameter("email");
                String signature1 = request.getParameter("signature");
                String signature = new String(signature1.getBytes("ISO8859_1"),StandardCharsets.UTF_8);
                String password = request.getParameter("password");

                if(password!=null&&password.equals(userEntry.getPassword())){
                    userEntry.setName(name);
                    userEntry.setEmail(email);
                    userEntry.setSignature(signature);
                    userDao.updateInfo(userEntry);
                    response.getWriter().print(true);
                }else{
                    response.getWriter().print(false);
                }
            }

            //同意好友请求
            if(request.getParameter("agreeID")!=null){
                String a = request.getParameter("agreeID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.agree(sendFrom_ID,userEntry.getId());
                doGet(request,response);
            }

            //拒绝好友请求
            if(request.getParameter("rejectID")!=null){
                String a = request.getParameter("rejectID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.reject(sendFrom_ID,userEntry.getId());
                doGet(request,response);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry user = (UserEntry)session.getAttribute("user");
        List<UserEntry> strangeLists;

        try {
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            strangeLists = userDao.findFriendRequest(user.getId());
            request.setAttribute("strangeLists",strangeLists);
            request.getRequestDispatcher("/userInformation.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
