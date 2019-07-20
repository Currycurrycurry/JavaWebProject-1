package dao;

import bean.UserEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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



}
