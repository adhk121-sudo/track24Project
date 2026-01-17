package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.ProjectDao;
import dto.ProjectDto;

@WebServlet("/AdminUsers")
public class AdminUsers extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("utf-8");
        
        // 관리자 체크
        HttpSession session = request.getSession();
        String sessionTop = (String) session.getAttribute("sessionTop");
        
        if (sessionTop == null || !sessionTop.equals("admin")) {
            request.setAttribute("t_msg", "관리자만 접근 가능합니다!");
            request.setAttribute("t_url", "Power");
            RequestDispatcher rd = request.getRequestDispatcher("common/common_alert.jsp");
            rd.forward(request, response);
            return;
        }
        
        String action = request.getParameter("action");
        if (action == null) action = "list";
        
        ProjectDao dao = new ProjectDao();
        
        // 회원 목록
        if (action.equals("list")) {
            // 페이지 번호
            int page = 1;
            int pageSize = 10;
            
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
            
            // 통계
            request.setAttribute("totalUsers", dao.getTotalUserCount());
            request.setAttribute("monthlyUsers", dao.getMonthlyUserCount());
            request.setAttribute("todayUsers", dao.getTodayUserCount());
            request.setAttribute("maleUsers", dao.getGenderCount("M"));
            request.setAttribute("femaleUsers", dao.getGenderCount("F"));
            
            // 회원 목록
            List<ProjectDto> list = dao.getMemberList(page, pageSize);
            request.setAttribute("list", list);
            
            // 페이징 정보
            int totalUsers = dao.getTotalUserCount();
            int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
            
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            
            RequestDispatcher rd = request.getRequestDispatcher("admin/admin_users.jsp");
            rd.forward(request, response);
        }
        
        // 회원 상세 (Ajax)
        else if (action.equals("detail")) {
            response.setContentType("application/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            
            String userId = request.getParameter("userId");
            ProjectDto dto = dao.getMemberDetail(userId);
            
            Gson gson = new Gson();
            out.print(gson.toJson(dto));
            out.flush();
        }
        
        // 회원 삭제 (Ajax)
        else if (action.equals("delete")) {
            response.setContentType("application/json; charset=utf-8");
            PrintWriter out = response.getWriter();
            
            String userId = request.getParameter("userId");
            int result = dao.deleteMember(userId);
            
            out.print("{\"result\": " + result + "}");
            out.flush();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}