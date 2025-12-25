<%@ page pageEncoding="UTF-8"%>
<style>
:root {
  --header-h: 70px;
  --bg: linear-gradient(180deg, #e0e7ff 0%, #c7d2fe 30%, #ddd6fe 60%, #ede9fe 100%);
  --text: #1e1b4b;
  --muted: #6b7280;
  --line: rgba(139, 92, 246, 0.2);
  --red: #f97316;
  --purple: #a855f7;
  --green: #22c55e;
  --blue: #3b82f6;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

html, body {
  min-height: 100vh;
  background: var(--bg);
  color: var(--text);
  font-family: 'Segoe UI', Pretendard, -apple-system, sans-serif;
  font-size: 16px;
  overflow-x: hidden;
}

/* 배경 효과 */
body::before {
  content: '';
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: 
    radial-gradient(ellipse at 20% 20%, rgba(249, 115, 22, 0.12) 0%, transparent 50%),
    radial-gradient(ellipse at 80% 30%, rgba(168, 85, 247, 0.12) 0%, transparent 50%),
    radial-gradient(ellipse at 40% 80%, rgba(34, 197, 94, 0.08) 0%, transparent 50%),
    radial-gradient(ellipse at 70% 70%, rgba(59, 130, 246, 0.08) 0%, transparent 50%);
  pointer-events: none;
  z-index: 0;
}

/* ===== 공통 헤더 ===== */
.header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: var(--header-h);
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--line);
  z-index: 1000;
}

.header-inner {
  max-width: 1200px;
  height: 100%;
  margin: 0 auto;
  padding: 0 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

/* 로고 */
.header-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  text-decoration: none;
  font-weight: 900;
  font-size: 22px;
  background: linear-gradient(135deg, var(--red), #eab308, var(--green), var(--blue), var(--purple));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.header-logo .icon {
  font-size: 28px;
  -webkit-text-fill-color: initial;
}

/* 네비게이션 메뉴 */
.header-nav {
  display: flex;
  align-items: center;
  gap: 8px;
}

.nav-link {
  padding: 10px 18px;
  border-radius: 999px;
  font-size: 14px;
  font-weight: 700;
  text-decoration: none;
  color: var(--muted);
  border: 1px solid transparent;
  transition: all 0.3s;
}

.nav-link:hover {
  color: var(--text);
  background: rgba(139, 92, 246, 0.08);
}

.nav-link.active {
  color: #5b21b6;
  background: rgba(139, 92, 246, 0.1);
  border-color: rgba(139, 92, 246, 0.2);
}

/* 버튼 스타일 */
.header-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.btn-outline {
  padding: 10px 20px;
  border-radius: 999px;
  font-size: 14px;
  font-weight: 700;
  text-decoration: none;
  color: #5b21b6;
  border: 1px solid rgba(139, 92, 246, 0.3);
  background: rgba(255, 255, 255, 0.8);
  transition: all 0.3s;
  cursor: pointer;
}

.btn-outline:hover {
  background: rgba(139, 92, 246, 0.1);
  border-color: rgba(139, 92, 246, 0.5);
}

.btn-primary {
  padding: 10px 22px;
  border-radius: 999px;
  font-size: 14px;
  font-weight: 700;
  text-decoration: none;
  color: #fff;
  border: none;
  background: linear-gradient(135deg, #7c3aed, #a855f7);
  box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
  transition: all 0.3s;
  cursor: pointer;
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(139, 92, 246, 0.4);
}

/* 로그인 상태일 때 프로필 */
.header-profile {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 6px 16px 6px 8px;
  border-radius: 999px;
  background: rgba(139, 92, 246, 0.1);
  border: 1px solid rgba(139, 92, 246, 0.2);
  cursor: pointer;
  transition: all 0.3s;
}

.header-profile:hover {
  background: rgba(139, 92, 246, 0.15);
}

.profile-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  background: linear-gradient(135deg, #7c3aed, #a855f7);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
}

.profile-name {
  font-size: 14px;
  font-weight: 700;
  color: #5b21b6;
}

/* 컨텐츠 영역 (헤더 높이만큼 패딩) */
.main-content {
  padding-top: var(--header-h);
  position: relative;
  z-index: 1;
}

/* ===== 반응형 ===== */
@media (max-width: 768px) {
  .header-nav {
    display: none;
  }
  
  .header-logo {
    font-size: 18px;
  }
  
  .header-logo .icon {
    font-size: 24px;
  }
  
  .btn-outline, .btn-primary {
    padding: 8px 16px;
    font-size: 13px;
  }
}
</style>
<!-- 공통 헤더 -->
  
    <div class="header-inner">
      <a href="main_powerranger.jsp" class="header-logo">
        <span class="icon">⚡</span>
        <span>결정러</span>
      </a>

      <nav class="header-nav">
        <a href="../main_powerranger.jsp" class="nav-link active">홈</a>
        <a href="food/question_food.jsp" class="nav-link">음식</a>
        <a href="question_movie.html" class="nav-link">영화</a>
        <a href="question_book.html" class="nav-link">책</a>
        <a href="question_music.html" class="nav-link">음악</a>
      </nav>

      <div class="header-actions">
        <a href="login/login_powerranger.jsp" class="btn-outline">로그인</a>
        <a href="join/join_powerranger.jsp" class="btn-primary">회원가입</a>
      </div>
    </div>
  </header>