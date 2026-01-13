<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>회원가입 | 결정러</title>
  <link href="<%=request.getContextPath()%>/css/join.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type = "text/javascript">
	<script type="text/javascript" src="js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript">
	function goCheck() {
	    var id = joinForm.login_id.value;
	    
	    // 빈 값 체크
	    if (id == null || id.trim() == "") {
	        alert("아이디를 입력해주세요!");
	        joinForm.login_id.focus();
	        return;
	    }
	    
	    $.ajax({
	        type: "POST",
	        url: "CheckId",
	        data: "t_id=" + id,
	        dataType: "text",
	        error: function() {
	            alert('통신 실패!');
	        },
	        success: function(data) {
	            var result = $.trim(data);
	            var confirmSpan = document.getElementById("confirm_id");
	            var confirmValue = document.getElementById("confirm_id_value");
	            
	            // 클래스 초기화
	            confirmSpan.classList.remove("success", "fail");
	            
	            if (result == "사용가능한 아이디입니다.") {
	                // 사용 가능
	                confirmSpan.textContent = "✓ " + result;
	                confirmSpan.classList.add("success");
	                confirmValue.value = "Y";
	                
	            } else {
	                // 사용 불가
	                confirmSpan.textContent = "✗ " + result;
	                confirmSpan.classList.add("fail");
	                confirmValue.value = "N";
	                
	                joinForm.login_id.value = "";  // 입력칸 비우기
	                joinForm.login_id.focus();     // 포커스 이동
	            }
	        }
	    });
	}
	document.getElementById("login_id").addEventListener("input", function() {
	    var confirmSpan = document.getElementById("confirm_id");
	    var confirmValue = document.getElementById("confirm_id_value");
	    
	    // 아이디 수정하면 확인 결과 초기화
	    confirmSpan.textContent = "";
	    confirmSpan.classList.remove("success", "fail");
	    confirmValue.value = "";
	});
	
	</script>
	

