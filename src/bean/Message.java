package bean;

import java.sql.Timestamp;

public class Message {
    private int userID;
    private int friendID;
    private String mess;
    private Timestamp sendTime;

    public Message(){

    }

    public void setUserID(int userID){
        this.userID=userID;
    }

    public void setFriendID(int friendID){
        this.friendID = friendID;
    }

    public void setMess(String mess){
        this.mess=mess;
    }

    public void setSendTime(Timestamp time){
        sendTime=time;
    }

    public int getUserID(){return userID;}

    public int getFriendID(){return friendID;}

    public String getMess(){return mess;}

    public Timestamp getSendTime(){return sendTime;}

    public void setAll(int userID,int friendID,String mess,Timestamp time){
        setUserID(userID);
        setFriendID(friendID);
        setMess(mess);
        setSendTime(time);
    }
}
