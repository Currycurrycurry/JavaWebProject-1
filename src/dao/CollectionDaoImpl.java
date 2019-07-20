package dao;

import bean.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
        String sql = "INSERT INTO collection (userID, itemID, isPublic) VALUES (?,?,?)";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userId);
        statement.setInt(2,itemId);
        statement.setBoolean(3,isPublic);
        statement.executeUpdate();
        System.out.println(sql);
    }

    @Override
    public void deleteCollection(int userId, int itemId) throws Exception {
        String sql = "DELETE FROM collection WHERE userID = ? AND itemID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userId);
        statement.setInt(2,itemId);
        statement.executeUpdate();
    }

    @Override
    public List<Item> findCollection(int useId, boolean isPublic) throws Exception {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT item.*,collection.timeReleased FROM item,collection,users WHERE users.userID = ? AND users.userID=collection.userID AND item.itemID=collection.itemID AND collection.isPublic= ? ORDER BY collection.timeReleased DESC LIMIT 15";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,useId);
        statement.setBoolean(2,isPublic);
        ResultSet re = statement.executeQuery();
        while (re.next()){
            Item item = new Item();
            item.setProperties(re.getInt("itemID"),re.getString("name"),
                    re.getString("imagePath"),re.getString("description"),
                    re.getString("address"),re.getInt("view"),
                    re.getTimestamp("collection.timeReleased"),re.getString("year"));
            items.add(item);
        }
        return items;
    }

    @Override
    public void changePublicity(int userId, int itemId) throws Exception {
        String sql = "SELECT collection.isPublic FROM collection WHERE userID = ? AND itemID= ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,userId);
        statement.setInt(2,itemId);
        ResultSet re = statement.executeQuery();
        if(re.next()){
            if(re.getBoolean("isPublic")){
                sql = "UPDATE collection SET isPublic=FALSE WHERE userID = ? AND itemID = ?";
            }else {
                sql = "UPDATE collection SET isPublic=TRUE WHERE userID = ? AND itemID=?";
            }
            statement = connection.prepareStatement(sql);
            statement.setInt(1,userId);
            statement.setInt(2,itemId);
            statement.executeUpdate();
        }
    }
}
