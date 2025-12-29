package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		if(gubun==null) gubun = "main";
		String viewPage = "";
		if(gubun.equals("main")) {
			viewPage = "main_powerranger.jsp";
		}else if(gubun.equals("login")) {
			viewPage = "login/login_powerranger.jsp";
		}else if(gubun.equals("join")) {
			viewPage = "join/join_powerranger.jsp";
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
