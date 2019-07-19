package dao;

import bean.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/18
 * @time: 17:04
 */
public class ItemDaoImpl implements ItemDao {
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
            item.setItemId(re.getInt("itemID"));
            item.setName(re.getString("name"));
            item.setImagePath(re.getString("imagePath"));
            item.setDescription(re.getString("description"));
            item.setAddress(re.getString("address"));
            item.setYear(re.getString("year"));
            item.setView(re.getInt("view"));
        }
        return item;
    }

    @Override
    public void insertItem(Item item) throws Exception {

    }

    @Override
    public void deleteItem(int itemId) throws Exception {

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
            item.setItemId(re.getInt("itemID"));
            item.setName(re.getString("name"));
            item.setImagePath(re.getString("imagePath"));
            item.setDescription(re.getString("description"));
            item.setAddress(re.getString("address"));
            item.setYear(re.getString("year"));
            items.add(item);
        }
        return items;
    }
}
