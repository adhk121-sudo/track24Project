package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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

    String gubun = request.getParameter("t_gubun");
    if (gubun == null) gubun = "view";

    ProjectDao dao = new ProjectDao();
    String viewPage = "";

    // 1) 마이페이지 조회
    if (gubun.equals("view")) {
      ProjectDto member = dao.getMemberDetail(sessionId);
      ProjectDto pref = dao.getMemberPreference(sessionId);

      request.setAttribute("member", member);
      request.setAttribute("pref", pref);

      viewPage = "mypage/mypage.jsp";
    }

    // 2) 상세정보 수정 저장
    else if (gubun.equals("updateProfile")) {
      String name = request.getParameter("name");
      String age = request.getParameter("age");
      String area = request.getParameter("area");
      String gender = request.getParameter("gender");
      String email_1 = request.getParameter("email_1");
      String email_2 = request.getParameter("email_2");
      String mobile_1 = request.getParameter("mobile_1");
      String mobile_2 = request.getParameter("mobile_2");
      String mobile_3 = request.getParameter("mobile_3");
      String mbti = request.getParameter("mbti");
      String style = request.getParameter("style");

      if (mbti != null) mbti = mbti.toUpperCase();

      int result = dao.updateMemberProfile(
          sessionId, name, age, area,
          mobile_1, mobile_2, mobile_3,
          email_1, email_2, gender, mbti, style
      );

      if (result == 1) {
        session.setAttribute("sessionName", name); // 헤더에서 쓰는 경우 동기화
      }

      request.setAttribute("t_msg", result == 1 ? "상세정보가 수정되었습니다." : "수정 실패");
      request.setAttribute("t_url", request.getContextPath() + "/mypage");
      viewPage = "common_alert.jsp";
    }

    // 3) 취향 저장
    else if (gubun.equals("updateTaste")) {
      String food = joinValues(request.getParameterValues("food"));
      String drink = joinValues(request.getParameterValues("drink"));
      String music = joinValues(request.getParameterValues("music"));
      String movie = joinValues(request.getParameterValues("movie"));
      String book = joinValues(request.getParameterValues("book"));

      String allergy = request.getParameter("allergy");
      if (allergy == null) allergy = joinValues(request.getParameterValues("allergy"));

      int result = dao.updateMemberTaste(sessionId, food, drink, music, movie, book, allergy);

      request.setAttribute("t_msg", result == 1 ? "취향이 저장되었습니다." : "취향 저장 실패");
      request.setAttribute("t_url", request.getContextPath() + "/mypage");
      viewPage = "common_alert.jsp";
    }

    // 4) 비밀번호 변경
    else if (gubun.equals("pwUpdate")) {
    	
      String nowPw = request.getParameter("t_now_pw");
      String newPw = request.getParameter("t_new_pw");
      String newPwConfirm = request.getParameter("t_new_pw_confirm");

      String msg;
      if (newPw == null || newPw.length() < 8) {
        msg = "새 비밀번호는 8자 이상이어야 합니다.";
      } else if (!newPw.equals(newPwConfirm)) {
        msg = "새 비밀번호가 일치하지 않습니다.";
      } else if (!dao.checkPassword(sessionId, nowPw)) {
        msg = "현재 비밀번호가 올바르지 않습니다.";
      } else {
        int result = dao.updatePassword(sessionId, newPw);
        msg = (result == 1) ? "비밀번호가 변경되었습니다." : "비밀번호 변경 실패";
      }
      

      request.setAttribute("t_msg", msg);
      request.setAttribute("t_url", request.getContextPath() + "/mypage");
      viewPage = "common_alert.jsp";
    }

    RequestDispatcher rd = request.getRequestDispatcher(viewPage);
    rd.forward(request, response);
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    doGet(request, response);
  }

  private String joinValues(String[] arr) {
    if (arr == null || arr.length == 0) return "";
    return Arrays.stream(arr)
        .filter(v -> v != null && !v.trim().isEmpty())
        .map(String::trim)
        .collect(Collectors.joining(","));
  }
}
