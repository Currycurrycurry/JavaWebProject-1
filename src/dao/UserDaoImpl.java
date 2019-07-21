package dao;

import bean.UserEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:25
 */
public class UserDaoImpl implements UserDao {
    private Connection connection = null;
    private PreparedStatement statement = null;


    public UserDaoImpl(Connection connection){
        this.connection = connection;
    }

    @Override
    public UserEntry findByAccount(String account) throws Exception{
        UserEntry userEntry = null;
        String sql = "SELECT * FROM users WHERE account = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1,account);
        ResultSet re = statement.executeQuery();

        if(re.next()){
            userEntry = new UserEntry();
            userEntry.setId(re.getInt("userID"));
            userEntry.setAccount(re.getString("account"));
            userEntry.setName(re.getString("name"));
            userEntry.setEmail(re.getString("email"));
            userEntry.setSignature(re.getString("signature"));
            userEntry.setAdmin(re.getBoolean("isAdmin"));
            userEntry.setPassword(re.getString("password"));
        }
        return userEntry;
    }

    @Override
    public List<UserEntry> findAll(int userID)throws Exception{
        List<UserEntry> userEntries=new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY isAdmin DESC";
        statement = connection.prepareStatement(sql);
        ResultSet re =  statement.executeQuery();
        while (re.next()){
            if(userID == re.getInt("userID")){
                continue;
            }

            UserEntry userEntry1 = new UserEntry();
            userEntry1.setProperties(re.getInt("userID"),
                    re.getString("account"),re.getBoolean("isAdmin"),
                    re.getString("email"),re.getString("name"),
                    re.getTimestamp("loginTime"));

            userEntries.add(userEntry1);
        }
        return userEntries;
    }

