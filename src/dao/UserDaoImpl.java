package dao;

import bean.UserEntry;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
    public void insertAccount(UserEntry userEntry)throws Exception{
        String sql = "INSERT into users(account,name,email,signature,isAdmin,password) values(?,?,?,?,?,?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1,userEntry.getAccount());
        statement.setString(2,userEntry.getName());
        statement.setString(3,userEntry.getEmail());
        statement.setString(4,userEntry.getSignature());
        statement.setBoolean(5,userEntry.isAdmin());
        statement.setString(6,userEntry.getPassword());
        int row = statement.executeUpdate();
        if(row>0){
            System.out.println("Sign success!");
        }
    }
}
