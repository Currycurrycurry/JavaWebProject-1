package database;

import java.sql.*;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:15
 */
public class DBConnection {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/javaWeb?useSSL=false&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "yanghui";
    private Connection connection = null;

    public DBConnection (){
        try{
            Class.forName(DRIVER);
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }

        try{
            this.connection = DriverManager.getConnection(URL,USER,PASSWORD);
        }catch (SQLException e){
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return connection;
    }
     public void close() throws Exception{
        if(this.connection != null){
            this.connection.close();
        }
     }

}
