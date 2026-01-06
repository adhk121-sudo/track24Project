<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String tab = request.getParameter("tab");
  if(tab == null) tab = "profile";
%>
<%
String mpSessionId = (String)session.getAttribute("sessionId");
if(mpSessionId == null || mpSessionId.equals("")){
  response.sendRedirect(request.getContextPath() + "/Power?t_gubun=login");
  return;
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>마이페이지 | 결정러</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage.css">
</head>
<body>

  <!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp" %> 
  </header>

  <!-- 메인 컨텐츠 -->
  <div class="mypage-container">
    
    <!-- 왼쪽: 사이드 메뉴 -->
    <aside class="mp-sidebar">
      <div class="mp-profile">
        <div class="mp-avatar">😊</div>
        <div class="mp-name">${member.nickname}님</div>
        <div class="mp-email">${member.email_1}@${member.email_2}</div>
      </div>

      <ul class="mp-menu">
        <li class="mp-menu-item <%= "profile".equals(tab) ? "active" : "" %>" data-tab="profile">
          <span class="mp-icon">👤</span>
          <span>상세정보</span>
        </li>
        <li class="mp-menu-item <%= "taste".equals(tab) ? "active" : "" %>" data-tab="taste">
          <span class="mp-icon">🎯</span>
          <span>취향선택</span>
        </li>
        <li class="mp-menu-item" data-link="result_history.jsp">
          <span class="mp-icon">📊</span>
          <span>결과이력</span>
        </li>
        <li class="mp-menu-item" data-link="pw_change.jsp">
          <span class="mp-icon">🔐</span>
          <span>비밀번호 변경</span>
        </li>
      </ul>

      <div class="mp-logout">
        <a href="../auth/logout.jsp" class="btn-logout">로그아웃</a>
      </div>
    </aside>

    <!-- 오른쪽: 컨텐츠 -->
    <main class="mp-main">
      
      <!-- TAB 1: 상세정보 -->
      <div class="mp-panel <%= "profile".equals(tab) ? "active" : "" %>" data-tab="profile">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>👤 상세정보</h2>
            <p>내 기본 정보를 확인/수정할 수 있어요</p>
          </div>

          <form method="post" action="#" id="profileForm">
            <div class="mp-form-grid">
              <!-- 닉네임 -->
              <div class="field">
                <div class="label">닉네임</div>
                <input type="text" name="nickname" value="${member.nickname}" placeholder="닉네임">
              </div>

              <!-- 나이 -->
              <div class="field">
                <div class="label">나이</div>
                <input type="number" name="age" value="${member.age}" placeholder="예) 25" min="0" max="120">
              </div>

              <!-- 지역 -->
              <div class="field">
                <div class="label">지역</div>
                <select name="region">
                  <option value="">선택</option>
                  <option value="서울">서울</option>
                  <option value="경기">경기</option>
                  <option value="인천">인천</option>
                  <option value="부산">부산</option>
                  <option value="대구">대구</option>
                  <option value="광주">광주</option>
                  <option value="대전">대전</option>
                  <option value="울산">울산</option>
                  <option value="세종">세종</option>
                  <option value="강원">강원</option>
                  <option value="충북">충북</option>
                  <option value="충남">충남</option>
                  <option value="전북">전북</option>
                  <option value="전남">전남</option>
                  <option value="경북">경북</option>
                  <option value="경남">경남</option>
                  <option value="제주">제주</option>
                </select>
              </div>

              <!-- 성별 -->
              <div class="field">
                <div class="label">성별</div>
                <select name="gender">
                  <option value="">선택</option>
                  <option value="M">남</option>
                  <option value="F">여</option>
                  <option value="N">비공개</option>
                </select>
              </div>

              <!-- 이메일 (2칸) -->
              <div class="field span-2">
                <div class="label">이메일</div>
                <div class="email-row">
                  <input type="text" name="email_1" value="${member.email_1}" placeholder="example">
                  <span class="at">@</span>
                  <select name="email_2">
                    <option value="">선택</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="naver.com">naver.com</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="daum.net">daum.net</option>
                  </select>
                </div>
              </div>

              <!-- 전화번호 (2칸) -->
              <div class="field span-2">
                <div class="label">전화번호</div>
                <div class="phone-row">
                  <input type="text" name="mobile_1" maxlength="3" value="${member.mobile_1}" placeholder="010">
                  <span class="dash">-</span>
                  <input type="text" name="mobile_2" maxlength="4" value="${member.mobile_2}" placeholder="1234">
                  <span class="dash">-</span>
                  <input type="text" name="mobile_3" maxlength="4" value="${member.mobile_3}" placeholder="5678">
                </div>
              </div>

              <!-- MBTI -->
              <div class="field">
                <div class="label">MBTI</div>
                <input type="text" name="mbti" maxlength="4" value="${member.mbti}" placeholder="예) INFP">
              </div>

              <!-- 말투 -->
              <div class="field">
                <div class="label">말투</div>
                <select name="speech_style">
                  <option value="">선택</option>
                  <option value="formal">존댓말</option>
                  <option value="casual">반말</option>
                  <option value="mixed">상황에 따라</option>
                </select>
              </div>
            </div>

            <div class="mp-actions">
              <button type="submit" class="btn primary">💾 저장하기</button>
            </div>
          </form>
        </div>
      </div>

      <!-- TAB 2: 취향선택 -->
      <div class="mp-panel <%= "taste".equals(tab) ? "active" : "" %>" data-tab="taste">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>🎯 취향선택</h2>
            <p>좋아하는 것들을 선택해주세요! 추천이 더 정확해져요</p>
          </div>

          <form name="tasteForm" method="post" action="#" id="tasteForm">
            <!-- 음식 -->
            <div class="chip-group">
              <div class="chip-title">🍔 좋아하는 음식</div>
              <div class="checkbox-group" data-category="food">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_korean" name="food" value="한식">
                  <label class="checkbox-label" for="mp_food_korean"><span class="checkbox-box"></span><span>한식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_japanese" name="food" value="일식">
                  <label class="checkbox-label" for="mp_food_japanese"><span class="checkbox-box"></span><span>일식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_chinese" name="food" value="중식">
                  <label class="checkbox-label" for="mp_food_chinese"><span class="checkbox-box"></span><span>중식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_western" name="food" value="양식">
                  <label class="checkbox-label" for="mp_food_western"><span class="checkbox-box"></span><span>양식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_snack" name="food" value="분식">
                  <label class="checkbox-label" for="mp_food_snack"><span class="checkbox-box"></span><span>분식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_dessert" name="food" value="디저트">
                  <label class="checkbox-label" for="mp_food_dessert"><span class="checkbox-box"></span><span>디저트</span></label>
                </div>
              </div>
            </div>

            <!-- 음악 -->
            <div class="chip-group">
              <div class="chip-title">🎵 좋아하는 음악</div>
              <div class="checkbox-group" data-category="music">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_kpop" name="music" value="K-POP">
                  <label class="checkbox-label" for="mp_music_kpop"><span class="checkbox-box"></span><span>K-POP</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_hiphop" name="music" value="힙합">
                  <label class="checkbox-label" for="mp_music_hiphop"><span class="checkbox-box"></span><span>힙합</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_ballad" name="music" value="발라드">
                  <label class="checkbox-label" for="mp_music_ballad"><span class="checkbox-box"></span><span>발라드</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_edm" name="music" value="EDM">
                  <label class="checkbox-label" for="mp_music_edm"><span class="checkbox-box"></span><span>EDM</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_jazz" name="music" value="재즈">
                  <label class="checkbox-label" for="mp_music_jazz"><span class="checkbox-box"></span><span>재즈</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_rock" name="music" value="락">
                  <label class="checkbox-label" for="mp_music_rock"><span class="checkbox-box"></span><span>락</span></label>
                </div>
              </div>
            </div>

            <!-- 영화 -->
            <div class="chip-group">
              <div class="chip-title">🎬 좋아하는 영화</div>
              <div class="checkbox-group" data-category="movie">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_action" name="movie" value="액션">
                  <label class="checkbox-label" for="mp_movie_action"><span class="checkbox-box"></span><span>액션</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_romance" name="movie" value="로맨스">
                  <label class="checkbox-label" for="mp_movie_romance"><span class="checkbox-box"></span><span>로맨스</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_comedy" name="movie" value="코미디">
                  <label class="checkbox-label" for="mp_movie_comedy"><span class="checkbox-box"></span><span>코미디</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_sf" name="movie" value="SF">
                  <label class="checkbox-label" for="mp_movie_sf"><span class="checkbox-box"></span><span>SF</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_horror" name="movie" value="공포">
                  <label class="checkbox-label" for="mp_movie_horror"><span class="checkbox-box"></span><span>공포</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_drama" name="movie" value="드라마">
                  <label class="checkbox-label" for="mp_movie_drama"><span class="checkbox-box"></span><span>드라마</span></label>
                </div>
              </div>
            </div>

            <!-- 책 -->
            <div class="chip-group">
              <div class="chip-title">📚 좋아하는 책</div>
              <div class="checkbox-group" data-category="book">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_novel" name="book" value="소설">
                  <label class="checkbox-label" for="mp_book_novel"><span class="checkbox-box"></span><span>소설</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_self" name="book" value="자기계발">
                  <label class="checkbox-label" for="mp_book_self"><span class="checkbox-box"></span><span>자기계발</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_economy" name="book" value="경제">
                  <label class="checkbox-label" for="mp_book_economy"><span class="checkbox-box"></span><span>경제</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_human" name="book" value="인문">
                  <label class="checkbox-label" for="mp_book_human"><span class="checkbox-box"></span><span>인문</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_comic" name="book" value="만화">
                  <label class="checkbox-label" for="mp_book_comic"><span class="checkbox-box"></span><span>만화</span></label>
                </div>
              </div>
            </div>

            <!-- 알레르기 -->
            <div class="chip-group">
              <div class="chip-title">⚠️ 알레르기</div>
              <div class="checkbox-group" data-category="allergy">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_nut" name="allergy" value="견과류">
                  <label class="checkbox-label" for="mp_allergy_nut"><span class="checkbox-box"></span><span>견과류</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_milk" name="allergy" value="우유">
                  <label class="checkbox-label" for="mp_allergy_milk"><span class="checkbox-box"></span><span>우유</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_egg" name="allergy" value="계란">
                  <label class="checkbox-label" for="mp_allergy_egg"><span class="checkbox-box"></span><span>계란</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_wheat" name="allergy" value="밀">
                  <label class="checkbox-label" for="mp_allergy_wheat"><span class="checkbox-box"></span><span>밀</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_seafood" name="allergy" value="갑각류">
                  <label class="checkbox-label" for="mp_allergy_seafood"><span class="checkbox-box"></span><span>갑각류</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_soy" name="allergy" value="대두">
                  <label class="checkbox-label" for="mp_allergy_soy"><span class="checkbox-box"></span><span>대두</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_none" name="allergy" value="없음">
                  <label class="checkbox-label" for="mp_allergy_none"><span class="checkbox-box"></span><span>없음</span></label>
                </div>
              </div>
            </div>

            <div class="mp-actions">
              <button type="submit" class="btn primary">💾 수정하기</button>
            </div>
          </form>
        </div>
      </div>

    </main>
  </div>

  <!-- 푸터 -->
  <footer class="footer">
  <%@ include file="../common/common_footer.jsp" %>
</footer>

  <!-- 스크립트 -->
  <script>
    // 탭 전환
    document.querySelectorAll('.mp-menu-item').forEach(item => {
      item.addEventListener('click', function() {
        const tab = this.dataset.tab;
        const link = this.dataset.link;

        if (link) {
          location.href = link;
          return;
        }

        if (tab) {
          // 메뉴 활성화
          document.querySelectorAll('.mp-menu-item').forEach(m => m.classList.remove('active'));
          this.classList.add('active');

          // 패널 전환
          document.querySelectorAll('.mp-panel').forEach(p => p.classList.remove('active'));
          document.querySelector('.mp-panel[data-tab="' + tab + '"]').classList.add('active');

          // URL 변경 (새로고침 없이)
          history.pushState(null, '', '?tab=' + tab);
        }
      });
    });
  </script>
</body>
</html>
