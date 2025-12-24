<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<link href="css/css.css" rel="stylesheet">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>로그인 | 결정러</title>
</head>

<body>
<div class="wrap">
  <div class="topbar">
    <div class="topbar-inner">
      <div class="brand">
        <div class="logo">⚡</div>
        <div>결정러</div>
      </div>
      <div class="top-actions">
        <a class="pill active" href="login_powerranger.html">로그인</a>
        <a class="pill" href="join_powerranger.html">회원가입</a>
      </div>
    </div>
  </div>

  <div class="grid">
    <div class="left">
      <div class="character-wrap">
        <div class="ranger-team">
          <div class="ranger red">
            <div class="ranger-icon">🍜</div>
            <div class="ranger-name">맛레인저</div>
          </div>
          <div class="ranger purple">
            <div class="ranger-icon">🎬</div>
            <div class="ranger-name">무비레인저</div>
          </div>
          <div class="ranger green">
            <div class="ranger-icon">📚</div>
            <div class="ranger-name">북레인저</div>
          </div>
          <div class="ranger blue">
            <div class="ranger-icon">🎵</div>
            <div class="ranger-name">뮤직레인저</div>
          </div>
        </div>
      </div>
      <div class="bubble">
        <h3>다시 만나서 반가워! 😊</h3>
        <p>아이디/비밀번호로 로그인해줘!</p>
        <div class="hint">※ 로그인하면 전대원들이 추천해줄게!</div>
      </div>
    </div>

    <div class="card">
      <h2>로그인</h2>
      <p class="sub">결정러 전대에 합류하세요!</p>

      <form id="loginForm" method="post" action="#">
        <div class="field">
          <div class="label">아이디</div>
          <input type="text" name="login_id" id="login_id" placeholder="아이디 입력">
        </div>

        <div class="field">
          <div class="label">비밀번호</div>
          <input type="password" name="pw" id="pw" placeholder="비밀번호 입력">
        </div>

        <div class="actions">
          <button type="submit" class="btn primary">🔥 출동하기!</button>
          <a class="btn outline" href="join_powerranger.html">회원가입</a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
document.getElementById("loginForm").addEventListener("submit", (e) => {
  const id = document.getElementById("login_id").value.trim();
  const pw = document.getElementById("pw").value.trim();
  if(!id || !pw) {
    alert("아이디와 비밀번호를 입력하세요.");
    e.preventDefault();
  }
});
</script>
</body>
</html>