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
		if(category != null) category = category.toLowerCase();
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
        String age="";
        

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
            	age= member.getAge();
            }
        }
     // ===== 4. AI 프롬프트 생성 =====
        String prompt = makePrompt(category, q1, q2, q3, q4, 
                                   isLogin, memberPreference, memberAllergy, speechStyle,age);
        
    
        
        
        // ===== 5. AI API 호출 =====
        String aiResponse = callAI(prompt);
        
     // ===== 5-1. (로그인 시) 결과이력 DB 저장 =====
        boolean ok = (aiResponse != null
                && aiResponse.contains("[메인추천]")
                && !aiResponse.contains("401")
                && !aiResponse.contains("invalid_api_key"));

        if (isLogin && ok) {
            ParsedRecommend pr = parseMainRecommend(category, aiResponse);
            dao.insertRecommendHistory(
                sessionId,
                category,
                pr.title,
                pr.mainName,
                pr.genre,
                pr.reason,
                q1, q2, q3, q4,
                aiResponse
            );
        }
        if (!ok) {
            request.setAttribute("apiError", aiResponse); // aiResponse에 401 내용이 들어가게 AIClient도 수정하면 더 좋음
        }
        
        // ===== 6. 결과 담기 =====
        request.setAttribute("category", category);
        request.setAttribute("q1", q1);
        request.setAttribute("q2", q2);
        request.setAttribute("q3", q3);
        request.setAttribute("q4", q4);
        request.setAttribute("result", aiResponse);
        request.setAttribute("isLogin", isLogin);
        
        // ===== 7. 통합 결과 페이지로 이동 =====
        RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
        rd.forward(request, response);
    }
	   
    // ========================================
    // private 메서드: 이 클래스 내부에서만 사용
    // ========================================
    
    /**
     * AI에게 보낼 프롬프트(질문) 생성
     */
    private String makePrompt(String category, String q1, String q2, String q3, String q4,
                              boolean isLogin, String preference, String allergy, String style,String age) {
        
        StringBuilder sb = new StringBuilder();
        
        
        // 카테고리별 설정
        String rangerName = "";
        String target = "";  // ⭐ 추천 대상 추가!
        
        switch(category) {
            case "food":  
                rangerName = "맛레인저"; 
                target = "음식 메뉴";
                break;
            case "drink": 
                rangerName = "드링크레인저"; 
                target = "음료 메뉴";
                break;
            case "movie": 
                rangerName = "무비레인저"; 
                target = "영화";
                break;
            case "book":  
                rangerName = "북레인저"; 
                target = "읽을 책 (도서)";  // ⭐ 명확하게!
                break;
            case "music": 
                rangerName = "뮤직레인저"; 
                target = "노래 (음악)";
                break;
        }
        
        sb.append("당신은 '" + rangerName + "'입니다.\n\n");
        
        // 사용자가 선택한 답변
        sb.append("=== 사용자의 오늘 선택 ===\n");
        sb.append("- 질문1 답변: ").append(q1).append("\n");
        sb.append("- 질문2 답변: ").append(q2).append("\n");
        sb.append("- 질문3 답변: ").append(q3).append("\n");
        sb.append("- 질문4 답변: ").append(q4).append("\n\n");
        
        
        
        // 로그인한 경우 회원 정보 추가
     // ⭐ 로그인한 경우 회원 정보 (나이 추가!)
        if (isLogin) {
            sb.append("=== 회원 정보 ===\n");
            if (age != null && !age.isEmpty()) {
                sb.append("- 나이: " + age + "세 ← 이 연령대에 맞는 추천!\n");
            }
            if (preference != null && !preference.isEmpty()) {
                sb.append("- 평소 좋아하는 것: " + preference + "\n");
            }
            if (allergy != null && !allergy.isEmpty()) {
                sb.append("- ⚠️ 알레르기 (절대 추천 금지!): " + allergy + "\n");
            }
            sb.append("\n");
        }
        
     // ⭐ 수정된 요청사항 - 더 명확하게!
        
        sb.append("★★★ 말투 설정 (반드시 지켜야 함!) ★★★\n");
        if (isLogin && style != null && !style.isEmpty()) {
            switch(style) {
                case "반말":
                    sb.append("모든 답변을 친근한 반말로 해줘! 예: ~해, ~야, ~지, ~거든\n\n");
                    break;
                case "메이드":
                    sb.append("모든 답변을 메이드 말투로 해주세요!\n");
                    sb.append("예시: '주인님~ 추천해드릴게요, 냥!' '이건 정말 맛있답니다, 주인님~' '어떠세요, 냥?'\n");
                    sb.append("문장 끝에 '~냥', '~주인님', '~드릴게요' 등을 붙여주세요!\n\n");
                    break;
                default:
                    sb.append("정중한 존댓말로 답변해주세요. 예: ~해요, ~습니다, ~세요\n\n");
            }
        } else {
            sb.append("친근하고 재미있게 답변해주세요.\n\n");
        }
        
        
        sb.append("=== 요청 ===\n");
        sb.append("반드시 **" + target + "**만 추천해주세요!\n");  // ⭐ 강조!
        sb.append("아래 형식으로 정확히 답변해주세요:\n\n");
        sb.append("★★★ 사용자가 질문에 답한 조건은 (반드시 지켜야 함!) ★★★\n");
        
        switch(category) {
            case "food":
                sb.append("[메인추천]\n");
                sb.append("메뉴: (구체적인 음식 이름, 예: 김치찌개, 까르보나라, 제육볶음)\n");
                sb.append("식당: (추천 식당 유형, 예: 한식당, 이탈리안 레스토랑, 분식집)\n");
                sb.append("이유: (왜 이 메뉴를 추천하는지 2-3문장)\n\n");
                sb.append("[서브추천1]\n");
                sb.append("메뉴: (구체적인 음식 이름)\n");
                sb.append("식당: (추천 식당 유형)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("[서브추천2]\n");
                sb.append("메뉴: (구체적인 음식 이름)\n");
                sb.append("식당: (추천 식당 유형)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("※ 주의: 실제로 존재하는 구체적인 메뉴명을 추천해주세요!\n");
                break;
                
            case "drink":
                sb.append("[메인추천]\n");
                sb.append("음료: (구체적인 음료 이름, 예: 아이스 아메리카노, 딸기 스무디, 얼그레이 티)\n");
                sb.append("카페: (추천 카페, 예: 스타벅스, 투썸플레이스, 메가커피, 동네카페)\n");
                sb.append("이유: (왜 이 음료를 추천하는지 2-3문장)\n\n");
                sb.append("[서브추천1]\n");
                sb.append("음료: (구체적인 음료 이름)\n");
                sb.append("카페: (추천 카페)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("[서브추천2]\n");
                sb.append("음료: (구체적인 음료 이름)\n");
                sb.append("카페: (추천 카페)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("※ 주의: 실제로 주문할 수 있는 구체적인 음료명을 추천해주세요!\n");
                break;
                
            case "movie":
                sb.append("[메인추천]\n");
                sb.append("영화: (실제 영화 제목, 예: 인터스텔라, 파묘, 범죄도시4)\n");
                sb.append("장르: (영화 장르, 예: SF, 공포, 액션)\n");
                sb.append("감독: (감독 이름)\n");
                sb.append("이유: (왜 이 영화를 추천하는지 2-3문장)\n\n");
                sb.append("[서브추천1]\n");
                sb.append("영화: (실제 영화 제목)\n");
                sb.append("장르: (영화 장르)\n");
                sb.append("감독: (감독 이름)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("[서브추천2]\n");
                sb.append("영화: (실제 영화 제목)\n");
                sb.append("장르: (영화 장르)\n");
                sb.append("감독: (감독 이름)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("※ 주의: 실제로 존재하는 영화만 추천해주세요!\n");
                break;
                
            case "book":
                sb.append("[메인추천]\n");
                sb.append("책: (실제 책 제목, 예: 아몬드, 달러구트 꿈 백화점)\n");
                sb.append("저자: (저자 이름)\n");
                sb.append("장르: (책 장르, 예: 소설, 에세이, 자기계발)\n");
                sb.append("이유: (왜 이 책을 추천하는지 2-3문장)\n\n");
                sb.append("[서브추천1]\n");
                sb.append("책: (실제 책 제목)\n");
                sb.append("저자: (저자 이름)\n");
                sb.append("장르: (책 장르)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("[서브추천2]\n");
                sb.append("책: (실제 책 제목)\n");
                sb.append("저자: (저자 이름)\n");
                sb.append("장르: (책 장르)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("※ 주의: 실제로 존재하는 책만 추천해주세요!\n");
                break;
                
            case "music":
                sb.append("[메인추천]\n");
                sb.append("노래: (실제 노래 제목, 예: Ditto, 밤양갱, Super Shy)\n");
                sb.append("가수: (가수/아티스트 이름)\n");
                sb.append("장르: (음악 장르, 예: K-POP, 발라드, 힙합)\n");
                sb.append("이유: (왜 이 노래를 추천하는지 2-3문장)\n\n");
                sb.append("[서브추천1]\n");
                sb.append("노래: (실제 노래 제목)\n");
                sb.append("가수: (가수/아티스트 이름)\n");
                sb.append("장르: (음악 장르)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("[서브추천2]\n");
                sb.append("노래: (실제 노래 제목)\n");
                sb.append("가수: (가수/아티스트 이름)\n");
                sb.append("장르: (음악 장르)\n");
                sb.append("이유: (간단한 이유 1문장)\n\n");
                sb.append("※ 주의: 실제로 존재하는 노래만 추천해주세요!\n");
                break;
        }
        
        
        sb.append("★★★ 중요 ★★★\n");
        sb.append("사용자가 선택한 조건과 다른 것은 절대 추천하지 마세요!\n");
        sb.append("조건에 맞지 않는 추천은 사용자를 불쾌하게 합니다.\n\n");
        sb.append("※ 주의: " + target + " 외에 다른 것은 절대 추천하지 마세요!\n\n");  // ⭐ 경고 추가!
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
        
        sb.append("\n★ 위에서 지정한 말투로 답변하세요! ★\n");
        return sb.toString();
    }
    
    
    /**
     * AI API 호출 (실제 구현은 나중에)
     */
   
    // =====================================================
    // 결과이력 저장용 파서 (메인추천만 추출)
    // =====================================================
    private static class ParsedRecommend {
        String title = "";     // 메뉴/음료/영화/책/노래
        String mainName = "";  // 식당/카페/감독/저자/가수
        String genre = "";
        String reason = "";
    }

    private ParsedRecommend parseMainRecommend(String category, String result) {
        ParsedRecommend pr = new ParsedRecommend();
        if (result == null || category == null) return pr;

        String nameKey = "";
        String subKey  = "";

        switch (category) {
            case "food":  nameKey = "메뉴:"; subKey = "식당:"; break;
            case "drink": nameKey = "음료:"; subKey = "카페:"; break;
            case "movie": nameKey = "영화:"; subKey = "감독:"; break;
            case "book":  nameKey = "책:";   subKey = "저자:"; break;
            case "music": nameKey = "노래:"; subKey = "가수:"; break;
            default: return pr;
        }

        // [메인추천] 블록만 자르기
        String mainPart = result;
        int start = result.indexOf("[메인추천]");
        if (start != -1) {
            int end = result.indexOf("[서브추천1]");
            if (end == -1) end = result.length();
            mainPart = result.substring(start, end);
        }

        pr.title    = pickLineValue(mainPart, nameKey);
        pr.mainName = pickLineValue(mainPart, subKey);
        pr.genre    = pickLineValue(mainPart, "장르:");
        pr.reason   = pickLineValue(mainPart, "이유:");

        return pr;
    }

    private String pickLineValue(String block, String key) {
        if (block == null || key == null) return "";
        int s = block.indexOf(key);
        if (s == -1) return "";
        s += key.length();
        int e = block.indexOf("\n", s);
        if (e == -1) e = block.length();
        return block.substring(s, e).trim();
    }

    
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
