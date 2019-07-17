package dao;

import bean.UserEntry;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:23
 */
public interface UserDao {


    public UserEntry findByAccount(String account) throws Exception;


}
