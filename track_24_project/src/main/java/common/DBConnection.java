package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConn() {
		Connection conn = null;
		String url = "jdbc:oracle:thin:@1.245.91.227:1521:xe";
		String id = "track24_pjt_one";
		String pw = "1234";
			try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, id, pw);
			}catch(Exception e){
				System.out.println("오라클 드라이버 없음.");
				e.printStackTrace();
			}
		return conn;
	}
	
	public static void closeDB(Connection conn, PreparedStatement pstmt, ResultSet rs){
		if(rs!=null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn!=null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
		
	
}
