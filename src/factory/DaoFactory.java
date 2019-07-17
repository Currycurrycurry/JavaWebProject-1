package factory;

import dao.UserDao;
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
}
