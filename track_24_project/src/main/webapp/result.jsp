<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String category = (String)request.getAttribute("category");
    String q1 = (String)request.getAttribute("q1");
    String q2 = (String)request.getAttribute("q2");
    String q3 = (String)request.getAttribute("q3");
    String q4 = (String)request.getAttribute("q4");
    String result = (String)request.getAttribute("result");
    
    // 카테고리별 설정
    String theme = "";
    String icon = "";
    String title = "";
    String emoji = "";
    String color = "";
    
    if(category != null) {
        switch(category) {
            case "food":
                theme = "theme-food";
                icon = "food_ranger.png";
                title = "맛레인저";
                emoji = "🍜";
                color = "#f97316";
                break;
            case "drink":
                theme = "theme-drink";
                icon = "drink_ranger.png";
                title = "드링크레인저";
                emoji = "🥤";
                color = "#eab308";
                break;
            case "movie":
                theme = "theme-movie";
                icon = "movie_ranger.png";
                title = "무비레인저";
                emoji = "🎬";
                color = "#a855f7";
                break;
            case "book":
                theme = "theme-book";
                icon = "book_ranger.png";
                title = "북레인저";
                emoji = "📚";
                color = "#22c55e";
                break;
            case "music":
                theme = "theme-music";
                icon = "music_ranger.png";
                title = "뮤직레인저";
                emoji = "🎵";
                color = "#3b82f6";
                break;
        }
    }
    
    // ⭐ AI 결과 파싱
    String mainName = "";
    String mainReason = "";
    String sub1Name = "";
    String sub1Reason = "";
    String sub2Name = "";
    String sub2Reason = "";
    
    if(result != null) {
        // 메인 추천 파싱
        if(result.contains("[메인추천]")) {
            int mainStart = result.indexOf("[메인추천]");
            int mainEnd = result.indexOf("[서브추천1]");
            if(mainEnd == -1) mainEnd = result.length();
            String mainPart = result.substring(mainStart, mainEnd);
            
            if(mainPart.contains("이름:")) {
                int nameStart = mainPart.indexOf("이름:") + 3;
                int nameEnd = mainPart.indexOf("\n", nameStart);
                if(nameEnd == -1) nameEnd = mainPart.length();
                mainName = mainPart.substring(nameStart, nameEnd).trim();
            }
            if(mainPart.contains("이유:")) {
                int reasonStart = mainPart.indexOf("이유:") + 3;
                int reasonEnd = mainPart.indexOf("\n", reasonStart);
                if(reasonEnd == -1) reasonEnd = mainPart.length();
                mainReason = mainPart.substring(reasonStart, reasonEnd).trim();
            }
        }
        
        // 서브 추천1 파싱
        if(result.contains("[서브추천1]")) {
            int sub1Start = result.indexOf("[서브추천1]");
            int sub1End = result.indexOf("[서브추천2]");
            if(sub1End == -1) sub1End = result.length();
            String sub1Part = result.substring(sub1Start, sub1End);
            
            if(sub1Part.contains("이름:")) {
                int nameStart = sub1Part.indexOf("이름:") + 3;
                int nameEnd = sub1Part.indexOf("\n", nameStart);
                if(nameEnd == -1) nameEnd = sub1Part.length();
                sub1Name = sub1Part.substring(nameStart, nameEnd).trim();
            }
            if(sub1Part.contains("이유:")) {
                int reasonStart = sub1Part.indexOf("이유:") + 3;
                int reasonEnd = sub1Part.indexOf("\n", reasonStart);
                if(reasonEnd == -1) reasonEnd = sub1Part.length();
                sub1Reason = sub1Part.substring(reasonStart, reasonEnd).trim();
            }
        }
        
        // 서브 추천2 파싱
        if(result.contains("[서브추천2]")) {
            int sub2Start = result.indexOf("[서브추천2]");
            String sub2Part = result.substring(sub2Start);
            
            if(sub2Part.contains("이름:")) {
                int nameStart = sub2Part.indexOf("이름:") + 3;
                int nameEnd = sub2Part.indexOf("\n", nameStart);
                if(nameEnd == -1) nameEnd = sub2Part.length();
                sub2Name = sub2Part.substring(nameStart, nameEnd).trim();
            }
            if(sub2Part.contains("이유:")) {
                int reasonStart = sub2Part.indexOf("이유:") + 3;
                int reasonEnd = sub2Part.indexOf("\n", reasonStart);
                if(reasonEnd == -1) reasonEnd = sub2Part.length();
                sub2Reason = sub2Part.substring(reasonStart, reasonEnd).trim();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=title%> 추천 결과 | 결정러</title>
    <link href="<%=request.getContextPath()%>/css/result.css" rel="stylesheet">
</head>
<body class="<%=theme%>">

    <!-- 헤더 -->
    <header class="header">
        <%@ include file="common/common_header.jsp" %>
    </header>

    <!-- 메인 -->
    <div class="result-wrap">
        
        <!-- 캐릭터 영역 -->
        <div class="character-section">
            <div class="character-icon">
                <img src="<%=request.getContextPath()%>/images/<%=icon%>" alt="<%=title%>">
            </div>
            <div class="character-speech">
                <span class="emoji"><%=emoji%></span>
                <span class="text"><%=title%>의 추천이야!</span>
            </div>
        </div>
        
        
        <!-- ⭐ 메인 추천 카드 -->
        <div class="main-recommend">
            <div class="main-badge">👑 BEST 추천</div>
            <h2 class="main-title"><%=mainName%></h2>
            <p class="main-reason"><%=mainReason%></p>
        </div>
        
        <!-- ⭐ 서브 추천 카드 -->
        <div class="sub-recommend-wrap">
            <h3 class="sub-title">이것도 추천해요!</h3>
            <div class="sub-cards">
                <div class="sub-card">
                    <div class="sub-badge">2nd</div>
                    <h4 class="sub-name"><%=sub1Name%></h4>
                    <p class="sub-reason"><%=sub1Reason%></p>
                </div>
                <div class="sub-card">
                    <div class="sub-badge">3rd</div>
                    <h4 class="sub-name"><%=sub2Name%></h4>
                    <p class="sub-reason"><%=sub2Reason%></p>
                </div>
            </div>
        </div>
        
        <!-- 버튼 -->
        <div class="actions">
            <a href="javascript:goPage('<%=category%>')" class="btn outline">
                <span>🔄</span> 다시 추천받기
            </a>
            <a href="Power" class="btn primary">
                <span>🏠</span> 홈으로
            </a>
        </div>
        
        <!-- 다른 레인저 추천 -->
        <div class="other-rangers">
            <h3>다른 레인저도 만나볼까?</h3>
            <div class="ranger-list">
                <% if(!"food".equals(category)) { %>
                    <a href="javascript:goPage('food')" class="ranger-item food">
                        <span class="emoji">🍜</span>
                        <span class="name">맛레인저</span>
                    </a>
                <% } %>
                <% if(!"drink".equals(category)) { %>
                    <a href="javascript:goPage('drink')" class="ranger-item drink">
                        <span class="emoji">🥤</span>
                        <span class="name">드링크레인저</span>
                    </a>
                <% } %>
                <% if(!"movie".equals(category)) { %>
                    <a href="javascript:goPage('movie')" class="ranger-item movie">
                        <span class="emoji">🎬</span>
                        <span class="name">무비레인저</span>
                    </a>
                <% } %>
                <% if(!"book".equals(category)) { %>
                    <a href="javascript:goPage('book')" class="ranger-item book">
                        <span class="emoji">📚</span>
                        <span class="name">북레인저</span>
                    </a>
                <% } %>
                <% if(!"music".equals(category)) { %>
                    <a href="javascript:goPage('music')" class="ranger-item music">
                        <span class="emoji">🎵</span>
                        <span class="name">뮤직레인저</span>
                    </a>
                <% } %>
            </div>
        </div>
        
    </div>

    <!-- 푸터 -->
    <footer class="footer">
        <%@ include file="common/common_footer.jsp" %>
    </footer>

    <script>
        function goPage(gubun) {
            location.href = "Power?t_gubun=" + gubun;
        }
    </script>
</body>
</html>