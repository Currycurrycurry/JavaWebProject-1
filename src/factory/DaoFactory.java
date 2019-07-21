package factory;

import bean.Message;
import dao.CollectionDaoImpl;
import dao.ItemDaoImpl;
import dao.MessageDaoImpl;
import dao.UserDaoImpl;
import database.DBConnection;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:27
 */
public class DaoFactory {
    public static UserDaoImpl getUserDaoInstance() throws Exception{
        return new UserDaoImpl(new DBConnection().getConnection()) ;
    }

    public static ItemDaoImpl getItemDaoInstance() throws Exception{
        return new ItemDaoImpl(new DBConnection().getConnection()) ;
    }

    public static CollectionDaoImpl getCollectionDaoInstance() throws Exception{
        return new CollectionDaoImpl(new DBConnection().getConnection()) ;
    }

    public static MessageDaoImpl getMessageDaoInstance()throws Exception{
        return new MessageDaoImpl(new DBConnection().getConnection());
    }
}
