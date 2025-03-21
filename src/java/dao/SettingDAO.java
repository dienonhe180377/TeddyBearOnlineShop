
package dao;


import entity.Setting;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Admin
 */
public class SettingDAO extends DBConnection {

    public SettingDAO() {
    }
    
    //Get all setting
    public ArrayList<Setting> getAllSetting() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "SELECT * FROM Setting";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                String content = rs.getString("content");
                Date createDate = rs.getDate("createDate");
                String description = rs.getString("description");
                settingList.add(new Setting(id, name, status, content, createDate, description));
            }
            return settingList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    public ArrayList<Setting> getAllSettingByText(String text) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "SELECT * FROM Setting where content like '%" + text + "%'";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                String content = rs.getString("content");
                Date createDate = rs.getDate("createDate");
                String description = rs.getString("description");
                settingList.add(new Setting(id, name, status, content, createDate, description));
            }
            return settingList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    public Setting getSettingById(int id) throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        Setting setting = null;
        String sql = "SELECT * FROM Setting where id = " + id;
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                String content = rs.getString("content");
                Date createDate = rs.getDate("createDate");
                String description = rs.getString("description");
                setting = new Setting(iD, name, status, content, createDate, description);
            }
            return setting;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    //Get all inactive setting
    public ArrayList<Setting> getAllInactiveSetting() throws Exception {
        Connection conn = null;
        ResultSet rs = null;
        /* Result set returned by the sqlserver */
        PreparedStatement pre = null;
        /* Prepared statement for executing sql queries */
        ArrayList<Setting> settingList = new ArrayList<>();
        String sql = "SELECT * FROM Setting where status = 0";
        try {
            conn = getConnection();
            pre = conn.prepareStatement(sql);
            rs = pre.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                boolean status = rs.getBoolean("status");
                String content = rs.getString("content");
                Date createDate = rs.getDate("createDate");
                String description = rs.getString("description");
                settingList.add(new Setting(id, name, status, content, createDate, description));
            }
            return settingList;
        } catch (Exception ex) {
            throw ex;
        } finally {
            closeResultSet(rs);
            closePreparedStatement(pre);
            closeConnection(conn);
        }
    }
    
    public boolean checkSettingExisted(String content) throws Exception{
        List<Setting> settingExisted = getAllSetting();
        for (int i = 0; i < settingExisted.size(); i++) {
            String setting = settingExisted.get(i).getName().toLowerCase().trim();
            content = content.toLowerCase().trim();
            if(setting.equals(content)){
                return true;
            }
        }
        return false;
    }
    
    public static void main(String[] args) throws Exception {
        SettingDAO settingDAO = new SettingDAO();
        List<Setting> settingList = settingDAO.getAllSettingByText("a");
        for (int i = 0; i < settingList.size(); i++) {
            System.out.println(settingList.get(i));
            System.out.println();
        }
    }
}
