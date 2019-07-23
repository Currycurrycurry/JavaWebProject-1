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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "SearchUserServlet",value = "/searchUser")
public class SearchUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserEntry user = (UserEntry)session.getAttribute("user");
        int userID = user.getId();

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

            //添加用户
            if(request.getParameter("addUserID")!=null){
                String addUser_ID = request.getParameter("addUserID");
                int add_user_id = Integer.parseInt(addUser_ID);
                userDao.sendRequest(userID,add_user_id);
            }

            //删除好友
            if(request.getParameter("deleteFriendID")!=null){
                String friendString = request.getParameter("deleteFriendID");
                int friend_ID = Integer.parseInt(friendString);
                userDao.deleteFriend(userID,friend_ID);
            }

            //同意好友请求
            if(request.getParameter("agreeID")!=null){
                String a = request.getParameter("agreeID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.agree(sendFrom_ID,user.getId());
            }

            //拒绝好友请求
            if(request.getParameter("rejectID")!=null){
                String a = request.getParameter("rejectID");
                int sendFrom_ID = Integer.parseInt(a);
                userDao.reject(sendFrom_ID,user.getId());
            }

            doGet(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry user= (UserEntry)session.getAttribute("user");
        int userID= user.getId();
        String name = "";
        HashMap<UserEntry,Integer> userLists;
        HashMap<UserEntry,Integer> sameFriendLists;

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();

            //查找用户
            if(request.getParameter("searchName")!=null){
                name = request.getParameter("searchName");
//                name = new String(sName.getBytes("ISO8859_1"), StandardCharsets.UTF_8);
            }

            //更新表
            userLists = userDao.searchUser(user.getId(),name);
            sameFriendLists = userDao.findSameFriendLists(userID);

            request.setAttribute("userLists",userLists);
            request.setAttribute("searchName",name);
            request.setAttribute("sameFriendLists",sameFriendLists);
            request.getRequestDispatcher("/friendSearch.jsp?searchName="+name).forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
