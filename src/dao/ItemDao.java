package dao;

import bean.Item;

import java.util.List;

/**
 * @author: CKD
 * @date: 2019/7/17
 * @time: 19:15
 */
public interface ItemDao {
    public Item findByName(String name)throws Exception;

    public Item findById(int itemId)throws Exception;

    public int insertItem(Item item)throws Exception;

    public void deleteItem(int itemId)throws Exception;

    public List<Item> getItemsOrdered(int numberOfItems, String orderPara) throws Exception;

    public boolean isCollectedByUser(int itemID, int userID) throws Exception;

    public List<Item> findByKeyword(String keyword) throws Exception;

    public List<Item> findByKeywordAndPage(String keyword,int page) throws Exception;

    public void addView(int itemId, int addView) throws Exception;

}
