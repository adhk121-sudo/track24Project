package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.AIClient;
import common.CommonUtil;
import dao.ProjectDao;
import dto.ProjectDto;

/**
 * Servlet implementation class RecommendAI
 */
@WebServlet("/RecommendAI")
public class RecommendAI extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecommendAI() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("utf-8");
		//==1. 카테고리 구분==	
		String category = request.getParameter("category");
		
		//==2. 공통데이터 받기==
		String q1 = request.getParameter("q1");
        String q2 = request.getParameter("q2");
        String q3 = request.getParameter("q3");
        String q4 = request.getParameter("q4");
        
        // RecommendAI.java - doPost 안에 추가
        // 클릭 로그 저장
        ProjectDao dao = new ProjectDao();
        dao.saveClickLog(category, 1, q1);
        dao.saveClickLog(category, 2, q2);
        dao.saveClickLog(category, 3, q3);
        dao.saveClickLog(category, 4, q4);
        
        
        
        //==3. 로그인 확인 & 회원 정보 받기==
        HttpSession session = request.getSession();
        
        String sessionId =CommonUtil.getSessionId(request);
        boolean isLogin = (sessionId != null && !sessionId.equals(""));
        
        String memberPreference="";
        String memberAllergy="";
        String speechStyle="";
        

        if (isLogin) {
            
            ProjectDto member = dao.getMemberPreference(sessionId);
            if(member != null) {
            	//카테고리별 취향 가져오기
            	switch(category) {
            	case "food" : memberPreference = member.getFood();break;
            	case "drink" : memberPreference = member.getDrink();break;
            	case "movie" : memberPreference = member.getMovie();break;
            	case "book" : memberPreference = member.getBook();break;
            	case "music" : memberPreference = member.getMusic();break;
            	}
            	memberAllergy = member.getAllergy();
            	speechStyle = member.getStyle();
            }
        }
     // ===== 4. AI 프롬프트 생성 =====
        String prompt = makePrompt(category, q1, q2, q3, q4, 
                                   isLogin, memberPreference, memberAllergy, speechStyle);
        
        // ===== 5. AI API 호출 =====
        String aiResponse = callAI(prompt);
        
        // ===== 6. 결과 담기 =====
        request.setAttribute("category", category);
        request.setAttribute("q1", q1);
        request.setAttribute("q2", q2);
        request.setAttribute("q3", q3);
        request.setAttribute("q4", q4);
        request.setAttribute("result", aiResponse);
        request.setAttribute("isLogin", isLogin);
        
        // ===== 7. 통합 결과 페이지로 이동 =====
        RequestDispatcher rd = request.getRequestDispatcher("result/result.jsp");
        rd.forward(request, response);
    }
	   
    // ========================================
    // private 메서드: 이 클래스 내부에서만 사용
    // ========================================
    
    /**
     * AI에게 보낼 프롬프트(질문) 생성
     */
    private String makePrompt(String category, String q1, String q2, String q3, String q4,
                              boolean isLogin, String preference, String allergy, String style) {
        
        StringBuilder sb = new StringBuilder();
        
        // 카테고리별 레인저 이름
        String rangerName = "";
        switch(category) {
            case "food":  rangerName = "맛레인저"; break;
            case "drink": rangerName = "드링크레인저"; break;
            case "movie": rangerName = "무비레인저"; break;
            case "book":  rangerName = "북레인저"; break;
            case "music": rangerName = "뮤직레인저"; break;
        }
        
        sb.append("당신은 '" + rangerName + "'입니다.\n\n");
        
        // 사용자가 선택한 답변
        sb.append("=== 사용자의 오늘 선택 ===\n");
        sb.append("- 질문1 답변: ").append(q1).append("\n");
        sb.append("- 질문2 답변: ").append(q2).append("\n");
        sb.append("- 질문3 답변: ").append(q3).append("\n");
        sb.append("- 질문4 답변: ").append(q4).append("\n\n");
        
        // 로그인한 경우 회원 정보 추가
        if (isLogin) {
            sb.append("=== 회원 정보 (참고) ===\n");
            if (preference != null && !preference.isEmpty()) {
                sb.append("- 평소 좋아하는 것: ").append(preference).append("\n");
            }
            if (allergy != null && !allergy.isEmpty()) {
                sb.append("- ⚠️ 알레르기 (절대 추천 금지!): ").append(allergy).append("\n");
            }
            sb.append("\n");
        }
        
        // 요청사항
        sb.append("=== 요청 ===\n");
        sb.append("위 조건에 맞는 추천 3가지를 해주세요.\n");
        sb.append("각 추천마다 이유도 간단히 설명해주세요.\n\n");
        
        // 말투 설정
        if (isLogin && style != null && !style.isEmpty()) {
            switch(style) {
                case "반말":
                    sb.append("친근한 반말로 답변해줘!\n");
                    break;
                case "메이드":
                    sb.append("메이드 말투로 답변해주세요, 주인님~!\n");
                    break;
                default:
                    sb.append("정중한 존댓말로 답변해주세요.\n");
            }
        } else {
            sb.append("친근하고 재미있게 답변해주세요.\n");
        }
        
        return sb.toString();
    }
    
    
    /**
     * AI API 호출 (실제 구현은 나중에)
     */
   
    private String callAI(String prompt) {
        return AIClient.chat(prompt);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		doGet(request, response);
	}

}