    @Override
    public void updateLoginTime(UserEntry userEntry) throws Exception{
        String sql = "UPDATE users SET loginTime = ? WHERE userID = ?";
        statement = connection.prepareStatement(sql);
        statement.setTimestamp(1,userEntry.getLoginTime());
        statement.setInt(2,userEntry.getId());
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Update loginTime success!");
        }else{
            System.out.println("Update loginTime failed!");
        }
    }

    @Override
    public void updateInfo(UserEntry userEntry)throws Exception{
        String sql = "UPDATE users SET name = ?,signature=?,email=? WHERE userID = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1,userEntry.getName());
        statement.setString(2,userEntry.getSignature());
        statement.setString(3,userEntry.getEmail());
        statement.setInt(4,userEntry.getId());
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Update user information success!");
        }else{
            System.out.println("Update user information failed!");
        }
    }

    @Override
    public void updateAdmin(int userID,boolean isAdmin)throws Exception{
        String sql = "UPDATE users SET isAdmin = ? WHERE userID = ?";
        statement = connection.prepareStatement(sql);
        statement.setBoolean(1,isAdmin);
        statement.setInt(2,userID);
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Update user admin success!");
        }else{
            System.out.println("Update user admin failed!");
        }
    }

    @Override
    public void deleteAccount(int userID)throws Exception{
        String sql = "DELETE FROM users WHERE userID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userID);
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Delete user success!");
        }else{
            System.out.println("Delete user failed!");
        }
    }

    @Override
    public void sendRequest(int sendFrom_ID,int sendTo_ID)throws Exception{
        String sql = "SELECT * FROM friendRequest WHERE sendFrom_ID = ? AND sendTo_ID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,sendFrom_ID);
        statement.setInt(2,sendTo_ID);
        ResultSet re =  statement.executeQuery();

        if(!re.next()){
            String sql1 = "INSERT into friendRequest(sendFrom_ID, sendTo_ID) values(?,?)";
            statement = connection.prepareStatement(sql1);
            statement.setInt(1,sendFrom_ID);
            statement.setInt(2,sendTo_ID);
            statement.executeUpdate();
        }
    }

    @Override
    public void reject(int sendFrom_ID,int sendTo_ID)throws Exception{
        String sql = "DELETE FROM friendRequest WHERE sendFrom_ID = ? AND sendTo_ID = ?";
        statement=connection.prepareStatement(sql);
        statement.setInt(1,sendFrom_ID);
        statement.setInt(2,sendTo_ID);

        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("reject success!");
        }else{
            System.out.println("reject failed!");
        }

    }

    @Override
    public void agree(int sendFrom_ID,int sendTo_ID)throws Exception{
        String sql = "DELETE FROM friendRequest WHERE sendFrom_ID = ? AND sendTo_ID = ?";
        statement=connection.prepareStatement(sql);
        statement.setInt(1,sendFrom_ID);
        statement.setInt(2,sendTo_ID);

        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("agree success!");
        }else{
            System.out.println("agree failed!");
        }

        sql = "INSERT into friendRelation(userID, friendID) values(?,?)";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,sendTo_ID);
        statement.setInt(2,sendFrom_ID);
        row = statement.executeUpdate();
        if(row>0){
            System.out.println("add friend success!");
        }else{
            System.out.println("add friend failed!");
        }
    }

    @Override
    public void insertAccount(UserEntry userEntry)throws Exception{
        String sql = "INSERT into users(account,name,email,signature,isAdmin,password,loginTime) values(?,?,?,?,?,?,?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1,userEntry.getAccount());
        statement.setString(2,userEntry.getName());
        statement.setString(3,userEntry.getEmail());
        statement.setString(4,userEntry.getSignature());
        statement.setBoolean(5,userEntry.isAdmin());
        statement.setString(6,userEntry.getPassword());
        statement.setTimestamp(7,userEntry.getLoginTime());
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Sign success!");
        }else{
            System.out.println("Sign failed!");
        }
    }

    @Override
    public List<UserEntry> findFriend(int userID)throws Exception{
        List<UserEntry> userEntries;
        List<Integer> userIDs = new ArrayList<>();

        String sql = "SELECT * FROM friendRelation WHERE userID = ?";
        statement=connection.prepareStatement(sql);
        statement.setInt(1,userID);
        ResultSet resultSet =  statement.executeQuery();

        while (resultSet.next()){
            int user = resultSet.getInt("friendID");
            userIDs.add(user);
        }

        userEntries = getAllUser(userIDs);
        return userEntries;
    }

    @Override
    public void deleteFriend(int userID,int friendID)throws Exception{
        String sql = "DELETE FROM friendRelation WHERE userID = ? AND friendID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userID);
        statement.setInt(2,friendID);
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Delete friend success!");
        }else{
            System.out.println("Delete friend failed!");
        }
    }

    @Override
    public List<UserEntry> findFriendRequest(int sendTo_ID)throws Exception{
        List<UserEntry> userEntries;
        List<Integer> userIDs = new ArrayList<>();
        String sql = "SELECT * FROM friendRequest WHERE sendTo_ID = ?";
        statement=connection.prepareStatement(sql);
        statement.setInt(1,sendTo_ID);
        ResultSet resultSet =  statement.executeQuery();

        while (resultSet.next()){
            int user = resultSet.getInt("sendFrom_ID");
            userIDs.add(user);
        }

        userEntries = getAllUser(userIDs);
        return userEntries;
    }

    @Override
    public HashMap<UserEntry,Integer> findUser(int userID,String searchName)throws Exception{
        HashMap<UserEntry,Integer> userLists = new HashMap<>();
        String sql = "SELECT * FROM users WHERE name LIKE ?";
        statement=connection.prepareStatement(sql);
        statement.setString(1,"%"+searchName+"%");
        ResultSet re = statement.executeQuery();

        while ((re.next())){
            UserEntry user = new UserEntry();
            int user2 = re.getInt("userID");

            user.setId(user2);
            user.setName(re.getString("name"));
            int isFriend = isFriend(userID,user2);
            userLists.put(user,isFriend);
        }

        return userLists;
    }

    private List<UserEntry> getAllUser(List<Integer> list)throws Exception{
        List<UserEntry> userEntries = new ArrayList<>();
        PreparedStatement st;
        ResultSet re;

        for(int i:list){
            String sql1 = "SELECT * FROM users WHERE userID = ?";
            st=connection.prepareStatement(sql1);
            st.setInt(1,i);
            re = st.executeQuery();

            if(re.next()){
                UserEntry userEntry = new UserEntry();
                userEntry.setProperties(re.getInt("userID"),
                        re.getString("account"),re.getBoolean("isAdmin"),
                        re.getString("email"),re.getString("name"),
                        re.getTimestamp("loginTime"));
                userEntries.add(userEntry);
            }
        }
        return userEntries;
    }

    //判断user2 是不是 user1 的好友  1-是好友   0-user1已经发送请求  -1-其他情况
    private int isFriend(int user1,int user2)throws Exception{
        String sql1 = "SELECT * FROM friendRelation WHERE userID = ? AND friendID = ?";
        PreparedStatement st;
        st=connection.prepareStatement(sql1);
        st.setInt(1,user1);
        st.setInt(2,user2);
        ResultSet re = st.executeQuery();
        if(re.next()) return 1;

        sql1 = "SELECT * FROM friendRequest WHERE sendFrom_ID = ? AND sendTo_ID = ?";
        st=connection.prepareStatement(sql1);
        st.setInt(1,user1);
        st.setInt(2,user2);
        re=st.executeQuery();
        if(re.next()) return 0;



        return -1;
    }


}
