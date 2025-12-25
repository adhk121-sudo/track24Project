<%@ page pageEncoding="UTF-8"%>
<style>
/* ===== 공통 푸터 스타일 ===== */
.footer {
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(10px);
  border-top: 1px solid rgba(139, 92, 246, 0.2);
  padding: 30px 24px;
  margin-top: 50px;
}

.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 20px;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 800;
  font-size: 18px;
  color: #5b21b6;
}

.footer-logo .icon {
  font-size: 22px;
}

.footer-text {
  font-size: 13px;
  color: #6b7280;
}

.footer-links {
  display: flex;
  gap: 20px;
}

.footer-link {
  font-size: 13px;
  color: #6b7280;
  text-decoration: none;
  transition: color 0.3s;
}

.footer-link:hover {
  color: #5b21b6;
}

/* 반응형 */
@media (max-width: 600px) {
  .footer-inner {
    flex-direction: column;
    text-align: center;
  }
}
</style>




<!-- 공통 푸터 -->

  <div class="footer-inner">
    <div class="footer-logo">
      <span class="icon">⚡</span>
      <span>결정러</span>
    </div>
    
    <p class="footer-text">© 2024 결정러. 선택장애 해결 전대</p>
    
    <div class="footer-links">
      <a href="#" class="footer-link">이용약관</a>
      <a href="#" class="footer-link">개인정보처리방침</a>
      <a href="#" class="footer-link">문의하기</a>
    </div>
  </div>
</footer>