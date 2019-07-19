package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * @author: YXH
 * @date: 2019/7/19
 * @time: 16:32
 */
public class CollectionDaoImpl implements CollectionDao {
    private Connection connection = null;
    private PreparedStatement statement = null;

    public CollectionDaoImpl(Connection connection){
        this.connection = connection;
    }

    @Override
    public void insertCollection(int userId, int itemId, boolean isPublic) throws Exception {
        String sql = "INSERT INTO collection (userID, itemID, isPublic) VALUES ("+userId+","+itemId+","+isPublic+")";
        statement = connection.prepareStatement(sql);
        statement.executeUpdate();
        System.out.println(sql);
    }

    @Override
    public void deleteCollection(int userId, int itemId) throws Exception {
        String sql = "DELETE FROM collection WHERE userID = "+userId+" AND itemID = "+itemId;
        statement = connection.prepareStatement(sql);
        statement.executeUpdate();
    }
}
