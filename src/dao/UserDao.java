package dao;

import bean.UserEntry;
import jdk.nashorn.internal.runtime.ECMAException;

import java.util.List;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 16:23
 */
public interface UserDao {


    public UserEntry findByAccount(String account) throws Exception;

    public void insertAccount(UserEntry userEntry) throws Exception;

    public void deleteAccount(int userID) throws Exception;

    public void updateInfo(UserEntry userEntry)throws Exception;

    public List<UserEntry> findAll(int userID)throws Exception;

    public void updateLoginTime(UserEntry userEntry)throws Exception;

    public void updateAdmin(int userID,boolean isAdmin)throws Exception;

}
