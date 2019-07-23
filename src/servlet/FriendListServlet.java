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

@WebServlet(name = "FriendListServlet",value = "/friendList")
public class FriendListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserEntry user= (UserEntry)session.getAttribute("user");
        int userID= user.getId();

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

            //同意好友请求
            if(request.getParameter("agree_ID")!=null){
                String a = request.getParameter("agree_ID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.agree(sendFrom_ID,user.getId());
            }

            //拒绝好友请求
            if(request.getParameter("reject_ID")!=null){
                String a = request.getParameter("reject_ID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.reject(sendFrom_ID,user.getId());
            }

            //更新表
            List<UserEntry> friendLists= userDao.findFriend(user.getId());
            List<UserEntry> strangeLists = userDao.findFriendRequest(userID);

            request.setAttribute("friendLists",friendLists);
            request.setAttribute("strangeLists",strangeLists);
            request.getRequestDispatcher("/friendList.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
