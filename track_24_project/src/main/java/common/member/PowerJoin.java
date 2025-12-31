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
		
		String food[] = request.getParameterValues("food");
		String drink[] = request.getParameterValues("drink");
		String music[] = request.getParameterValues("music");
		String movie[] = request.getParameterValues("movie");
		String book[] = request.getParameterValues("book");
		String allergy[] = request.getParameterValues("allergy");
		
		String foodStr = (food != null) ? String.join(",", food) : "";
		String drinkStr = (drink != null) ? String.join(",", drink) : "";
		String musicStr = (music != null) ? String.join(",", music) : "";
		String movieStr = (movie != null) ? String.join(",", movie) : "";
		String bookStr = (book != null) ? String.join(",", book) : "";
		String allergyStr = (allergy != null) ? String.join(",", allergy) : "";
		
		String reg_date = CommonUtil.getTodayTime();
		ProjectDto dto = new ProjectDto(id, name, pw, pw_length, age, area, mobile_1, mobile_2, mobile_3, email_1, email_2, gender, mbti, style, foodStr, drinkStr, musicStr, movieStr, bookStr, allergyStr, reg_date, "update_date");
		int memberResult = dao.memberJoin(dto);
		String warning = memberResult==1? "회원등록 되었습니다.":"회원등록 실패했습니다. 관리자에게 문의바랍니다.";
		request.setAttribute("t_msg", warning);
		
	}

}
