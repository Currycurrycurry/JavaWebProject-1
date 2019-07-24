package dao;

import bean.Item;

import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/18
 * @time: 17:04
 */
public class ItemDaoImpl implements ItemDao {
    public static final int PAGE_SIZE = 8;
    private Connection connection = null;
    private PreparedStatement statement = null;

    public ItemDaoImpl(Connection connection){
        this.connection = connection;
    }

    @Override
    public Item findByName(String name) throws Exception {
        return null;
    }

    @Override
    public Item findById(int itemId) throws Exception {
        Item item = null;
        String sql = "SELECT * FROM item WHERE itemID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,itemId);
        ResultSet re = statement.executeQuery();
        if(re.next()){
            item = new Item();
            item.setProperties(re.getInt("itemID"),re.getString("name"),
                    re.getString("imagePath"),re.getString("description"),
                    re.getString("address"),re.getInt("view"),
                    re.getTimestamp("timeReleased"),re.getString("year"),
                    re.getString("videoPath"));
        }
        return item;
    }

    @Override
    public int insertItem(Item item) throws Exception {
        String sql = "INSERT INTO item (name,address,year,description,imagePath,videoPath) VALUES" +
                " ( '"+item.getName()+"' , '"+item.getAddress()+"' , '"+item.getYear()+"' , '"+item.getDescription()+"' , '"+item.getImagePath()+"' , '"+item.getVideoPath()+"')";
        statement = connection.prepareStatement(sql);
        statement.executeUpdate();
        sql = "select max(itemID) from item";
        statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        if(resultSet.next()){
            return resultSet.getInt(1);
        }
        return 1;
    }

    @Override
    public List<Item> getItemsOrdered(int numberOfItems, String orderPara) throws Exception{
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM item ORDER BY `"+orderPara+"` DESC LIMIT ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,numberOfItems);
        ResultSet re = statement.executeQuery();
        while (re.next()){
            Item item = new Item();
            item.setProperties(re.getInt("itemID"),re.getString("name"),
                    re.getString("imagePath"),re.getString("description"),
                    re.getString("address"),re.getInt("view"),
                    re.getTimestamp("timeReleased"),re.getString("year"),
                    re.getString("videoPath"));
            items.add(item);
        }
        return items;
    }

    @Override
    public boolean isCollectedByUser(int itemID, int userID) throws Exception {
        boolean flag = false;
        String sql = "SELECT * FROM collection WHERE itemID = ? AND userID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,itemID);
        statement.setInt(2,userID);
        ResultSet re = statement.executeQuery();
        if(re.next()){
            flag = true;
        }
        return flag;
    }

    @Override
    public List<Item> findByKeyword(String keyword) throws Exception{
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM item WHERE name LIKE '%"+keyword+"%' OR description LIKE '%"+keyword+"%' OR address LIKE '%"+keyword+"%' ORDER BY `view` DESC ";
        statement = connection.prepareStatement(sql);
        ResultSet re = statement.executeQuery();
        while (re.next()){
            Item item = new Item();
            item.setProperties(re.getInt("itemID"),re.getString("name"),
                    re.getString("imagePath"),re.getString("description"),
                    re.getString("address"),re.getInt("view"),
                    re.getTimestamp("timeReleased"),re.getString("year"),
                    re.getString("videoPath"));
            items.add(item);
        }
        System.out.println(sql);
        return items;
    }

    @Override
    public List<Item> findByKeywordAndPage(String keyword, int page) throws Exception {
        int startIndex = (page-1)*PAGE_SIZE;
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM item WHERE name LIKE '%"+keyword+"%' OR description LIKE '%"+keyword+"%' OR address LIKE '%"+keyword+"%'ORDER BY `view` DESC LIMIT "+startIndex+","+PAGE_SIZE;
        statement = connection.prepareStatement(sql);
        ResultSet re = statement.executeQuery();
        while (re.next()){
            Item item = new Item();
            item.setProperties(re.getInt("itemID"),re.getString("name"),
                    re.getString("imagePath"),re.getString("description"),
                    re.getString("address"),re.getInt("view"),
                    re.getTimestamp("timeReleased"),re.getString("year"),
                    re.getString("videoPath"));
            items.add(item);
        }
        System.out.println(sql);
        return items;
    }

    @Override
    public void addView(int itemId, int addView) throws Exception {
        Item item;
        String sql = "SELECT item.view FROM item WHERE itemID="+itemId;
        statement = connection.prepareStatement(sql);
        ResultSet re = statement.executeQuery();
        if(re.next()){
            int view = re.getInt("view");
            view += addView;
            sql = "UPDATE item SET view = "+view+" WHERE itemID="+itemId;
            statement = connection.prepareStatement(sql);
            statement.executeUpdate();
        }
    }

    @Override
    public void upData(Item item) throws Exception {
        String sql = "UPDATE item SET name = ? , address = ? , year = ? , description = ? WHERE itemID = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1,item.getName());
        statement.setString(2,item.getAddress());
        statement.setString(3,item.getYear());
        statement.setString(4,item.getDescription());
        statement.setInt(5,item.getItemId());
        statement.executeUpdate();
        if(!"".equals(item.getImagePath())){
            sql= "UPDATE item SET imagePath = ? WHERE itemID = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1,item.getImagePath());
            statement.setInt(2,item.getItemId());
            statement.executeUpdate();
        }
        if(!"".equals(item.getVideoPath())){
            sql= "UPDATE item SET videoPath = ? WHERE itemID = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1,item.getVideoPath());
            statement.setInt(2,item.getItemId());
            statement.executeUpdate();
        }
    }

    @Override
    public void deleteById(int itemId) throws Exception {
        String sql= "DELETE FROM item WHERE itemID = ?";
        statement = connection.prepareStatement(sql);
        statement.setInt(1,itemId);
        statement.executeUpdate();
    }
    public void close() throws Exception{
        connection.close();
    }
}
