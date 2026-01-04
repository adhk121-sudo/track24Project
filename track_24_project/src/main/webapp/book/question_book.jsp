<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>북레인저 추천 | 결정러</title>
  <link href="<%=request.getContextPath()%>/css/question.css" rel="stylesheet">
</head>
<body class="theme-book">

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
    <form name="bookForm" id="questionForm" method="post" action="RecommandAI">
      
      <!-- hidden input으로 답변 저장 -->
      <input type="hidden" name="category" value="book"> 
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
                <img src="<%=request.getContextPath()%>/images/book_ranger.png" alt="북레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q1. 기분</div>
              <div class="question-text">오늘 기분이 어때? 😊</div>
              <div class="question-sub">기분에 따라 어울리는 책이 달라!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="curious">
                <span class="emoji">🤔</span>
                <span class="text">호기심 가득</span>
                <span class="desc">새로운 걸 알고 싶어</span>
              </div>
              <div class="option-btn" data-value="tired">
                <span class="emoji">😫</span>
                <span class="text">피곤해...</span>
                <span class="desc">가볍게 읽고 싶어</span>
              </div>
              <div class="option-btn" data-value="motivated">
                <span class="emoji">💪</span>
                <span class="text">의욕 충만!</span>
                <span class="desc">성장하고 싶어</span>
              </div>
              <div class="option-btn" data-value="emotional">
                <span class="emoji">🥹</span>
                <span class="text">감성적이야</span>
                <span class="desc">마음이 울렁거려</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">북레인저가 기분에 딱 맞는 책을 추천해줄게!</span>
          </div>
        </div>

        <!-- 질문 2: 장르 -->
        <div class="question-panel" data-step="2">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="<%=request.getContextPath()%>/images/book_ranger.png" alt="북레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q2. 장르</div>
              <div class="question-text">어떤 장르가 땡겨? 📚</div>
              <div class="question-sub">오늘 읽고 싶은 장르를 골라봐!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="novel">
                <span class="emoji">📖</span>
                <span class="text">소설</span>
                <span class="desc">이야기에 빠지고 싶어</span>
              </div>
              <div class="option-btn" data-value="self">
                <span class="emoji">🌱</span>
                <span class="text">자기계발</span>
                <span class="desc">성장하고 싶어</span>
              </div>
              <div class="option-btn" data-value="essay">
                <span class="emoji">✍️</span>
                <span class="text">에세이</span>
                <span class="desc">공감하고 싶어</span>
              </div>
              <div class="option-btn" data-value="knowledge">
                <span class="emoji">🧠</span>
                <span class="text">교양/지식</span>
                <span class="desc">똑똒해지고 싶어</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">취향에 맞는 책을 찾고 있어!</span>
          </div>
        </div>

        <!-- 질문 3: 분량 -->
        <div class="question-panel" data-step="3">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="<%=request.getContextPath()%>/images/book_ranger.png" alt="북레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q3. 분량</div>
              <div class="question-text">얼마나 읽을 수 있어? ⏱️</div>
              <div class="question-sub">시간에 맞는 책을 추천해줄게!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="short">
                <span class="emoji">📄</span>
                <span class="text">짧게</span>
                <span class="desc">1시간 이내</span>
              </div>
              <div class="option-btn" data-value="medium">
                <span class="emoji">📑</span>
                <span class="text">적당히</span>
                <span class="desc">하루 정도</span>
              </div>
              <div class="option-btn" data-value="long">
                <span class="emoji">📚</span>
                <span class="text">길어도 OK</span>
                <span class="desc">며칠 걸려도 좋아</span>
              </div>
              <div class="option-btn" data-value="any">
                <span class="emoji">🤷</span>
                <span class="text">상관없어</span>
                <span class="desc">재밌으면 됨!</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">시간에 맞는 책을 찾아볼게!</span>
          </div>
        </div>

        <!-- 질문 4: 목적 -->
        <div class="question-panel" data-step="4">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="<%=request.getContextPath()%>/images/book_ranger.png" alt="북레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q4. 목적</div>
              <div class="question-text">왜 책을 읽고 싶어? 🎯</div>
              <div class="question-sub">목적에 맞는 책을 추천해줄게!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="fun">
                <span class="emoji">🎉</span>
                <span class="text">재미</span>
                <span class="desc">즐겁게 읽고 싶어</span>
              </div>
              <div class="option-btn" data-value="learn">
                <span class="emoji">📝</span>
                <span class="text">배움</span>
                <span class="desc">새로운 걸 알고 싶어</span>
              </div>
              <div class="option-btn" data-value="comfort">
                <span class="emoji">🤗</span>
                <span class="text">위로</span>
                <span class="desc">마음이 따뜻해지고 싶어</span>
              </div>
              <div class="option-btn" data-value="inspire">
                <span class="emoji">✨</span>
                <span class="text">영감</span>
                <span class="desc">동기부여 받고 싶어</span>
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
          <button type="submit" class="btn btn-next" id="submitBtn">📚 추천받기!</button>
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
