import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author: YXH
 * @date: 2019/7/15
 * @time: 15:15
 */
public class Main {
    public static void main(String[] args){
        System.out.println("-------MySQL JDBC Connection Testing-------");
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }

        System.out.println("MySQL JDBC Driver Registered!");
        Connection connection = null;
        try{
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/javaWeb?useSSL=false","root","yanghui");
            System.out.println(connection);
        }catch (SQLException e){
            System.out.println("Connection Failed, Check output console");
            e.printStackTrace();
        }
    }
}
