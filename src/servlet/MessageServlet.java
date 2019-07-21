package servlet;

import bean.Message;
import bean.UserEntry;
import dao.MessageDao;
import dao.MessageDaoImpl;
import factory.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MessageServlet",value = "/message")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry userEntry = (UserEntry)session.getAttribute("user");
        int userID = userEntry.getId();

        String friend = request.getParameter("friend");
        String message = request.getParameter("message");
        int friendID = Integer.parseInt(friend);

        try{
            MessageDaoImpl messageDao = DaoFactory.getMessageDaoInstance();
            String friendName = messageDao.searchFriend(friendID);

            if(message!=null){
                messageDao.sendMessage(userID,friendID,message);
                response.sendRedirect("/message.jsp?friend="+friend);
            }

            List<Message> messageList = messageDao.getMessageList(userID,friendID);
            request.setAttribute("friendName",friendName);
            request.setAttribute("messageLists",messageList);
            request.getRequestDispatcher("/message.jsp?friend="+friend).forward(request,response);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
