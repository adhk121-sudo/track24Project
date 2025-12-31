<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link rel="stylesheet" href="css/login.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>로그인 | 결정러</title>
</head>

<body>
	
<!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp" %> 
  </header>

  <div class="grid">
    <!-- LEFT -->
<div class="left">
  <div class="character-wrap">
    <img src="images/레인저.png" alt="결정러 전대" class="ranger-image">
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

      <form id="loginForm" method="post" action="Login">
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
          <a class="btn outline" href="javascript:goPage('join')">회원가입</a>
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
<!-- footer.jsp -->
<footer class="footer">
  <%@ include file="../common/common_footer.jsp" %>
</footer>
</html>
