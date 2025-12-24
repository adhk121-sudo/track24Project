<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<link href="css/css.css" rel="stylesheet">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원가입 | 결정러</title>
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
        <a class="pill" href="login_powerranger.html">로그인</a>
        <a class="pill active" href="#">회원가입</a>
      </div>
    </div>
  </div>

  <div class="stepbar">
    <div class="step active" data-step="1">기본 정보</div>
    <div class="step" data-step="2">연락처/주소</div>
    <div class="step" data-step="3">성향</div>
    <div class="step" data-step="4">취향</div>
  </div>

  <div class="grid">
    <!-- LEFT -->
    <div class="left">
      <div class="character-wrap">
        <div class="mini-character red">🍜</div>
        <div class="mini-character purple">🎬</div>
        <div class="mini-character green">📚</div>
        <div class="mini-character blue">🎵</div>
      </div>
      <div class="bubble">
        <h3 id="bubbleTitle">처음 만나서 반가워! 😊</h3>
        <p id="bubbleText">기본 정보부터 알려줘!</p>
        <div class="hint">※ 결정러 전대에 합류해서 선택장애를 물리치자!</div>
      </div>
    </div>

    <!-- RIGHT -->
    <div class="card">
      <h2>회원가입</h2>
      <p class="sub">결정러 전대원이 되어주세요!</p>

      <form id="joinForm" method="post" action="#">
        <!-- STEP 1 -->
        <div class="panel active" data-step="1">
          <div class="field">
            <div class="label">아이디</div>
            <div class="with-btn">
              <input type="text" name="t_id" id="login_id" placeholder="아이디 입력">
              <button type="button" class="btn gray">중복확인</button>
            </div>
          </div>

          <div class="row">
            <div class="field">
              <div class="label">비밀번호</div>
              <input type="password" name="t_pw" id="pw" placeholder="8자 이상">
            </div>
            <div class="field">
              <div class="label">비밀번호 확인</div>
              <input type="password" name="t_pw_check" id="pw2" placeholder="다시 입력">
            </div>
          </div>

          <div class="field">
            <div class="label">닉네임</div>
            <input type="text" name="t_name" id="nickname" placeholder="뭐라고 부를까?">
          </div>

          <div class="field">
            <div class="label">나이</div>
            <input type="number" name="t_age" id="age" placeholder="예) 25" min="0" max="120">
          </div>

          <div class="field">
            <div class="label">이메일</div>
            <div class="row">
              <input type="text" name="t_email_1" id="email_1" placeholder="example">
              <select name="t_email_2" id="email_2">
                <option value="">선택</option>
                <option value="gmail.com">gmail.com</option>
                <option value="naver.com">naver.com</option>
                <option value="kakao.com">kakao.com</option>
              </select>
            </div>
          </div>
        </div>

        <!-- STEP 2 -->
        <div class="panel" data-step="2">
          <div class="field">
            <div class="label">지역</div>
            <input type="text" name="t_area" id="area" placeholder="예) 서울">
          </div>

          <div class="field">
            <div class="label">주소</div>
            <input type="text" name="t_address" id="address" placeholder="상세 주소">
          </div>

          <div class="field">
            <div class="label">전화번호</div>
            <div class="phone-row">
              <input type="text" name="t_mobile_1" id="mobile_1" maxlength="3" placeholder="010">
              <span class="dash">-</span>
              <input type="text" name="t_mobile_2" id="mobile_2" maxlength="4" placeholder="1234">
              <span class="dash">-</span>
              <input type="text" name="t_mobile_3" id="mobile_3" maxlength="4" placeholder="5678">
            </div>
          </div>

          <div class="field">
            <div class="label">성별</div>
            <select name="t_gender" id="gender">
              <option value="">선택</option>
              <option value="M">남성</option>
              <option value="F">여성</option>
              <option value="N">선택안함</option>
            </select>
          </div>
        </div>

        <!-- STEP 3 -->
       <div class="panel" data-step="3">
          <div class="field">
            <div class="label">MBTI</div>
            <input type="text" name="t_mbti" id="mbti" maxlength="4" placeholder="예) INFP (선택)">
          </div>

          <div class="chip-group">
            <div class="chip-title">🗣️ 말투 선택</div>
            <div class="radio-group">
              <label class="radio-option">
                <input type="radio" name="t_speech_style" value="formal">
                <span class="radio-box"></span>
                <span class="radio-label">존댓말</span>
              </label>
              <label class="radio-option">
                <input type="radio" name="t_speech_style" value="casual">
                <span class="radio-box"></span>
                <span class="radio-label">반말</span>
              </label>
              <label class="radio-option">
                <input type="radio" name="t_speech_style" value="mixed">
                <span class="radio-box"></span>
                <span class="radio-label">상황에 따라</span>
              </label>
            </div>
          </div>
        </div>

        <!-- STEP 4 -->
        <div class="panel" data-step="4">
          <div class="chip-group">
            <div class="chip-title">🍔 좋아하는 음식</div>
            <div class="chips" data-target="food">
              <div class="chip">한식</div><div class="chip">일식</div><div class="chip">중식</div>
              <div class="chip">양식</div><div class="chip">분식</div><div class="chip">디저트</div>
            </div>
          </div>

          <div class="chip-group">
            <div class="chip-title">🎵 좋아하는 음악</div>
            <div class="chips" data-target="music">
              <div class="chip">K-POP</div><div class="chip">힙합</div><div class="chip">발라드</div>
              <div class="chip">EDM</div><div class="chip">재즈</div><div class="chip">락</div>
            </div>
          </div>

          <div class="chip-group">
            <div class="chip-title">🎬 좋아하는 영화</div>
            <div class="chips" data-target="movie">
              <div class="chip">액션</div><div class="chip">로맨스</div><div class="chip">코미디</div>
              <div class="chip">SF</div><div class="chip">공포</div><div class="chip">드라마</div>
            </div>
          </div>

          <div class="chip-group">
            <div class="chip-title">📚 좋아하는 책</div>
            <div class="chips" data-target="book">
              <div class="chip">소설</div><div class="chip">자기계발</div><div class="chip">경제</div>
              <div class="chip">인문</div><div class="chip">만화</div>
            </div>
          </div>
        </div>

        <div class="actions">
          <button type="button" class="btn outline" id="prevBtn" style="display:none;">← 이전</button>
          <button type="button" class="btn primary" id="nextBtn">다음 →</button>
          <button type="submit" class="btn primary" id="submitBtn" style="display:none;">🎉 가입 완료!</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
