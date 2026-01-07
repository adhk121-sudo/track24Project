package controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProjectDao;

/**
 * Servlet implementation class AdminDashboard
 */
@WebServlet("/AdminDashboard")
public class AdminDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
ProjectDao dao = new ProjectDao();
        
        // 카테고리별 총 클릭 수
        request.setAttribute("foodTotal", dao.getCategoryTotal("food"));
        request.setAttribute("drinkTotal", dao.getCategoryTotal("drink"));
        request.setAttribute("movieTotal", dao.getCategoryTotal("movie"));
        request.setAttribute("bookTotal", dao.getCategoryTotal("book"));
        request.setAttribute("musicTotal", dao.getCategoryTotal("music"));
        
        // 맛레인저 질문별 통계
        request.setAttribute("foodQ1Data", mapToChartData(dao.getQuestionStats("food", 1)));
        request.setAttribute("foodQ2Data", mapToChartData(dao.getQuestionStats("food", 2)));
        request.setAttribute("foodQ3Data", mapToChartData(dao.getQuestionStats("food", 3)));
        request.setAttribute("foodQ4Data", mapToChartData(dao.getQuestionStats("food", 4)));
        
        // 월별 추이
        request.setAttribute("foodMonthly", listToChartData(dao.getMonthlyTrend("food")));
        request.setAttribute("drinkMonthly", listToChartData(dao.getMonthlyTrend("drink")));
        request.setAttribute("movieMonthly", listToChartData(dao.getMonthlyTrend("movie")));
        request.setAttribute("bookMonthly", listToChartData(dao.getMonthlyTrend("book")));
        request.setAttribute("musicMonthly", listToChartData(dao.getMonthlyTrend("music")));
        
        RequestDispatcher rd = request.getRequestDispatcher("admin/admin.jsp");
        rd.forward(request, response);
    }
    
    // Map을 차트 데이터로 변환 (예: "120, 85, 95, 60")
    private String mapToChartData(Map<String, Integer> map) {
        StringBuilder sb = new StringBuilder();
        for (Integer value : map.values()) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(value);
        }
        return sb.toString();
    }
    
    // List를 차트 데이터로 변환
    private String listToChartData(List<Integer> list) {
        StringBuilder sb = new StringBuilder();
        for (Integer value : list) {
            if (sb.length() > 0) sb.append(", ");
            sb.append(value);
        }
        return sb.toString();
    }

	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
