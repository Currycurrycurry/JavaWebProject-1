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
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "FriendListServlet",value = "/friendList")
public class FriendListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserEntry user= (UserEntry)session.getAttribute("user");
        int userID= user.getId();
        String name = "";

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

            //添加搜索到的用户
            if(request.getParameter("addUser_ID")!=null){
                String addUser_ID = request.getParameter("addUser_ID");
                int add_user_id = Integer.parseInt(addUser_ID);
                userDao.sendRequest(userID,add_user_id);
                request.removeAttribute("addUser_ID");
            }

            //查找用户
            if(request.getParameter("searchName")!=null){
                name = request.getParameter("searchName");
            }


            //删除好友
            if(request.getParameter("deleteFriend_ID")!=null){
                String friendString = request.getParameter("deleteFriend_ID");
                int friend_ID = Integer.parseInt(friendString);
                userDao.deleteFriend(userID,friend_ID);
                request.removeAttribute("deleteFriend_ID");
            }

            //添加陌生人
            if(request.getParameter("addUser_ID")!=null){
                String a = request.getParameter("addUser_ID");
                int sendTo_ID = Integer.parseInt(a);
                userDao.sendRequest(user.getId(),sendTo_ID);
                request.removeAttribute("addUser_ID");
            }

            //同意好友请求
            if(request.getParameter("agree_ID")!=null){
                String a = request.getParameter("agree_ID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.agree(sendFrom_ID,user.getId());
                request.removeAttribute("agree_ID");
            }

            //拒绝好友请求
            if(request.getParameter("reject_ID")!=null){
                String a = request.getParameter("reject_ID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.reject(sendFrom_ID,user.getId());
                request.removeAttribute("reject_ID");
            }

            //更新表
            List<UserEntry> friendLists= userDao.findFriend(user.getId());
            List<UserEntry> strangeLists = userDao.findFriendRequest(user.getId());
            HashMap<UserEntry,Integer> userLists = userDao.findUser(user.getId(),name);

            request.setAttribute("searchName",name);
            request.setAttribute("userLists",userLists);
            request.setAttribute("friendLists",friendLists);
            request.setAttribute("strangeLists",strangeLists);
            request.getRequestDispatcher("/friendList.jsp").forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
