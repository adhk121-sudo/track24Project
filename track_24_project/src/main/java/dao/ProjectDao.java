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
		String query = "insert into team_random_member\r\n"
				+ "(id, name, password, password_length, age, area,\r\n"
				+ "mobile_1, mobile_2, mobile_3, email_1, email_2,\r\n"
				+ "gender, mbti, allergy, food, drink, music, book, movie, style, reg_date)\r\n"
				+ "values ('"+dto.getId()+"', '"+dto.getName()+"', '"+dto.getPw()+"', '"+dto.getPw_length()+"', '"+dto.getAge()+"', '"+dto.getArea()+"', '"+dto.getMobile_1()+"',\r\n"
				+ "'"+dto.getMobile_2()+"', '"+dto.getMobile_3()+"', '"+dto.getEmail_1()+"', '"+dto.getEmail_2()+"', '"+dto.getGender()+"', '"+dto.getMbti()+"', '"+dto.getAllergy()+"', '"+dto.getFood()+"',\r\n"
				+ "'"+dto.getDrink()+"','"+dto.getMusic()+"','"+dto.getBook()+"','"+dto.getMovie()+"', '"+dto.getStyle()+"', to_date('"+dto.getReg_date()+"','yyyy-MM-dd hh24:mi:ss'))";
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
