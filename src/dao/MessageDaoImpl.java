package dao;

import bean.Message;
import bean.UserEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MessageDaoImpl implements MessageDao{
    private Connection connection = null;
    private PreparedStatement statement = null;

    public MessageDaoImpl(Connection connection){
        this.connection = connection;
    }

    @Override
    public void sendMessage(int userID,int friendID,String message)throws Exception{
        if(message!=null && !("".equals(message))){
            String sql = "INSERT into message(userID, friendID, message) values(?,?,?);";
            statement= connection.prepareStatement(sql);
            statement.setInt(1,userID);
            statement.setInt(2,friendID);
            statement.setString(3,message);
            statement.executeUpdate();
        }
    }

    @Override
    public List<Message> getMessageList(int userID, int friendID)throws Exception{
        return getMessage(userID,friendID);
    }

    private List<Message> getMessage(int userID,int friendID)throws Exception{
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM message WHERE (userID = ? AND friendID = ?)OR (userID = ? AND friendID = ?) ORDER BY timeReleased";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userID);
        statement.setInt(2,friendID);
        statement.setInt(3,friendID);
        statement.setInt(4,userID);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()){
            Message message = new Message();
            message.setAll(resultSet.getInt("userID"),resultSet.getInt("friendID"),
                    resultSet.getString("message"), resultSet.getTimestamp("timeReleased"));
            messages.add(message);
        }
        return messages;
    }

    public String searchFriend(int friendID)throws Exception{
        String name = "";
        String sql = "SELECT * FROM users WHERE userID = ?";
        statement=connection.prepareStatement(sql);
        statement.setInt(1,friendID);
        ResultSet re = statement.executeQuery();

        if(re.next()){
            name = re.getString("name");
        }
        return name;
    }

    public boolean isFriend(int userID,int friendID)throws Exception{
        String sql = "SELECT * FROM friendRelation WHERE userID = ? AND friendID = ?";
        PreparedStatement statement1 = connection.prepareStatement(sql);
        statement1.setInt(1,userID);
        statement1.setInt(2,friendID);
        ResultSet re = statement1.executeQuery();
        return re.next();
    }
}
