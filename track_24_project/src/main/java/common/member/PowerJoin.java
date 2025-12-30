package common.member;

import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import common.CommonPower;
import common.CommonUtil;
import dao.ProjectDao;
import dto.ProjectDto;

public class PowerJoin implements CommonPower {

	@Override
	public void Execute(HttpServletRequest request) {
		ProjectDao dao = new ProjectDao();
		
		String id = request.getParameter("login_id");
		String pw = request.getParameter("pw");
		String pw_length = Integer.toString(pw.length());
		try {
			pw = CommonUtil.encryptSHA256(pw);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String name = request.getParameter("nickname");
		String age = request.getParameter("age");
		String email_1 = request.getParameter("email_1");
		String email_2 = request.getParameter("email_2");
		String area = request.getParameter("area");
		String gender = request.getParameter("gender");
		String mobile_1 = request.getParameter("mobile_1");
		String mobile_2 = request.getParameter("mobile_2");
		String mobile_3 = request.getParameter("mobile_3");
		String mbti = request.getParameter("mbti").toUpperCase();
		String style = request.getParameter("speech_style");
		
		String k_food = request.getParameter("k_food");
		String j_food = request.getParameter("j_food");
		String c_food = request.getParameter("c_food");
		String a_food = request.getParameter("a_food");
		String s_food = request.getParameter("s_food");
		String d_food = request.getParameter("d_food");
		
		List<String> list1 = Arrays.asList(k_food, j_food, c_food, a_food, s_food, d_food);
		String result1 = list1.stream().filter(s -> s != null && !s.trim().isEmpty()).map(String::trim).collect(Collectors.joining(","));
	
		String k_pop = request.getParameter("k_pop");
		String hip_hop = request.getParameter("hip_hop");
		String ballad = request.getParameter("ballad");
		String edm = request.getParameter("edm");
		String jazz = request.getParameter("jazz");
		String rock = request.getParameter("rock");
		
		List<String> list3 = Arrays.asList(k_pop, hip_hop, ballad, edm, jazz, rock);
		String result3 = list1.stream().filter(s -> s != null && !s.trim().isEmpty()).map(String::trim).collect(Collectors.joining(","));
	
		
		String a_movie = request.getParameter("a_movie");
		String r_movie = request.getParameter("r_movie");
		String c_movie = request.getParameter("c_movie");
		String s_movie = request.getParameter("s_movie");
		String h_movie = request.getParameter("h_movie");
		String d_movie = request.getParameter("d_movie");
		
		List<String> list4 = Arrays.asList(a_movie, r_movie, c_movie, s_movie, h_movie, d_movie);
		String result4 = list1.stream().filter(s -> s != null && !s.trim().isEmpty()).map(String::trim).collect(Collectors.joining(","));
	
		String n_book = request.getParameter("n_book");
		String s_book = request.getParameter("s_book");
		String e_book = request.getParameter("e_book");
		String h_book = request.getParameter("h_book");
		String c_book = request.getParameter("c_book");
		
		List<String> list5 = Arrays.asList(n_book, s_book, e_book, h_book, c_book);
		String result5 = list1.stream().filter(s -> s != null && !s.trim().isEmpty()).map(String::trim).collect(Collectors.joining(","));
	
		String n_allergy = request.getParameter("n_allergy");
		String m_allergy = request.getParameter("m_allergy");
		String e_allergy = request.getParameter("e_allergy");
		String w_allergy = request.getParameter("w_allergy");
		String s_allergy = request.getParameter("s_allergy");
		String b_allergy = request.getParameter("b_allergy");
		String non_allergy = request.getParameter("non_allergy");
		List<String> list6 = Arrays.asList(n_allergy, m_allergy, e_allergy, w_allergy, s_allergy, b_allergy);
		String result6 = null;
		if(!non_allergy.equals("")) {
			result5 = non_allergy;
		}else {
			result5 = list1.stream().filter(s -> s != null && !s.trim().isEmpty()).map(String::trim).collect(Collectors.joining(","));
		}
		String reg_date = CommonUtil.getTodayTime();
		ProjectDto dto = new ProjectDto(id, name, pw, pw_length, age, area, mobile_1, mobile_2, mobile_3, email_1, email_2, gender, mbti, style, result1, "drink", result3, result4, result5, result6, reg_date, "update_date" );
		int memberResult = dao.memberJoin(dto);
	}

}
