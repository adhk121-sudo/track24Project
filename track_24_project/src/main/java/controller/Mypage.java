package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProjectDao;
import dto.ProjectDto;

@WebServlet("/mypage")
public class Mypage extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {

    request.setCharacterEncoding("utf-8");

    HttpSession session = request.getSession();
    String sessionId = (String) session.getAttribute("sessionId");

    if (sessionId == null || sessionId.equals("")) {
      request.setAttribute("t_msg", "로그인 후 이용 가능합니다");
      request.setAttribute("t_url", request.getContextPath() + "/Power?t_gubun=login");
      RequestDispatcher rd = request.getRequestDispatcher("common_alert.jsp");
      rd.forward(request, response);
      return;
    }

    ProjectDao dao = new ProjectDao();

    ProjectDto member = dao.getMemberDetail(sessionId);
    ProjectDto pref = dao.getMemberPreference(sessionId);

    request.setAttribute("member", member);
    request.setAttribute("pref", pref);

    RequestDispatcher rd = request.getRequestDispatcher("mypage/mypage.jsp");
    rd.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }
}
