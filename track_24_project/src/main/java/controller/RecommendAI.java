package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
import dto.HistoryDto;
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
        List<String> pastRecommends = new ArrayList<>();

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
            	
            	// ⭐ 과거 추천 이력 가져오기 (최근 10개)
                List<HistoryDto> historyList = dao.getRecentHistoryRefer(sessionId, category, 10);
                for (HistoryDto h : historyList) {
                    if (h.getMainName() != null && !h.getMainName().isEmpty()) {
                        pastRecommends.add(h.getMainName());
            }
        }
     // ===== 4. AI 프롬프트 생성 =====
        String prompt = makePrompt(category, q1, q2, q3, q4, 
                                   isLogin, memberPreference, memberAllergy, speechStyle,age,pastRecommends);
        
    
        
        
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
        }
    }
	   
    // ========================================
    // private 메서드: 이 클래스 내부에서만 사용
    // ========================================
    
    /**
     * AI에게 보낼 프롬프트(질문) 생성
     */
	private String makePrompt(String category, String q1, String q2, String q3, String q4,
            boolean isLogin, String preference, String allergy, String style, String age, 
            List<String> pastRecommends) {

StringBuilder sb = new StringBuilder();

// 카테고리별 설정
String rangerName = "";
String target = "";

switch(category) {
case "food":  rangerName = "맛레인저"; target = "음식"; break;
case "drink": rangerName = "드링크레인저"; target = "음료"; break;
case "movie": rangerName = "무비레인저"; target = "영화"; break;
case "book":  rangerName = "북레인저"; target = "책"; break;
case "music": rangerName = "뮤직레인저"; target = "노래"; break;
}

sb.append("당신은 '" + rangerName + "'입니다.\n");
sb.append("사용자에게 **" + target + "**을 추천합니다.\n\n");

// ⭐ 1. 과거 이력 제외 (맨 앞에 강조!)
if (pastRecommends != null && !pastRecommends.isEmpty()) {
sb.append("★★★★★ 절대 추천 금지 목록 ★★★★★\n");
sb.append("아래 항목들은 이미 추천받았습니다. 절대로 다시 추천하지 마세요!\n");
for (String past : pastRecommends) {
sb.append("❌ " + past + " (이미 추천함 - 제외!)\n");
}
sb.append("위 목록에 없는 새로운 " + target + "만 추천하세요!\n");
sb.append("★★★★★★★★★★★★★★★★★★★★★★\n\n");
}

// ⭐ 2. 말투 설정
sb.append("=== 말투 설정 ===\n");
if (isLogin && style != null && !style.isEmpty()) {
switch(style) {
case "반말":
  sb.append("반말로 답변해! 예: ~해, ~야, ~지\n\n");
  break;
case "메이드":
  sb.append("메이드 말투로! 예: '주인님~ 추천드릴게요, 냥!'\n\n");
  break;
default:
  sb.append("존댓말로 답변해주세요.\n\n");
}
} else {
sb.append("친근하게 답변해주세요.\n\n");
}

// ⭐ 3. 사용자 선택 조건 (가장 중요!)
sb.append("★★★ 필수 조건 (반드시 지켜야 함!) ★★★\n");

switch(category) {
case "food":
sb.append("1. 기분: " + q1 + "\n");
sb.append("2. 시간대: " + q2 + "\n");
sb.append("3. 원하는 맛: [" + q3 + "] ← 이 맛의 음식만 추천!\n");
sb.append("4. 동행: " + q4 + "\n\n");
sb.append("※ '" + q3 + "' 맛이 아닌 음식은 절대 추천하지 마세요!\n");
break;

case "drink":
sb.append("1. 기분: " + q1 + "\n");
sb.append("2. 온도: [" + q2 + "] ← 이 온도의 음료만!\n");
sb.append("3. 종류: [" + q3 + "] ← 이 종류의 음료만!\n");
sb.append("4. 단맛: " + q4 + "\n\n");
sb.append("※ 중요: '" + q3 + "' 종류만 추천!\n");
sb.append("※ 예시:\n");
sb.append("   - '커피' 선택 → 아메리카노, 라떼, 카푸치노 등\n");
sb.append("   - '주스/에이드' 선택 → 오렌지주스, 레몬에이드, 자몽에이드 등\n");
sb.append("   - '차' 선택 → 녹차, 홍차, 캐모마일 등\n");
sb.append("   - '스무디/쉐이크' 선택 → 딸기스무디, 망고쉐이크 등\n");
sb.append("※ 다른 종류는 절대 추천하지 마세요!\n");
break;

case "movie":
sb.append("1. 기분: " + q1 + "\n");
sb.append("2. 장르: [" + q2 + "] ← 이 장르의 영화만!\n");
sb.append("3. 분위기: " + q3 + "\n");
sb.append("4. 동행: " + q4 + "\n\n");
sb.append("※ '" + q2 + "' 장르가 아닌 영화는 절대 추천하지 마세요!\n");
break;

case "book":
sb.append("1. 기분: " + q1 + "\n");
sb.append("2. 장르: [" + q2 + "] ← 이 장르의 책만!\n");
sb.append("3. 분량: " + q3 + "\n");
sb.append("4. 목적: " + q4 + "\n\n");
sb.append("※ '" + q2 + "' 장르가 아닌 책은 절대 추천하지 마세요!\n");
break;

case "music":
sb.append("1. 기분: " + q1 + "\n");
sb.append("2. 장르: [" + q2 + "] ← 이 장르의 노래만!\n");
sb.append("3. 상황: " + q3 + "\n");
sb.append("4. 템포: [" + q4 + "] ← 이 템포의 노래만!\n\n");
sb.append("※ 중요: '" + q2 + "' 장르 + '" + q4 + "' 템포 노래만!\n");
sb.append("※ 예시:\n");
sb.append("   - 'K-POP' + '신나는' → BTS, 뉴진스, 에스파 등의 댄스곡\n");
sb.append("   - '발라드' + '잔잔한' → 성시경, 폴킴 등의 발라드\n");
sb.append("   - '힙합/R&B' + '신나는' → 지코, 아이유(힙합곡) 등\n");
sb.append("※ 다른 장르/템포는 절대 추천하지 마세요!\n");

break;
}
sb.append("\n");

// ⭐ 4. 회원 정보
if (isLogin) {
sb.append("=== 회원 정보 (참고) ===\n");
if (age != null && !age.isEmpty()) {
sb.append("- 나이: " + age + "세\n");
sb.append("※ 나이와 세대에 맞게 추천해주세요!\n");
}
if (preference != null && !preference.isEmpty()) {
sb.append("- 좋아하는 것: " + preference + "\n");
}
if (allergy != null && !allergy.isEmpty()) {
sb.append("- ⚠️ 알레르기: " + allergy + " (절대 금지!)\n");
}
sb.append("\n");
}

// ⭐ 5. 답변 형식
sb.append("=== 답변 형식 (정확히 따라주세요) ===\n");

switch(category) {
case "food":
sb.append("[메인추천]\n");
sb.append("메뉴: ('" + q3 + "' 맛의 구체적인 음식명)\n");
sb.append("식당: (식당 유형)\n");
sb.append("이유: (2-3문장)\n\n");
sb.append("[서브추천1]\n메뉴:\n식당:\n이유:\n\n");
sb.append("[서브추천2]\n메뉴:\n식당:\n이유:\n");
break;

case "drink":
sb.append("[메인추천]\n");
sb.append("음료: ('" + q2 + "' 온도의 '" + q3 + "' 음료명)\n");
sb.append("카페: (카페명)\n");
sb.append("이유: (2-3문장)\n\n");
sb.append("[서브추천1]\n음료:\n카페:\n이유:\n\n");
sb.append("[서브추천2]\n음료:\n카페:\n이유:\n");
break;

case "movie":
sb.append("[메인추천]\n");
sb.append("영화: ('" + q2 + "' 장르의 실제 영화 제목)\n");
sb.append("감독: (감독명)\n");
sb.append("장르: " + q2 + "\n");
sb.append("이유: (2-3문장)\n\n");
sb.append("[서브추천1]\n영화:\n감독:\n장르:\n이유:\n\n");
sb.append("[서브추천2]\n영화:\n감독:\n장르:\n이유:\n");
break;

case "book":
sb.append("[메인추천]\n");
sb.append("책: ('" + q2 + "' 장르의 실제 책 제목)\n");
sb.append("저자: (저자명)\n");
sb.append("장르: " + q2 + "\n");
sb.append("이유: (2-3문장)\n\n");
sb.append("[서브추천1]\n책:\n저자:\n장르:\n이유:\n\n");
sb.append("[서브추천2]\n책:\n저자:\n장르:\n이유:\n");
break;

case "music":
sb.append("[메인추천]\n");
sb.append("노래: ('" + q2 + "' 장르의 '" + q4 + "' 템포 노래)\n");
sb.append("가수: (가수명)\n");
sb.append("장르: " + q2 + "\n");
sb.append("이유: (2-3문장)\n\n");
sb.append("[서브추천1]\n노래:\n가수:\n장르:\n이유:\n\n");
sb.append("[서브추천2]\n노래:\n가수:\n장르:\n이유:\n");
break;
}

sb.append("\n※ 실제로 존재하는 " + target + "만 추천하세요!\n");

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
