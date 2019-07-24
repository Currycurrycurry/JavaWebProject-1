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
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MessageServlet",value = "/message")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry userEntry = (UserEntry)session.getAttribute("user");
        int userID = userEntry.getId();

        String friend = request.getParameter("friend");
        int friendID = Integer.parseInt(friend);


        if(request.getParameter("message")!=null){
            String mess = request.getParameter("message");
            String message = new String(mess.getBytes("ISO8859_1"), StandardCharsets.UTF_8);

            try{
                MessageDaoImpl messageDao = DaoFactory.getMessageDaoInstance();

                if( !("".equals(message)) ){
                    messageDao.sendMessage(userID,friendID,message);
                }

            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserEntry userEntry = (UserEntry)session.getAttribute("user");
        int userID = userEntry.getId();
        List<Message> messageList;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf8");

        String friend = request.getParameter("friend");
        int friendID = Integer.parseInt(friend);

        PrintWriter out = response.getWriter();

        try{
            MessageDaoImpl messageDao = DaoFactory.getMessageDaoInstance();
            String friendName = messageDao.searchFriend(friendID);

            if(messageDao.isFriend(userID,friendID)){
                request.removeAttribute("error");
                messageList = messageDao.getMessageList(userID,friendID);
                String html = setHtml(userEntry.getName(),friendID,friendName,messageList);
                out.print(html);
                messageDao.close();
            }else{
                System.out.println("不是好友！");
                request.setAttribute("error","不是好友!");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private String setHtml(String userName,int friendID,String friendName,List<Message> messageList){

        String html ="<div class=\"container\">";
        for(Message message:messageList){
            if(friendID == message.getUserID()){
                html = html + "<div class=\"row\"><div class=\"col-6\"><label style=\"color: cornflowerblue\">"
                        +friendName + "&emsp;&emsp;"+ message.getSendTime() + "</label><br><label>"
                        +message.getMess()+"</label></div><div class=\"col-6\"></div></div>";
            }else{
                html = html + "<div class=\"row\"><div class=\"col-6\"></div><div class=\"col-6\">"+
                        "<label style=\"color: cornflowerblue\">" + userName +"&emsp;&emsp;"+
                        message.getSendTime()+"</label><br><label>"+message.getMess()+"</label></div></div>";
            }
        }
        html = html+"</div>";
        return html;
    }
}


