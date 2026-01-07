package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonPower;
import common.member.PowerJoin;
import dao.ProjectDao;
import dto.ProjectDto;

/**
 * Servlet implementation class Power
 */
@WebServlet("/Power")
public class Power extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Power() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String gubun = request.getParameter("t_gubun");
		String uri = request.getRequestURI(); // 예: /track_24_project/mypage
		if(uri != null && uri.endsWith("/mypage")) {
		    gubun = "mypage";
		}
		if(gubun==null) gubun = "main";
		String viewPage = "";
		if(gubun.equals("main")) {
			viewPage = "main_powerranger.jsp";
		}else if(gubun.equals("login")) {
			viewPage = "login/login_powerranger.jsp";
		}else if(gubun.equals("join")) {
			viewPage = "join/join_powerranger.jsp";
		}else if(gubun.equals("DBjoin")) {
			CommonPower cp = new PowerJoin();
			cp.Execute(request);
			viewPage = "common_alert.jsp";
		}else if(gubun.equals("food")) {
			viewPage = "food/question_food.jsp";
		}else if(gubun.equals("drink")) {
			viewPage = "drink/question_drink.jsp";
		}else if(gubun.equals("movie")) {
			viewPage = "movie/question_movie.jsp";
		}else if(gubun.equals("book")) {
			viewPage = "book/question_book.jsp";
		}else if(gubun.equals("music")) {
			viewPage = "music/question_music.jsp";
		}else if(gubun.equals("mypage")) {
		    javax.servlet.http.HttpSession session = request.getSession();
		    String sessionId = (String)session.getAttribute("sessionId");

		    if(sessionId == null || sessionId.equals("")) {
		        request.setAttribute("t_msg", "로그인 후 이용 가능합니다");
		        request.setAttribute("t_url", request.getContextPath() + "/Power?t_gubun=login");
		        viewPage = "common_alert.jsp";
		    } else {
		        ProjectDao dao = new ProjectDao();

		        // 1) 기본정보(상세정보) 조회
		        ProjectDto member = dao.getMemberDetail(sessionId);

		        // 2) 취향정보 조회(이미 dao에 getMemberPreference 있음)
		        ProjectDto pref = dao.getMemberPreference(sessionId);

		        request.setAttribute("member", member);
		        request.setAttribute("pref", pref);  // 취향은 pref로 따로 써도 되고 member에 합쳐도 됨

		        viewPage = "mypage/mypage.jsp";
		    }
		}
		RequestDispatcher rd = request.getRequestDispatcher(viewPage);
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
