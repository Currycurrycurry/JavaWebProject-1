package dao;

import bean.Item;

import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/19
 * @time: 16:21
 */
public interface CollectionDao {
    public void insertCollection(int userId, int itemId, boolean isPublic) throws Exception;

    public void deleteCollection(int userId, int itemId) throws Exception;

    public List<Item> findCollection (int useId, boolean isPublic) throws Exception;

    public void changePublicity(int userId, int itemId) throws Exception;

}