let currentStep = 1;
const MAX_STEP = 4;

const bubble = {
  1: { title: "처음 만나서 반가워! 😊", text: "기본 정보부터 알려줘!" },
  2: { title: "연락처/주소 입력 🏠", text: "나중에 추천도 더 정확해져!" },
  3: { title: "성향 확인 🧠", text: "MBTI나 말투를 골라줘!" },
  4: { title: "취향 선택 🎯", text: "좋아하는 걸 골라주면 추천이 좋아져!" }
};

function setStep(step) {
  currentStep = Math.min(Math.max(1, step), MAX_STEP);

  document.querySelectorAll(".step[data-step]").forEach(s => {
    s.classList.toggle("active", Number(s.dataset.step) === currentStep);
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

document.getElementById("nextBtn").onclick = () => setStep(currentStep + 1);
document.getElementById("prevBtn").onclick = () => setStep(currentStep - 1);

// 스텝 클릭으로 이동
document.querySelectorAll(".step[data-step]").forEach(s => {
  s.onclick = () => setStep(Number(s.dataset.step));
});

// 칩 선택
document.querySelectorAll(".chips").forEach(group => {
  const isSingle = group.dataset.single === "true";
  group.querySelectorAll(".chip").forEach(chip => {
    chip.addEventListener("click", () => {
      if(isSingle) {
        group.querySelectorAll(".chip").forEach(c => c.classList.remove("selected"));
      }
      chip.classList.toggle("selected");
    });
  });
});

setStep(1);
</script>
</body>
</html>
