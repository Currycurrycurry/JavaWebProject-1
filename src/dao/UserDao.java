package dao;

import bean.UserEntry;
import jdk.nashorn.internal.runtime.ECMAException;

import java.util.HashMap;
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

    public List<UserEntry> findFriend(int userID)throws Exception;

    public void deleteFriend(int userID,int friendID)throws Exception;

    public void sendRequest(int sendFrom_ID,int sendTo_ID)throws Exception;

    public void reject(int sendFrom_ID,int sendTo_ID)throws Exception;

    public void agree(int sendFrom_ID,int sendTo_ID)throws Exception;

    public List<UserEntry> findFriendRequest(int sendTo_ID)throws Exception;

    public HashMap<UserEntry,Integer> findUser(int userID, String searchName)throws Exception;




}
