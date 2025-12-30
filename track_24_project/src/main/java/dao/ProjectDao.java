package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import common.DBConnection;
import dto.ProjectDto;

public class ProjectDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int memberJoin(ProjectDto dto) {
		int row = 0;
		String query = "";
		try {
			conn = DBConnection.getConn();
			pstmt = conn.prepareStatement(query);
			row = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("쿼리문 오류: " + query);
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return row;
	}

}
