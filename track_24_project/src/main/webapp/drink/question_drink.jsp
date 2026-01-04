<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>드링크레인저 추천 | 결정러</title>
  <link href="css/question.css" rel="stylesheet">
</head>
<body class="theme-drink">

  <!-- 공통 헤더 -->
  <header class="header">
    <%@ include file="../common/common_header.jsp" %> 
  </header>

  <div class="main-wrap">
    <!-- 진행 바 -->
    <div class="progress-bar">
      <div class="progress-dot active" data-step="1"></div>
      <div class="progress-dot" data-step="2"></div>
      <div class="progress-dot" data-step="3"></div>
      <div class="progress-dot" data-step="4"></div>
    </div>

    <!-- 폼 시작 -->
    <form name="drinkForm" id="questionForm" method="post" action="RecommandAI">
      
      <!-- hidden input으로 답변 저장 -->
        <input type="hidden" name="category" value="drink">  <!-- 카테고리만 다르게 -->
  		<input type="hidden" name="q1" id="q1_input">
  		<input type="hidden" name="q2" id="q2_input">
  		<input type="hidden" name="q3" id="q3_input">
  		<input type="hidden" name="q4" id="q4_input">

      <div class="question-card">
        
        <!-- 질문 1: 기분 -->
        <div class="question-panel active" data-step="1">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/drink_ranger.png" alt="드링크레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q1. 기분</div>
              <div class="question-text">오늘 기분이 어때? 😊</div>
              <div class="question-sub">기분에 따라 어울리는 음료가 달라!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="happy">
                <span class="emoji">😄</span>
                <span class="text">기분 좋아!</span>
                <span class="desc">상쾌한 거 마시고 싶어</span>
              </div>
              <div class="option-btn" data-value="tired">
                <span class="emoji">😫</span>
                <span class="text">피곤해...</span>
                <span class="desc">카페인 충전!</span>
              </div>
              <div class="option-btn" data-value="stressed">
                <span class="emoji">😤</span>
                <span class="text">스트레스 받아</span>
                <span class="desc">달달한 게 필요해</span>
              </div>
              <div class="option-btn" data-value="chill">
                <span class="emoji">😌</span>
                <span class="text">여유로워</span>
                <span class="desc">천천히 즐기고 싶어</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">드링크레인저가 딱 맞는 음료를 추천해줄게!</span>
          </div>
        </div>

        <!-- 질문 2: 온도 -->
        <div class="question-panel" data-step="2">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/drink_ranger.png" alt="드링크레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q2. 온도</div>
              <div class="question-text">차가운 거? 따뜻한 거? 🧊</div>
              <div class="question-sub">원하는 온도를 골라봐!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="ice">
                <span class="emoji">🧊</span>
                <span class="text">아이스</span>
                <span class="desc">시원하게!</span>
              </div>
              <div class="option-btn" data-value="hot">
                <span class="emoji">♨️</span>
                <span class="text">따뜻하게</span>
                <span class="desc">포근하게~</span>
              </div>
              <div class="option-btn" data-value="room">
                <span class="emoji">🥤</span>
                <span class="text">상온</span>
                <span class="desc">적당하게</span>
              </div>
              <div class="option-btn" data-value="any">
                <span class="emoji">🤷</span>
                <span class="text">상관없어</span>
                <span class="desc">아무거나!</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">날씨에 따라 추천이 달라질 수 있어!</span>
          </div>
        </div>

        <!-- 질문 3: 음료 종류 -->
        <div class="question-panel" data-step="3">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/drink_ranger.png" alt="드링크레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q3. 종류</div>
              <div class="question-text">어떤 종류가 땡겨? ☕</div>
              <div class="question-sub">오늘 마시고 싶은 종류를 골라봐!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="coffee">
                <span class="emoji">☕</span>
                <span class="text">커피</span>
                <span class="desc">에스프레소 베이스</span>
              </div>
              <div class="option-btn" data-value="tea">
                <span class="emoji">🍵</span>
                <span class="text">차</span>
                <span class="desc">녹차/홍차/허브티</span>
              </div>
              <div class="option-btn" data-value="juice">
                <span class="emoji">🧃</span>
                <span class="text">주스/에이드</span>
                <span class="desc">과일 베이스</span>
              </div>
              <div class="option-btn" data-value="smoothie">
                <span class="emoji">🥤</span>
                <span class="text">스무디/쉐이크</span>
                <span class="desc">블렌딩 음료</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">취향에 맞는 음료를 찾고 있어!</span>
          </div>
        </div>

        <!-- 질문 4: 당도 -->
        <div class="question-panel" data-step="4">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/drink_ranger.png" alt="드링크레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q4. 당도</div>
              <div class="question-text">단 거 좋아해? 🍬</div>
              <div class="question-sub">원하는 당도를 선택해!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="sweet">
                <span class="emoji">🍭</span>
                <span class="text">달달하게</span>
                <span class="desc">당 충전!</span>
              </div>
              <div class="option-btn" data-value="half">
                <span class="emoji">🍬</span>
                <span class="text">적당히</span>
                <span class="desc">반반으로</span>
              </div>
              <div class="option-btn" data-value="less">
                <span class="emoji">🌿</span>
                <span class="text">덜 달게</span>
                <span class="desc">건강하게</span>
              </div>
              <div class="option-btn" data-value="none">
                <span class="emoji">💧</span>
                <span class="text">무가당</span>
                <span class="desc">깔끔하게</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">🔥</span>
            <span class="text">마지막 질문이야! 이제 추천해줄게!</span>
          </div>
        </div>

        <!-- 버튼 영역 -->
        <div class="action-area">
          <button type="button" class="btn btn-prev" id="prevBtn">← 이전</button>
          <button type="button" class="btn btn-next" id="nextBtn" disabled>다음 →</button>
          <button type="submit" class="btn btn-next" id="submitBtn">🥤 추천받기!</button>
        </div>
        
      </div>
    </form>
    <!-- 폼 끝 -->
    
  </div>

  <!-- 푸터 -->
  <footer class="footer">
    <%@ include file="../common/common_footer.jsp" %>
  </footer>

  <script>
    let currentStep = 1;
    const MAX_STEP = 4;
    const answers = {};
    
    // 각 스텝별 hidden input id
    const inputIds = ['', 'q1_input', 'q2_input', 'q3_input', 'q4_input'];

    function updateUI() {
      // 진행 바 업데이트
      document.querySelectorAll('.progress-dot').forEach(dot => {
        const step = Number(dot.dataset.step);
        dot.classList.remove('active', 'done');
        if (step === currentStep) dot.classList.add('active');
        if (step < currentStep) dot.classList.add('done');
      });

      // 패널 전환
      document.querySelectorAll('.question-panel').forEach(panel => {
        panel.classList.toggle('active', Number(panel.dataset.step) === currentStep);
      });

      // 버튼 표시
      document.getElementById('prevBtn').style.display = currentStep === 1 ? 'none' : 'flex';
      document.getElementById('nextBtn').style.display = currentStep === MAX_STEP ? 'none' : 'flex';
      document.getElementById('submitBtn').style.display = currentStep === MAX_STEP ? 'flex' : 'none';

      // 현재 스텝에 선택된 값이 있으면 버튼 활성화
      checkSelection();
    }

    function checkSelection() {
      const currentPanel = document.querySelector('.question-panel[data-step="' + currentStep + '"]');
      const hasSelection = currentPanel.querySelector('.option-btn.selected');
      
      if (currentStep === MAX_STEP) {
        document.getElementById('submitBtn').disabled = !hasSelection;
      } else {
        document.getElementById('nextBtn').disabled = !hasSelection;
      }
    }

    function selectOption(btn, step) {
      // 같은 패널의 다른 선택 해제
      btn.closest('.options-grid').querySelectorAll('.option-btn').forEach(b => b.classList.remove('selected'));
      btn.classList.add('selected');
      
      // 답변 저장
      answers[step] = btn.dataset.value;
      
      // hidden input에 값 저장
      document.getElementById(inputIds[step]).value = btn.dataset.value;
      
      // 버튼 활성화
      checkSelection();
    }

    document.addEventListener('DOMContentLoaded', () => {
      updateUI();

      // 옵션 클릭
      document.querySelectorAll('.option-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          const panel = btn.closest('.question-panel');
          const step = Number(panel.dataset.step);
          selectOption(btn, step);
        });
      });

      // 이전 버튼
      document.getElementById('prevBtn').addEventListener('click', () => {
        if (currentStep > 1) {
          currentStep--;
          updateUI();
        }
      });

      // 다음 버튼
      document.getElementById('nextBtn').addEventListener('click', () => {
        if (currentStep < MAX_STEP) {
          currentStep++;
          updateUI();
        }
      });

      // 진행 바 클릭 (이전 단계로만 이동 가능)
      document.querySelectorAll('.progress-dot').forEach(dot => {
        dot.addEventListener('click', () => {
          const step = Number(dot.dataset.step);
          if (step < currentStep) {
            currentStep = step;
            updateUI();
          }
        });
      });

      // 폼 제출 전 검증
      document.getElementById('questionForm').addEventListener('submit', (e) => {
        // 모든 답변이 있는지 확인
        for (let i = 1; i <= MAX_STEP; i++) {
          if (!answers[i]) {
            alert('모든 질문에 답해주세요!');
            e.preventDefault();
            return;
          }
        }
      });
    });
  </script>
</body>
</html>
