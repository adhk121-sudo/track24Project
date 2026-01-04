<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>결과 이력 | 결정러</title>
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
        <li class="mp-menu-item" data-link="mypage.jsp?tab=profile">
          <span class="mp-icon">👤</span>
          <span>상세정보</span>
        </li>
        <li class="mp-menu-item" data-link="mypage.jsp?tab=taste">
          <span class="mp-icon">🎯</span>
          <span>취향선택</span>
        </li>
        <li class="mp-menu-item active" data-link="result_history.jsp">
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
      <div class="mp-panel active">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>📊 결과 이력</h2>
            <p>내가 선택했던 결과 기록이에요</p>
          </div>

          <!-- 필터 -->
          <div class="history-filter">
            <select id="historyFilter">
              <option value="all">전체</option>
              <option value="food">🍜 음식</option>
              <option value="movie">🎬 영화</option>
              <option value="book">📚 책</option>
              <option value="music">🎵 음악</option>
            </select>
          </div>

          <!-- 이력 리스트 -->
          <div class="history-list">
            <!-- 이력 아이템 1 -->
            <div class="history-item" data-type="food">
              <div class="history-icon food">🍜</div>
              <div class="history-content">
                <div class="history-title">점심 메뉴 추천</div>
                <div class="history-result">
                  <span class="badge food">제육볶음</span>
                </div>
                <div class="history-date">2025-12-25 12:30</div>
              </div>
            </div>

            <!-- 이력 아이템 2 -->
            <div class="history-item" data-type="movie">
              <div class="history-icon movie">🎬</div>
              <div class="history-content">
                <div class="history-title">오늘 볼 영화 추천</div>
                <div class="history-result">
                  <span class="badge movie">인터스텔라</span>
                </div>
                <div class="history-date">2025-12-24 20:15</div>
              </div>
            </div>

            <!-- 이력 아이템 3 -->
            <div class="history-item" data-type="food">
              <div class="history-icon food">🍜</div>
              <div class="history-content">
                <div class="history-title">치킨 추천</div>
                <div class="history-result">
                  <span class="badge food">슈프림 양념치킨</span>
                </div>
                <div class="history-date">2025-12-24 19:00</div>
              </div>
            </div>

            <!-- 이력 아이템 4 -->
            <div class="history-item" data-type="music">
              <div class="history-icon music">🎵</div>
              <div class="history-content">
                <div class="history-title">기분 전환 음악 추천</div>
                <div class="history-result">
                  <span class="badge music">Uptown Funk</span>
                </div>
                <div class="history-date">2025-12-23 15:45</div>
              </div>
            </div>

            <!-- 이력 아이템 5 -->
            <div class="history-item" data-type="book">
              <div class="history-icon book">📚</div>
              <div class="history-content">
                <div class="history-title">주말에 읽을 책 추천</div>
                <div class="history-result">
                  <span class="badge book">원씽</span>
                </div>
                <div class="history-date">2025-12-22 10:20</div>
              </div>
            </div>
          </div>

          <div class="history-hint">
            💡 최근 30일 이력만 표시돼요. 자세한 결과는 항목을 클릭해서 확인할 수 있어요!
          </div>

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
    // 메뉴 링크 이동
    document.querySelectorAll('.mp-menu-item').forEach(item => {
      item.addEventListener('click', function() {
        const link = this.dataset.link;
        if (link) location.href = link;
      });
    });

    // 필터
    document.getElementById('historyFilter').addEventListener('change', function() {
      const type = this.value;
      document.querySelectorAll('.history-item').forEach(item => {
        if (type === 'all' || item.dataset.type === type) {
          item.style.display = 'flex';
        } else {
          item.style.display = 'none';
        }
      });
    });
  </script>
</body>
</html>
