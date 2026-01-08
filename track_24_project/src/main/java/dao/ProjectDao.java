package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import common.CommonUtil;
import common.DBConnection;
import dto.ProjectDto;
public class ProjectDao {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	//로그인
	public int memberJoin(ProjectDto dto) {
		int row = 0;
		String sql = "insert into team_random_member\r\n"
				+ "(id, name, password, password_length, age, area,\r\n"
				+ "mobile_1, mobile_2, mobile_3, email_1, email_2,\r\n"
				+ "gender, mbti, allergy, food, drink, music, book, movie, style, reg_date)\r\n"
				+ "values ('"+dto.getId()+"', '"+dto.getName()+"', '"+dto.getPw()+"', '"+dto.getPw_length()+"', '"+dto.getAge()+"', '"+dto.getArea()+"', '"+dto.getMobile_1()+"',\r\n"
				+ "'"+dto.getMobile_2()+"', '"+dto.getMobile_3()+"', '"+dto.getEmail_1()+"', '"+dto.getEmail_2()+"', '"+dto.getGender()+"', '"+dto.getMbti()+"', '"+dto.getAllergy()+"', '"+dto.getFood()+"',\r\n"
				+ "'"+dto.getDrink()+"','"+dto.getMusic()+"','"+dto.getBook()+"','"+dto.getMovie()+"', '"+dto.getStyle()+"', to_date('"+dto.getReg_date()+"','yyyy-MM-dd hh24:mi:ss'))";
		try {
			conn = DBConnection.getConn();
			pstmt = conn.prepareStatement(sql);
			row = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("쿼리문 오류: " + sql);
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return row;
	}

	// 로그인 - 아이디와 비밀번호로 사용자 확인
	public ProjectDto memberLogin(String id, String pw) {
	    ProjectDto dto = null;

	    String sql = "SELECT ID, NAME, STYLE "
	                 + "FROM TEAM_RANDOM_MEMBER "
	                 + "WHERE ID = ? AND PASSWORD = ?";

	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, pw);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String name = rs.getString("NAME");
	            String style = rs.getString("STYLE");

	            dto = new ProjectDto(id, name, style);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("로그인 쿼리 오류: " + sql);
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return dto;
	}

	
	//회원 전체 조회
	public ProjectDto memberList(String id, String pw) {
		ProjectDto dto = null;
		String sql = "SELECT id, name, pw, age, area, mobile_1, mobile_2, mobile_3, " +
					   "email_1, email_2, gender, mbti, style, food, drink, music, movie, book, allergy, reg_date " +
					   "FROM track24_member WHERE id = ? AND pw = ?";
		try {
			conn = DBConnection.getConn();
			pstmt = conn.prepareStatement(sql);
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
			System.out.println("memberList 오류: " + sql);
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return dto;
	}

	

	//회원 취향 정보 조회
	public	ProjectDto getMemberPreference(String id) {
		ProjectDto dto =null;
		String sql="select food,drink,movie,book,music,allergy,style from team_random_member where id = '"+id+"'";
		
		try {
			conn=DBConnection.getConn();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				String food = rs.getString("food");
				String drink = rs.getString("drink");
				String movie = rs.getString("movie");
				String book = rs.getString("book");
				String music = rs.getString("music");
				String allergy = rs.getString("allergy");
				String style = rs.getString("style");
				
				dto =new ProjectDto(style, food, drink, music, movie, book, allergy);
			}
			
		} catch (Exception e) {
			System.out.println("getMemberPreference 안돼요~!"+sql);
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return dto;
	}

	public int checkId(String id) {
		int result = 0;
		String sql = "select count(*) from team_random_member where id = '"+id+"'";
		
		try {
			conn = DBConnection.getConn();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("count(*)");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBConnection.closeDB(conn, pstmt, rs);
		}
		return result;
	}
	public ProjectDto getMemberDetail(String id){
	    ProjectDto dto = null;

	    String sql = "select id, name, password, password_length, age, area, " +
	                 "mobile_1, mobile_2, mobile_3, email_1, email_2, " +
	                 "gender, mbti, style, food, drink, music, movie, book, allergy, " +
	                 "to_char(reg_date,'yyyy-MM-dd hh24:mi:ss') as reg_date, " +
	                 "to_char(update_date,'yyyy-MM-dd hh24:mi:ss') as update_date " +
	                 "from team_random_member where id = ?";

	    try{
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        rs = pstmt.executeQuery();

	        if(rs.next()){
	            dto = new ProjectDto(
	                rs.getString("id"),
	                rs.getString("name"),
	                rs.getString("password"),
	                rs.getString("password_length"),
	                rs.getString("age"),
	                rs.getString("area"),
	                rs.getString("mobile_1"),
	                rs.getString("mobile_2"),
	                rs.getString("mobile_3"),
	                rs.getString("email_1"),
	                rs.getString("email_2"),
	                rs.getString("gender"),
	                rs.getString("mbti"),
	                rs.getString("style"),
	                rs.getString("food"),
	                rs.getString("drink"),
	                rs.getString("music"),
	                rs.getString("movie"),
	                rs.getString("book"),
	                rs.getString("allergy"),
	                rs.getString("reg_date"),
	                rs.getString("update_date")
	            );
	        }
	    }catch(Exception e){
	        e.printStackTrace();
	        System.out.println("getMemberDetail 오류: " + sql);
	    }finally{
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return dto;
	}
	
	
	public void saveClickLog(String category, int questionNum, String answerValue) {
	    String query = "INSERT INTO click_log (log_id, category, question_num, answer_value, click_date) " +
	                   "VALUES (click_log_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, category);
	        pstmt.setInt(2, questionNum);
	        pstmt.setString(3, answerValue);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	}

	// ProjectDao.java

	// 카테고리별 총 클릭 수
	public int getCategoryTotal(String category) {
	    int total = 0;
	    String query = "SELECT COUNT(*) FROM click_log WHERE category = ?";
	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, category);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            total = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return total;
	}

	// 질문별 선택지 클릭 수
	public Map<String, Integer> getQuestionStats(String category, int questionNum) {
	    Map<String, Integer> stats = new LinkedHashMap<>();
	    String query = "SELECT answer_value, COUNT(*) as cnt " +
	                   "FROM click_log " +
	                   "WHERE category = ? AND question_num = ? " +
	                   "GROUP BY answer_value";
	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, category);
	        pstmt.setInt(2, questionNum);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            stats.put(rs.getString("answer_value"), rs.getInt("cnt"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return stats;
	}

	// 월별 추이
	public List<Integer> getMonthlyTrend(String category) {
	    List<Integer> monthly = new ArrayList<>();
	    String query = "SELECT TO_CHAR(click_date, 'MM') as month, COUNT(*) as cnt " +
	                   "FROM click_log " +
	                   "WHERE category = ? " +
	                   "GROUP BY TO_CHAR(click_date, 'MM') " +
	                   "ORDER BY month";
	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, category);
	        rs = pstmt.executeQuery();
	        
	        // 1~12월 초기화
	        int[] months = new int[12];
	        while (rs.next()) {
	            int month = Integer.parseInt(rs.getString("month"));
	            months[month - 1] = rs.getInt("cnt");
	        }
	        for (int cnt : months) {
	            monthly.add(cnt);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return monthly;
	}
	// 1) 상세정보 수정
	public int updateMemberProfile(String id, String name, String age, String area,
	    String mobile_1, String mobile_2, String mobile_3,
	    String email_1, String email_2, String gender, String mbti, String style) {

	  int result = 0;

	  String sql =
	      "update team_random_member set " +
	      "name=?, age=?, area=?, " +
	      "mobile_1=?, mobile_2=?, mobile_3=?, " +
	      "email_1=?, email_2=?, " +
	      "gender=?, mbti=?, style=?, " +
	      "update_date=sysdate " +
	      "where id=?";

	  try {
	    conn = DBConnection.getConn();
	    pstmt = conn.prepareStatement(sql);

	    int idx = 1;
	    pstmt.setString(idx++, name);
	    pstmt.setString(idx++, age);
	    pstmt.setString(idx++, area);

	    pstmt.setString(idx++, mobile_1);
	    pstmt.setString(idx++, mobile_2);
	    pstmt.setString(idx++, mobile_3);

	    pstmt.setString(idx++, email_1);
	    pstmt.setString(idx++, email_2);

	    pstmt.setString(idx++, gender);
	    pstmt.setString(idx++, mbti);
	    pstmt.setString(idx++, style);

	    pstmt.setString(idx++, id);

	    result = pstmt.executeUpdate();
	  } catch (Exception e) {
	    e.printStackTrace();
	    System.out.println("updateMemberProfile 오류: " + sql);
	  } finally {
	    DBConnection.closeDB(conn, pstmt, rs);
	  }

	  return result;
	}

	// 2) 취향 저장
	public int updateMemberTaste(String id, String food, String drink, String music,
	    String movie, String book, String allergy) {

	  int result = 0;

	  String sql =
	      "update team_random_member set " +
	      "food=?, drink=?, music=?, movie=?, book=?, allergy=?, " +
	      "update_date=sysdate " +
	      "where id=?";

	  try {
	    conn = DBConnection.getConn();
	    pstmt = conn.prepareStatement(sql);

	    int idx = 1;
	    pstmt.setString(idx++, food);
	    pstmt.setString(idx++, drink);
	    pstmt.setString(idx++, music);
	    pstmt.setString(idx++, movie);
	    pstmt.setString(idx++, book);
	    pstmt.setString(idx++, allergy);
	    pstmt.setString(idx++, id);

	    result = pstmt.executeUpdate();
	  } catch (Exception e) {
	    e.printStackTrace();
	    System.out.println("updateMemberTaste 오류: " + sql);
	  } finally {
	    DBConnection.closeDB(conn, pstmt, rs);
	  }

	  return result;
	}

	// 3) 현재 비밀번호 확인
	public boolean checkPassword(String id, String pw) {
	    boolean ok = false;

	    String encPw = "";
	    try {
	        encPw = CommonUtil.encryptSHA256(pw);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false; // 암호화 실패면 그냥 false 처리
	    }

	    String sql = "select count(*) as cnt from team_random_member where id=? and password=?";

	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, id);
	        pstmt.setString(2, encPw);
	        rs = pstmt.executeQuery();

	        if (rs.next() && rs.getInt("cnt") == 1) ok = true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("checkPassword 오류: " + sql);
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return ok;
	}

	// 4) 비밀번호 변경
	public int updatePassword(String id, String newPw) {
	    int result = 0;

	    String encNewPw = "";
	    try {
	        encNewPw = CommonUtil.encryptSHA256(newPw);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return 0; // 암호화 실패면 업데이트 실패로 처리
	    }

	    String sql = "update team_random_member set password=?, update_date=sysdate where id=?";

	    try {
	        conn = DBConnection.getConn();
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, encNewPw);
	        pstmt.setString(2, id);
	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("updatePassword 오류: " + sql);
	    } finally {
	        DBConnection.closeDB(conn, pstmt, rs);
	    }
	    return result;
	}

}
