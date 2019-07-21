package dao;

import bean.Message;

import java.util.List;

public interface MessageDao {

    public void sendMessage(int userID,int friendID,String message)throws Exception;

    public List<Message> getMessageList(int userID,int friendID)throws Exception;

}
