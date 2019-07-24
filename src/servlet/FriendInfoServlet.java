package servlet;

import bean.Item;
import bean.UserEntry;
import dao.CollectionDaoImpl;
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

@WebServlet(name = "FriendInfoServlet",value = "/friendInfo")
public class FriendInfoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String ID = request.getParameter("friend-id");
        int friendID = Integer.parseInt(ID);

        HttpSession session = request.getSession();
        UserEntry user = (UserEntry)session.getAttribute("user");

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            String opt = request.getParameter("opt");
            if("delete".equals(opt)){
                userDao.deleteFriend(user.getId(),friendID);
                response.sendRedirect("/friendInformation.jsp?friendId="+ID);
            }else if("agree".equals(opt)){
                userDao.agree(friendID,user.getId());
                response.sendRedirect("/friendInformation.jsp?friendId="+ID);
            }else if("send".equals(opt)){
                userDao.sendRequest(user.getId(),friendID);
                response.sendRedirect("/friendInformation.jsp?friendId="+ID);
            }
            userDao.close();
        }catch (Exception e){
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String friend = request.getParameter("friendId");
        int friendID = Integer.parseInt(friend);
        HttpSession session = request.getSession();
        UserEntry user = (UserEntry)session.getAttribute("user");
        UserEntry userEntry;
        int relation;

        try{
            UserDaoImpl userDao = DaoFactory.getUserDaoInstance();
            CollectionDaoImpl collectionDao = DaoFactory.getCollectionDaoInstance();
            List<Item> friendCollections = collectionDao.findCollection(friendID,true);
            userEntry = userDao.findById(friendID);

            relation=userDao.isFriendOrRequest(user.getId(),friendID);
            request.setAttribute("relation",relation);
            request.setAttribute("friendInformation",userEntry);
            request.setAttribute("friendCollections",friendCollections);
            request.getRequestDispatcher("/friendInformation.jsp?friendId="+friend).forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
