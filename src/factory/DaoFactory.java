package factory;

import dao.ItemDaoImpl;
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
}
