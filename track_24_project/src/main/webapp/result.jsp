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
    
    String mainName = "";
    String mainSub = "";      // 식당/카페/감독/저자/가수
    String mainGenre = "";    // 장르
    String mainReason = "";
    
    String sub1Name = "";
    String sub1Sub = "";
    String sub1Genre = "";
    String sub1Reason = "";
    
    String sub2Name = "";
    String sub2Sub = "";
    String sub2Genre = "";
    String sub2Reason = "";
    
    // 카테고리별 파싱 키워드
    String nameKey = "";
    String subKey = "";
    
    if(category != null) {
        switch(category) {
            case "food":  nameKey = "메뉴:"; subKey = "식당:"; break;
            case "drink": nameKey = "음료:"; subKey = "카페:"; break;
            case "movie": nameKey = "영화:"; subKey = "감독:"; break;
            case "book":  nameKey = "책:";   subKey = "저자:"; break;
            case "music": nameKey = "노래:"; subKey = "가수:"; break;
        }
    }
    
    if(result != null && nameKey.length() > 0) {
        
        // ===== 메인 추천 파싱 =====
        if(result.contains("[메인추천]")) {
            int mainStart = result.indexOf("[메인추천]");
            int mainEnd = result.indexOf("[서브추천1]");
            if(mainEnd == -1) mainEnd = result.length();
            String mainPart = result.substring(mainStart, mainEnd);
            
            // 이름 (메뉴/음료/영화/책/노래)
            if(mainPart.contains(nameKey)) {
                int start = mainPart.indexOf(nameKey) + nameKey.length();
                int end = mainPart.indexOf("\n", start);
                if(end == -1) end = mainPart.length();
                mainName = mainPart.substring(start, end).trim();
            }
            
            // 서브 (식당/카페/감독/저자/가수)
            if(mainPart.contains(subKey)) {
                int start = mainPart.indexOf(subKey) + subKey.length();
                int end = mainPart.indexOf("\n", start);
                if(end == -1) end = mainPart.length();
                mainSub = mainPart.substring(start, end).trim();
            }
            
            // 장르
            if(mainPart.contains("장르:")) {
                int start = mainPart.indexOf("장르:") + 3;
                int end = mainPart.indexOf("\n", start);
                if(end == -1) end = mainPart.length();
                mainGenre = mainPart.substring(start, end).trim();
            }
            
            // 이유
            if(mainPart.contains("이유:")) {
                int start = mainPart.indexOf("이유:") + 3;
                int end = mainPart.indexOf("\n", start);
                if(end == -1) end = mainPart.length();
                mainReason = mainPart.substring(start, end).trim();
            }
        }
        
        // ===== 서브 추천1 파싱 =====
        if(result.contains("[서브추천1]")) {
            int sub1Start = result.indexOf("[서브추천1]");
            int sub1End = result.indexOf("[서브추천2]");
            if(sub1End == -1) sub1End = result.length();
            String sub1Part = result.substring(sub1Start, sub1End);
            
            if(sub1Part.contains(nameKey)) {
                int start = sub1Part.indexOf(nameKey) + nameKey.length();
                int end = sub1Part.indexOf("\n", start);
                if(end == -1) end = sub1Part.length();
                sub1Name = sub1Part.substring(start, end).trim();
            }
            if(sub1Part.contains(subKey)) {
                int start = sub1Part.indexOf(subKey) + subKey.length();
                int end = sub1Part.indexOf("\n", start);
                if(end == -1) end = sub1Part.length();
                sub1Sub = sub1Part.substring(start, end).trim();
            }
            if(sub1Part.contains("장르:")) {
                int start = sub1Part.indexOf("장르:") + 3;
                int end = sub1Part.indexOf("\n", start);
                if(end == -1) end = sub1Part.length();
                sub1Genre = sub1Part.substring(start, end).trim();
            }
            if(sub1Part.contains("이유:")) {
                int start = sub1Part.indexOf("이유:") + 3;
                int end = sub1Part.indexOf("\n", start);
                if(end == -1) end = sub1Part.length();
                sub1Reason = sub1Part.substring(start, end).trim();
            }
        }
        
        // ===== 서브 추천2 파싱 =====
        if(result.contains("[서브추천2]")) {
            int sub2Start = result.indexOf("[서브추천2]");
            String sub2Part = result.substring(sub2Start);
            
            if(sub2Part.contains(nameKey)) {
                int start = sub2Part.indexOf(nameKey) + nameKey.length();
                int end = sub2Part.indexOf("\n", start);
                if(end == -1) end = sub2Part.length();
                sub2Name = sub2Part.substring(start, end).trim();
            }
            if(sub2Part.contains(subKey)) {
                int start = sub2Part.indexOf(subKey) + subKey.length();
                int end = sub2Part.indexOf("\n", start);
                if(end == -1) end = sub2Part.length();
                sub2Sub = sub2Part.substring(start, end).trim();
            }
            if(sub2Part.contains("장르:")) {
                int start = sub2Part.indexOf("장르:") + 3;
                int end = sub2Part.indexOf("\n", start);
                if(end == -1) end = sub2Part.length();
                sub2Genre = sub2Part.substring(start, end).trim();
            }
            if(sub2Part.contains("이유:")) {
                int start = sub2Part.indexOf("이유:") + 3;
                int end = sub2Part.indexOf("\n", start);
                if(end == -1) end = sub2Part.length();
                sub2Reason = sub2Part.substring(start, end).trim();
            }
        }
    }
 // 카테고리별 서브 라벨
    String subLabel = "";
    if(category != null) {
        switch(category) {
            case "food":  subLabel = "🏠"; break;
            case "drink": subLabel = "☕"; break;
            case "movie": subLabel = "🎬"; break;
            case "book":  subLabel = "✍️"; break;
            case "music": subLabel = "🎤"; break;
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
    <% if(!mainSub.isEmpty()) { %>
        <p class="main-sub"><%=subLabel%> <%=mainSub%></p>
    <% } %>
    <% if(!mainGenre.isEmpty()) { %>
        <span class="main-genre">#<%=mainGenre%></span>
    <% } %>
    <p class="main-reason"><%=mainReason%></p>
</div>

<!-- ⭐ 서브 추천 카드 -->
<div class="sub-recommend-wrap">
    <h3 class="sub-title">이것도 추천해요!</h3>
    <div class="sub-cards">
        <div class="sub-card">
            <div class="sub-badge">2nd</div>
            <h4 class="sub-name"><%=sub1Name%></h4>
            <% if(!sub1Sub.isEmpty()) { %>
                <p class="sub-sub"><%=subLabel%> <%=sub1Sub%></p>
            <% } %>
            <% if(!sub1Genre.isEmpty()) { %>
                <span class="sub-genre">#<%=sub1Genre%></span>
            <% } %>
            <p class="sub-reason"><%=sub1Reason%></p>
        </div>
        <div class="sub-card">
            <div class="sub-badge">3rd</div>
            <h4 class="sub-name"><%=sub2Name%></h4>
            <% if(!sub2Sub.isEmpty()) { %>
                <p class="sub-sub"><%=subLabel%> <%=sub2Sub%></p>
            <% } %>
            <% if(!sub2Genre.isEmpty()) { %>
                <span class="sub-genre">#<%=sub2Genre%></span>
            <% } %>
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