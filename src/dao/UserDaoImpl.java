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
}
