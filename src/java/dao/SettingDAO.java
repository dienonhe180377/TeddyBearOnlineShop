
package dao;


import entity.Setting;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class SettingDAO extends DBConnection {

    public SettingDAO() {
    }
    
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
    
    public static void main(String[] args) throws Exception {
        SettingDAO settingDAO = new SettingDAO();
        ArrayList<Setting> settingList = settingDAO.getAllSetting();
        for (int i = 0; i < settingList.size(); i++) {
            System.out.println(settingList.get(i));
            System.out.println();
        }
    }
}