</head>
<body>

  <!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp"%>
  </header>

  <!-- 스텝바 -->
  <div class="stepbar">
    <div class="step active" data-step="1">기본 정보</div>
    <div class="step" data-step="2">연락처/주소</div>
    <div class="step" data-step="3">성향</div>
    <div class="step" data-step="4">취향</div>
  </div>

  <!-- 메인 컨텐츠 -->
  <div class="grid">
    <!-- LEFT -->
    <div class="left">
      <div class="character-wrap">
        <img src="<%=request.getContextPath()%>/images/레인저.png" alt="결정러 전대" class="ranger-image">
      </div>
      <div class="bubble">
        <h3 id="bubbleTitle">처음 만나서 반갑다! 제군들!</h3>
        <p id="bubbleText">기본 정보부터 알려줘!</p>
        <div class="hint">※ 결정러 전대에 합류해서 선택장애를 물리치자!</div>
      </div>
    </div>

    <!-- RIGHT -->
    <div class="card">
      <h2>회원가입</h2>
      <p class="sub">결정러 전대원이 되어주세요!</p>

      <form name="joinForm" id="joinForm">
        <input type = "hidden" name = "t_gubun">
        <!-- STEP 1: 기본 정보 -->
        <div class="panel active" data-step="1">
       <div class="field">
    	<div class="label">아이디</div>
    		<div class="with-btn">
        	<input type="text" name="login_id" id="login_id" placeholder="아이디 입력">
       		<button type="button" class="btn gray" onclick="goCheck()">중복확인</button>
    			</div>
    			<span id="confirm_id" class="id-result"></span>
    			<input type="hidden" name="confirm_id_value" id="confirm_id_value">
			</div>
          <div class="row">
            <div class="field">
              <div class="label">비밀번호</div>
              <input type="password" name="pw" id="pw" placeholder="8자 이상">
            </div>
            <div class="field">
              <div class="label">비밀번호 확인</div>
              <input type="password" name="pw2" id="pw2" placeholder="다시 입력">
            </div>
          </div>

          <div class="row">
            <div class="field">
              <div class="label">닉네임</div>
              <input type="text" name="nickname" id="nickname" placeholder="뭐라고 부를까?">
            </div>
            <div class="field">
              <div class="label">나이</div>
              <input type="number" name="age" id="age" placeholder="예) 25" min="0" max="120">
            </div>
          </div>

          <div class="field">
            <div class="label">이메일</div>
            <div class="row">
              <input type="text" name="email_1" id="email_1" placeholder="example">
              <select name="email_2" id="email_2">
                <option value="">선택</option>
                <option value="gmail.com">gmail.com</option>
                <option value="naver.com">naver.com</option>
                <option value="kakao.com">kakao.com</option>
              </select>
            </div>
          </div>
        </div>

        <!-- STEP 2: 연락처/주소 -->
        <div class="panel" data-step="2">
          <div class="row">
            <div class="field">
              <div class="label">지역</div>
              <select name="area" id="area">
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
            <div class="field">
              <div class="label">성별</div>
              <select name="gender" id="gender">
                <option value="">선택</option>
                <option value="M">남</option>
                <option value="F">여</option>
                <option value="N">비공개</option>
              </select>
            </div>
          </div>

          <div class="field">
            <div class="label">전화번호</div>
            <div class="phone-row">
              <input type="text" name="mobile_1" id="mobile_1" maxlength="3" placeholder="010">
              <span class="dash">-</span>
              <input type="text" name="mobile_2" id="mobile_2" maxlength="4" placeholder="1234">
              <span class="dash">-</span>
              <input type="text" name="mobile_3" id="mobile_3" maxlength="4" placeholder="5678">
            </div>
          </div>
        </div>

        <!-- STEP 3: 성향 -->
        <div class="panel" data-step="3">
          <div class="field">
            <div class="label">MBTI</div>
            <input type="text" name="mbti" id="mbti" maxlength="4" placeholder="예) INFP (선택)">
          </div>

          <div class="chip-group">
            <div class="chip-title">🗣️ 말투 선택</div>
            <div class="radio-group">
              <label class="radio-option">
                <input type="radio" name="speech_style" value="존댓말">
                <span class="radio-box"></span>
                <span class="radio-label">존댓말</span>
              </label>
              <label class="radio-option">
                <input type="radio" name="speech_style" value="반말">
                <span class="radio-box"></span>
                <span class="radio-label">반말</span>
              </label>
              <label class="radio-option">
                <input type="radio" name="speech_style" value="메이드">
                <span class="radio-box"></span>
                <span class="radio-label">메이드</span>
              </label>
            </div>
          </div>
        </div>

        <!-- STEP 4: 취향 -->
        <div class="panel" data-step="4">
          
          <!-- 🍔 좋아하는 음식 -->
          <div class="chip-group">
            <div class="chip-title">🍔 좋아하는 음식</div>
            <div class="checkbox-group" data-category="food">
              <div class="checkbox-item">
                <input type="checkbox" id="food_korean" name="food" value="한식">
                <label class="checkbox-label" for="food_korean">
                  <span class="checkbox-box"></span><span>한식</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="food_japanese" name="food" value="일식">
                <label class="checkbox-label" for="food_japanese">
                  <span class="checkbox-box"></span><span>일식</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="food_chinese" name="food" value="중식">
                <label class="checkbox-label" for="food_chinese">
                  <span class="checkbox-box"></span><span>중식</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="food_western" name="food" value="양식">
                <label class="checkbox-label" for="food_western">
                  <span class="checkbox-box"></span><span>양식</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="food_snack" name="food" value="분식">
                <label class="checkbox-label" for="food_snack">
                  <span class="checkbox-box"></span><span>분식</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="food_dessert" name="food" value="디저트">
                <label class="checkbox-label" for="food_dessert">
                  <span class="checkbox-box"></span><span>디저트</span>
                </label>
              </div>
            </div>
          </div>

          <!-- 🥤 좋아하는 음료 -->
          <div class="chip-group">
            <div class="chip-title">🥤 좋아하는 음료</div>
            <div class="checkbox-group" data-category="drink">
              <div class="checkbox-item">
                <input type="checkbox" id="drink_coffee" name="drink" value="커피">
                <label class="checkbox-label" for="drink_coffee">
                  <span class="checkbox-box"></span><span>커피</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="drink_tea" name="drink" value="차">
                <label class="checkbox-label" for="drink_tea">
                  <span class="checkbox-box"></span><span>차</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="drink_juice" name="drink" value="주스">
                <label class="checkbox-label" for="drink_juice">
                  <span class="checkbox-box"></span><span>주스</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="drink_smoothie" name="drink" value="스무디">
                <label class="checkbox-label" for="drink_smoothie">
                  <span class="checkbox-box"></span><span>스무디</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="drink_soda" name="drink" value="탄산음료">
                <label class="checkbox-label" for="drink_soda">
                  <span class="checkbox-box"></span><span>탄산음료</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="drink_milk" name="drink" value="우유/라떼">
                <label class="checkbox-label" for="drink_milk">
                  <span class="checkbox-box"></span><span>우유/라떼</span>
                </label>
              </div>
            </div>
          </div>

          <!-- 🎵 좋아하는 음악 -->
          <div class="chip-group">
            <div class="chip-title">🎵 좋아하는 음악</div>
            <div class="checkbox-group" data-category="music">
              <div class="checkbox-item">
                <input type="checkbox" id="music_kpop" name="music" value="K-POP">
                <label class="checkbox-label" for="music_kpop">
                  <span class="checkbox-box"></span><span>K-POP</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_hiphop" name="music" value="힙합">
                <label class="checkbox-label" for="music_hiphop">
                  <span class="checkbox-box"></span><span>힙합</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_ballad" name="music" value="발라드">
                <label class="checkbox-label" for="music_ballad">
                  <span class="checkbox-box"></span><span>발라드</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_edm" name="music" value="EDM">
                <label class="checkbox-label" for="music_edm">
                  <span class="checkbox-box"></span><span>EDM</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_jazz" name="music" value="재즈">
                <label class="checkbox-label" for="music_jazz">
                  <span class="checkbox-box"></span><span>재즈</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_rock" name="music" value="락">
                <label class="checkbox-label" for="music_rock">
                  <span class="checkbox-box"></span><span>락</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="music_jpop" name="music" value="J-POP">
                <label class="checkbox-label" for="music_jpop">
                  <span class="checkbox-box"></span><span>J-POP</span>
                </label>
              </div>
            </div>
          </div>

          <!-- 🎬 좋아하는 영화 -->
          <div class="chip-group">
            <div class="chip-title">🎬 좋아하는 영화</div>
            <div class="checkbox-group" data-category="movie">
              <div class="checkbox-item">
                <input type="checkbox" id="movie_action" name="movie" value="액션">
                <label class="checkbox-label" for="movie_action">
                  <span class="checkbox-box"></span><span>액션</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="movie_romance" name="movie" value="로맨스">
                <label class="checkbox-label" for="movie_romance">
                  <span class="checkbox-box"></span><span>로맨스</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="movie_comedy" name="movie" value="코미디">
                <label class="checkbox-label" for="movie_comedy">
                  <span class="checkbox-box"></span><span>코미디</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="movie_sf" name="movie" value="SF">
                <label class="checkbox-label" for="movie_sf">
                  <span class="checkbox-box"></span><span>SF</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="movie_horror" name="movie" value="공포">
                <label class="checkbox-label" for="movie_horror">
                  <span class="checkbox-box"></span><span>공포</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="movie_drama" name="movie" value="드라마">
                <label class="checkbox-label" for="movie_drama">
                  <span class="checkbox-box"></span><span>드라마</span>
                </label>
              </div>
            </div>
          </div>

          <!-- 📚 좋아하는 책 -->
          <div class="chip-group">
            <div class="chip-title">📚 좋아하는 책</div>
            <div class="checkbox-group" data-category="book">
              <div class="checkbox-item">
                <input type="checkbox" id="book_novel" name="book" value="소설">
                <label class="checkbox-label" for="book_novel">
                  <span class="checkbox-box"></span><span>소설</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="book_self" name="book" value="자기계발">
                <label class="checkbox-label" for="book_self">
                  <span class="checkbox-box"></span><span>자기계발</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="book_economy" name="book" value="경제">
                <label class="checkbox-label" for="book_economy">
                  <span class="checkbox-box"></span><span>경제</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="book_human" name="book" value="인문">
                <label class="checkbox-label" for="book_human">
                  <span class="checkbox-box"></span><span>인문</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="book_comic" name="book" value="만화">
                <label class="checkbox-label" for="book_comic">
                  <span class="checkbox-box"></span><span>만화</span>
                </label>
              </div>
            </div>
          </div>

          <!-- ⚠️ 알레르기 -->
          <div class="chip-group">
            <div class="chip-title">⚠️ 알레르기</div>
            <div class="checkbox-group" data-category="allergy">
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_nut" name="allergy" value="견과류">
                <label class="checkbox-label" for="allergy_nut">
                  <span class="checkbox-box"></span><span>견과류</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_milk" name="allergy" value="우유">
                <label class="checkbox-label" for="allergy_milk">
                  <span class="checkbox-box"></span><span>우유</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_egg" name="allergy" value="계란">
                <label class="checkbox-label" for="allergy_egg">
                  <span class="checkbox-box"></span><span>계란</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_wheat" name="allergy" value="밀">
                <label class="checkbox-label" for="allergy_wheat">
                  <span class="checkbox-box"></span><span>밀</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_seafood" name="allergy" value="갑각류">
                <label class="checkbox-label" for="allergy_seafood">
                  <span class="checkbox-box"></span><span>갑각류</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_soy" name="allergy" value="대두">
                <label class="checkbox-label" for="allergy_soy">
                  <span class="checkbox-box"></span><span>대두</span>
                </label>
              </div>
              <div class="checkbox-item">
                <input type="checkbox" id="allergy_none" name="allergy" value="없음">
                <label class="checkbox-label" for="allergy_none">
                  <span class="checkbox-box"></span><span>없음</span>
                </label>
              </div>
            </div>
          </div>

        </div>

        <!-- 버튼 -->
        <div class="actions">
          <button type="button" class="btn outline" id="prevBtn">← 이전</button>
          <button type="button" class="btn primary" id="nextBtn">다음 →</button>
          <button type="button" class="btn primary" id="submitBtn" >🎉 가입 완료!</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 푸터 -->
  <footer class="footer">
    <%@ include file="../common/common_footer.jsp"%>
  </footer>

  <!-- 스크립트 -->
  <script>
    let currentStep = 1;
    const MAX_STEP = 4;

    const bubble = {
      1: { title: "처음 만나서 반갑다! 제군들!", text: "같이 기본 정보의 힘을 모으자!" },
      2: { title: "연락처/주소 입력 🏠", text: "나중에 추천도 더 정확해져!" },
      3: { title: "성향 확인 🧠", text: "MBTI나 말투를 골라줘!" },
      4: { title: "취향 선택 🎯", text: "좋아하는 걸 골라주면 추천이 좋아져!" }
    };

    // ===== 검증 함수들 =====
    function checkEmpty(element, message) {
      if (!element.value || element.value.trim() === "") {
        alert(message);
        element.focus();
        return true;
      }
      return false;
    }

    function checkSelect(element, message) {
      if (!element.value || element.value === "") {
        alert(message);
        element.focus();
        return true;
      }
      return false;
    }

    function checkMatch(pw1, pw2, message) {
      if (pw1.value !== pw2.value) {
        alert(message);
        pw2.focus();
        return true;
      }
      return false;
    }

    function checkLength(element, minLength, message) {
      if (element.value.length < minLength) {
        alert(message);
        element.focus();
        return true;
      }
      return false;
    }

    function checkRadio(name, message) {
      const checked = document.querySelector('input[name="' + name + '"]:checked');
      if (!checked) {
        alert(message);
        return true;
      }
      return false;
    }

    // ===== 스텝별 검증 =====
    function validateStep(step) {
      const f = document.joinForm;
      
      if (step === 1) {
        if (checkEmpty(f.login_id, "아이디를 입력해주세요!")) return false;
     	// 중복확인 했는지 체크
        var confirmValue = document.getElementById("confirm_id_value").value;
        if (confirmValue != "Y") {
            alert("아이디 중복확인을 해주세요!");
            return false;
        } 
        if (checkLength(f.pw, 8, "비밀번호는 8자 이상 입력해주세요!")) return false;
        if (checkEmpty(f.pw2, "비밀번호 확인을 입력해주세요!")) return false;
        if (checkMatch(f.pw, f.pw2, "비밀번호가 일치하지 않아요!")) return false;
        if (checkEmpty(f.nickname, "닉네임을 입력해주세요!")) return false;
        if (checkEmpty(f.age, "나이를 입력해주세요!")) return false;
        if (checkEmpty(f.email_1, "이메일을 입력해주세요!")) return false;
        if (checkSelect(f.email_2, "이메일 도메인을 선택해주세요!")) return false;
      }
      
      if (step === 2) {
        if (checkSelect(f.area, "지역을 선택해주세요!")) return false;
        if (checkSelect(f.gender, "성별을 선택해주세요!")) return false;
        if (checkEmpty(f.mobile_1, "전화번호를 입력해주세요!")) return false;
        if (checkEmpty(f.mobile_2, "전화번호를 입력해주세요!")) return false;
        if (checkEmpty(f.mobile_3, "전화번호를 입력해주세요!")) return false;
      }
      
      if (step === 3) {
        if (checkRadio("speech_style", "말투를 선택해주세요!")) return false;
      }
      
      return true;
    }

    // ===== 스텝 이동 =====
    function setStep(step) {
      currentStep = Math.min(Math.max(1, step), MAX_STEP);

      document.querySelectorAll(".step[data-step]").forEach(s => {
        const stepNum = Number(s.dataset.step);
        s.classList.remove("active", "done");
        if (stepNum === currentStep) s.classList.add("active");
        if (stepNum < currentStep) s.classList.add("done");
      });

      document.querySelectorAll(".panel[data-step]").forEach(p => {
        p.classList.toggle("active", Number(p.dataset.step) === currentStep);
      });

      const b = bubble[currentStep];
      document.getElementById("bubbleTitle").innerText = b.title;
      document.getElementById("bubbleText").innerText = b.text;

      document.getElementById("prevBtn").style.display = currentStep === 1 ? "none" : "flex";
      document.getElementById("nextBtn").style.display = currentStep === MAX_STEP ? "none" : "flex";
      document.getElementById("submitBtn").style.display = currentStep === MAX_STEP ? "flex" : "none";
    }

    // ===== 버튼 이벤트 =====
    document.getElementById("nextBtn").onclick = () => {
      if (validateStep(currentStep)) {
        setStep(currentStep + 1);
      }
    };

    document.getElementById("prevBtn").onclick = () => {
      setStep(currentStep - 1);
    };

    document.getElementById("submitBtn").onclick = (e) => {
      if (!validateStep(currentStep)) {
        e.preventDefault();
        return;
      }
      document.joinForm.t_gubun.value = "DBjoin"; // ⭐ 여기서 세팅
      document.joinForm.method = "post";
      document.joinForm.action = "Power";
      document.joinForm.submit();
    };

    // 스텝바 클릭 (이전 단계로만 이동 가능)
    document.querySelectorAll(".step[data-step]").forEach(s => {
      s.onclick = () => {
        const targetStep = Number(s.dataset.step);
        if (targetStep < currentStep) {
          setStep(targetStep);
        } else if (targetStep > currentStep) {
          if (validateStep(currentStep)) {
            setStep(currentStep + 1);
          }
        }
      };
    });

    // 초기화
    setStep(1);
  </script>
</body>
</html>
