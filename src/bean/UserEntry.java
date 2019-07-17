package bean;

/**
 * @author: YXH
 * @date: 2019/7/17
 * @time: 15:57
 */
public class UserEntry {
    private int id;
    private String account;
    private String password;
    private String name;
    private boolean isAdmin;
    private String email;
    private String signature;

    public UserEntry() {
        isAdmin = false;
        signature = "";
    }

    public UserEntry(String account,String password,String name,String email,String signature,boolean isAdmin){
        setAccount(account);
        setAdmin(isAdmin);
        setEmail(email);
        setPassword(password);
        setName(name);
        setSignature(signature);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
