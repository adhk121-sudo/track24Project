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

	// 로그인 - 아이디와 비밀번호로 사용자 확인
	public ProjectDto memberLogin(String id, String pw) {
		ProjectDto dto = null;
		String query = "SELECT id, name, pw, age, area, mobile_1, mobile_2, mobile_3, " +
					   "email_1, email_2, gender, mbti, style, food, drink, music, movie, book, allergy, reg_date " +
					   "FROM track24_member WHERE id = ? AND pw = ?";
		try {
			conn = DBConnection.getConn();
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProjectDto(
					rs.getString("id") != null ? rs.getString("id") : "",
					rs.getString("name") != null ? rs.getString("name") : "",
					rs.getString("pw") != null ? rs.getString("pw") : "",
					"", // pw_length
					rs.getString("age") != null ? rs.getString("age") : "",
					rs.getString("area") != null ? rs.getString("area") : "",
					rs.getString("mobile_1") != null ? rs.getString("mobile_1") : "",
					rs.getString("mobile_2") != null ? rs.getString("mobile_2") : "",
					rs.getString("mobile_3") != null ? rs.getString("mobile_3") : "",
					rs.getString("email_1") != null ? rs.getString("email_1") : "",
					rs.getString("email_2") != null ? rs.getString("email_2") : "",
					rs.getString("gender") != null ? rs.getString("gender") : "",
					rs.getString("mbti") != null ? rs.getString("mbti") : "",
					rs.getString("style") != null ? rs.getString("style") : "",
					rs.getString("food") != null ? rs.getString("food") : "",
					rs.getString("drink") != null ? rs.getString("drink") : "",
					rs.getString("music") != null ? rs.getString("music") : "",
					rs.getString("movie") != null ? rs.getString("movie") : "",
					rs.getString("book") != null ? rs.getString("book") : "",
					rs.getString("allergy") != null ? rs.getString("allergy") : "",
					rs.getString("reg_date") != null ? rs.getString("reg_date") : "",
					"" // update_date
				);
			}
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("로그인 쿼리 오류: " + query);
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return dto;
	}

}
