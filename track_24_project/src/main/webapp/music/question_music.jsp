<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>뮤직레인저 추천 | 결정러</title>
  <link href="css/question.css" rel="stylesheet">
</head>
<body class="theme-music">

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
    <form name="musicForm" id="questionForm" method="post" action="MusicAI">
      
      <!-- hidden input으로 답변 저장 -->
      <input type="hidden" name="mood" id="mood_input">
      <input type="hidden" name="genre" id="genre_input">
      <input type="hidden" name="situation" id="situation_input">
      <input type="hidden" name="tempo" id="tempo_input">

      <div class="question-card">
        
        <!-- 질문 1: 기분 -->
        <div class="question-panel active" data-step="1">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/music_ranger.png" alt="뮤직레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q1. 기분</div>
              <div class="question-text">오늘 기분이 어때? 😊</div>
              <div class="question-sub">기분에 따라 어울리는 음악이 달라!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="happy">
                <span class="emoji">😄</span>
                <span class="text">기분 좋아!</span>
                <span class="desc">신나는 음악 듣고 싶어</span>
              </div>
              <div class="option-btn" data-value="tired">
                <span class="emoji">😫</span>
                <span class="text">피곤해...</span>
                <span class="desc">편안한 음악으로 힐링</span>
              </div>
              <div class="option-btn" data-value="energetic">
                <span class="emoji">🔥</span>
                <span class="text">에너지 충만!</span>
                <span class="desc">텐션 올릴 음악</span>
              </div>
              <div class="option-btn" data-value="sad">
                <span class="emoji">😢</span>
                <span class="text">우울해...</span>
                <span class="desc">감성적인 음악</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">뮤직레인저가 기분에 딱 맞는 음악을 추천해줄게!</span>
          </div>
        </div>

        <!-- 질문 2: 장르 -->
        <div class="question-panel" data-step="2">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/music_ranger.png" alt="뮤직레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q2. 장르</div>
              <div class="question-text">어떤 장르가 땡겨? 🎵</div>
              <div class="question-sub">오늘 듣고 싶은 장르를 골라봐!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="kpop">
                <span class="emoji">🇰🇷</span>
                <span class="text">K-POP</span>
                <span class="desc">한국 가요</span>
              </div>
              <div class="option-btn" data-value="pop">
                <span class="emoji">🌍</span>
                <span class="text">POP</span>
                <span class="desc">해외 팝송</span>
              </div>
              <div class="option-btn" data-value="hiphop">
                <span class="emoji">🎤</span>
                <span class="text">힙합/R&B</span>
                <span class="desc">리듬 타기</span>
              </div>
              <div class="option-btn" data-value="indie">
                <span class="emoji">🎸</span>
                <span class="text">인디/락</span>
                <span class="desc">감성 충전</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">취향에 맞는 음악을 찾고 있어!</span>
          </div>
        </div>

        <!-- 질문 3: 상황 -->
        <div class="question-panel" data-step="3">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/music_ranger.png" alt="뮤직레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q3. 상황</div>
              <div class="question-text">언제 들을 거야? 🎧</div>
              <div class="question-sub">상황에 맞는 음악을 추천해줄게!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="work">
                <span class="emoji">💻</span>
                <span class="text">작업/공부</span>
                <span class="desc">집중할 때</span>
              </div>
              <div class="option-btn" data-value="commute">
                <span class="emoji">🚇</span>
                <span class="text">출퇴근</span>
                <span class="desc">이동할 때</span>
              </div>
              <div class="option-btn" data-value="exercise">
                <span class="emoji">🏃</span>
                <span class="text">운동</span>
                <span class="desc">몸 움직일 때</span>
              </div>
              <div class="option-btn" data-value="relax">
                <span class="emoji">🛋️</span>
                <span class="text">휴식</span>
                <span class="desc">쉴 때</span>
              </div>
            </div>
          </div>

          <div class="tip-bubble">
            <span class="icon">💡</span>
            <span class="text">상황에 맞는 플레이리스트를 찾아볼게!</span>
          </div>
        </div>

        <!-- 질문 4: 템포 -->
        <div class="question-panel" data-step="4">
          <div class="question-header">
            <div class="character-area">
              <div class="character-icon">
                <img src="images/music_ranger.png" alt="뮤직레인저">
              </div>
            </div>
            <div class="question-area">
              <div class="question-label">Q4. 템포</div>
              <div class="question-text">어떤 빠르기가 좋아? 🎶</div>
              <div class="question-sub">원하는 템포를 선택해!</div>
            </div>
          </div>

          <div class="options-area">
            <div class="options-grid">
              <div class="option-btn" data-value="fast">
                <span class="emoji">⚡</span>
                <span class="text">빠르게</span>
                <span class="desc">텐션 업!</span>
              </div>
              <div class="option-btn" data-value="medium">
                <span class="emoji">🎵</span>
                <span class="text">적당히</span>
                <span class="desc">리듬 타기 좋은</span>
              </div>
              <div class="option-btn" data-value="slow">
                <span class="emoji">🌙</span>
                <span class="text">느리게</span>
                <span class="desc">감성적으로</span>
              </div>
              <div class="option-btn" data-value="any">
                <span class="emoji">🎲</span>
                <span class="text">상관없어</span>
                <span class="desc">좋으면 됨!</span>
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
          <button type="submit" class="btn btn-next" id="submitBtn">🎵 추천받기!</button>
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
    const inputIds = ['', 'mood_input', 'genre_input', 'situation_input', 'tempo_input'];

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
