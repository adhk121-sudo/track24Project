package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonUtil;
import dao.ProjectDao;
import dto.ProjectDto;

/**
 * 로그인 처리 서블릿
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("login_id");
		String pw = request.getParameter("pw");
		
		String msg = "";
		String url = "";
		
		// 입력값 검증
		if(id == null || id.trim().equals("") || pw == null || pw.trim().equals("")) {
			msg = "아이디와 비밀번호를 입력해주세요.";
			url = "Power?t_gubun=login";
		} else {
			ProjectDao dao = new ProjectDao();
			String encryptedPw = null;
			
			// 비밀번호 암호화
			try {
				encryptedPw = CommonUtil.encryptSHA256(pw);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
				msg = "시스템 오류가 발생했습니다.";
				url = "Power?t_gubun=login";
			}
			
			// 암호화가 성공한 경우에만 로그인 확인
			if(encryptedPw != null) {
				// 로그인 확인
				ProjectDto dto = dao.memberLogin(id, encryptedPw);
				
				if(dto != null) {
					// 로그인 성공 - 세션에 사용자 정보 저장
					HttpSession session = request.getSession();
					session.setAttribute("sessionId", dto.getId());
					session.setAttribute("sessionName", dto.getName());
					session.setAttribute("sessionDto", dto);
					
					msg = dto.getName() + "님 환영합니다!";
					url = "Power?t_gubun=main";
				} else {
					// 로그인 실패
					msg = "아이디 또는 비밀번호가 일치하지 않습니다.";
					url = "Power?t_gubun=login";
				}
			}
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		
		RequestDispatcher rd = request.getRequestDispatcher("common/alert.jsp");
		rd.forward(request, response);
	}

}

