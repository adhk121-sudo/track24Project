<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>비밀번호 변경 | 결정러</title>
  <link rel="stylesheet" href="../css/mypage.css">
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
        <li class="mp-menu-item" data-link="result_history.jsp">
          <span class="mp-icon">📊</span>
          <span>결과이력</span>
        </li>
        <li class="mp-menu-item active" data-link="pw_change.jsp">
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
            <h2>🔐 비밀번호 변경</h2>
            <p>현재 비밀번호 확인 후 새 비밀번호로 변경할 수 있어요</p>
          </div>

          <form method="post" action="#" id="pwForm" class="pw-form">
            <div class="field">
              <div class="label">현재 비밀번호</div>
              <input type="password" name="current_pw" id="current_pw" placeholder="현재 비밀번호 입력">
            </div>

            <div class="field">
              <div class="label">새 비밀번호</div>
              <input type="password" name="new_pw" id="new_pw" placeholder="새 비밀번호 (8자 이상)">
            </div>

            <div class="field">
              <div class="label">새 비밀번호 확인</div>
              <input type="password" name="new_pw2" id="new_pw2" placeholder="새 비밀번호 다시 입력">
            </div>

            <div class="pw-hint">
              <p>💡 비밀번호 변경 시 유의사항</p>
              <ul>
                <li>8자 이상 입력해주세요</li>
                <li>영문, 숫자, 특수문자 조합을 권장해요</li>
                <li>이전에 사용한 비밀번호는 피해주세요</li>
              </ul>
            </div>

            <%
              String msg = (String)request.getAttribute("msg");
              if(msg != null){
            %>
              <div class="error-msg"><%=msg%></div>
            <%
              }
            %>

            <div class="mp-actions">
              <button type="submit" class="btn primary">🔒 변경하기</button>
              <a href="mypage.jsp" class="btn outline">취소</a>
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
    // 메뉴 링크 이동
    document.querySelectorAll('.mp-menu-item').forEach(item => {
      item.addEventListener('click', function() {
        const link = this.dataset.link;
        if (link) location.href = link;
      });
    });

    // 폼 검증
    document.getElementById('pwForm').onsubmit = function(e) {
      const current = document.getElementById('current_pw').value;
      const newPw = document.getElementById('new_pw').value;
      const newPw2 = document.getElementById('new_pw2').value;

      if (!current) {
        alert('현재 비밀번호를 입력하세요.');
        e.preventDefault();
        return;
      }
      if (newPw.length < 8) {
        alert('새 비밀번호는 8자 이상이어야 합니다.');
        e.preventDefault();
        return;
      }
      if (newPw !== newPw2) {
        alert('새 비밀번호가 일치하지 않습니다.');
        e.preventDefault();
        return;
      }
    };
  </script>
</body>
</html>
