<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <base href="<%=request.getContextPath()%>/">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>결과이력 | 결정러</title>

  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage_result.css">
</head>

<body>
<header class="header">
  <%@ include file="../common/common_header.jsp"%>
</header>

<div class="mypage-container">

  <!-- 왼쪽 사이드 -->
  <aside class="mp-sidebar">
    <div class="mp-profile">
      <div class="mp-avatar">😊</div>
      <div class="mp-name">${member.name}님</div>
      <div class="mp-email">${member.email_1}@${member.email_2}</div>
    </div>

    <ul class="mp-menu">
      <li class="mp-menu-item"
          onclick="location.href='<%=request.getContextPath()%>/mypage?t_gubun=view'">
        <span class="mp-icon">👤</span><span>상세정보</span>
      </li>
      <li class="mp-menu-item"
          onclick="location.href='<%=request.getContextPath()%>/mypage?t_gubun=view#taste'">
        <span class="mp-icon">🎯</span><span>취향선택</span>
      </li>
      <li class="mp-menu-item active"
          onclick="location.href='<%=request.getContextPath()%>/mypage?t_gubun=history'">
        <span class="mp-icon">📊</span><span>결과이력</span>
      </li>
      <li class="mp-menu-item"
          onclick="location.href='<%=request.getContextPath()%>/mypage?t_gubun=view#pw'">
        <span class="mp-icon">🔐</span><span>비밀번호 변경</span>
      </li>
    </ul>

    <div class="mp-logout">
      <a href="<%=request.getContextPath()%>/Logout" class="btn-logout">로그아웃</a>
    </div>
  </aside>

  <!-- 오른쪽 컨텐츠 -->
  <main class="mp-main">
    <div class="mp-card">
      <div class="mp-card-header">
        <h2>📊 결과이력</h2>
        <p>분야별 최근 3개씩 표시</p>

        <!-- 디버그용(필요 없으면 삭제) -->
        <%-- <p style="font-size:12px;opacity:.7;">foodList size = ${empty foodList ? 0 : foodList.size()}</p> --%>
      </div>

      <div class="rh-wrap">
        <div class="rh-sections">

          <!-- 음식 -->
          <section class="rh-section">
            <div class="rh-sec-head">
              <h3>🍜 음식 <span class="rh-mini">최근 3개</span></h3>
              <p>클릭하면 상세 보기</p>
            </div>

            <div class="rh-grid">
              <c:choose>
                <c:when test="${empty foodList}">
                  <article class="rh-card js-rh-card rh-empty"
                           data-title="아직 기록이 없어요"
                           data-result="맛레인저로 추천을 먼저 받아보세요"
                           data-date="-">
                    <div class="rh-ico food">🍜</div>
                    <div class="rh-body">
                      <p class="rh-title">아직 기록이 없어요</p>
                      <p class="rh-result">맛레인저로 추천을 받아보세요</p>
                      <p class="rh-date">-</p>
                      <span class="rh-badge">눌러서 안내 보기</span>
                    </div>
                  </article>
                </c:when>

                <c:otherwise>
                  <c:forEach var="h" items="${foodList}">
                    <article class="rh-card js-rh-card"
                             data-title="${h.title}"
                             data-result="${h.mainName}"
                             data-date="${h.regDate}">
                      <div class="rh-ico food">🍜</div>
                      <div class="rh-body">
                        <p class="rh-title">${h.title}</p>
                        <p class="rh-result">결과: <b>${h.mainName}</b></p>
                        <p class="rh-date">${h.regDate}</p>
                      </div>
                    </article>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>

          <!-- 음료 -->
          <section class="rh-section">
            <div class="rh-sec-head">
              <h3>🥤 음료 <span class="rh-mini">최근 3개</span></h3>
              <p>클릭하면 상세 보기</p>
            </div>

            <div class="rh-grid">
              <c:choose>
                <c:when test="${empty drinkList}">
                  <article class="rh-card js-rh-card rh-empty"
                           data-title="아직 기록이 없어요"
                           data-result="드링크레인저로 추천을 먼저 받아보세요"
                           data-date="-">
                    <div class="rh-ico drink">🥤</div>
                    <div class="rh-body">
                      <p class="rh-title">아직 기록이 없어요</p>
                      <p class="rh-result">드링크레인저로 추천을 받아보세요</p>
                      <p class="rh-date">-</p>
                      <span class="rh-badge">눌러서 안내 보기</span>
                    </div>
                  </article>
                </c:when>

                <c:otherwise>
                  <c:forEach var="h" items="${drinkList}">
                    <article class="rh-card js-rh-card"
                             data-title="${h.title}"
                             data-result="${h.mainName}"
                             data-date="${h.regDate}">
                      <div class="rh-ico drink">🥤</div>
                      <div class="rh-body">
                        <p class="rh-title">${h.title}</p>
                        <p class="rh-result">결과: <b>${h.mainName}</b></p>
                        <p class="rh-date">${h.regDate}</p>
                      </div>
                    </article>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>

          <!-- 영화 -->
          <section class="rh-section">
            <div class="rh-sec-head">
              <h3>🎬 영화 <span class="rh-mini">최근 3개</span></h3>
              <p>클릭하면 상세 보기</p>
            </div>

            <div class="rh-grid">
              <c:choose>
                <c:when test="${empty movieList}">
                  <article class="rh-card js-rh-card rh-empty"
                           data-title="아직 기록이 없어요"
                           data-result="무비레인저로 추천을 먼저 받아보세요"
                           data-date="-">
                    <div class="rh-ico movie">🎬</div>
                    <div class="rh-body">
                      <p class="rh-title">아직 기록이 없어요</p>
                      <p class="rh-result">무비레인저로 추천을 받아보세요</p>
                      <p class="rh-date">-</p>
                      <span class="rh-badge">눌러서 안내 보기</span>
                    </div>
                  </article>
                </c:when>

                <c:otherwise>
                  <c:forEach var="h" items="${movieList}">
                    <article class="rh-card js-rh-card"
                             data-title="${h.title}"
                             data-result="${h.mainName}"
                             data-date="${h.regDate}">
                      <div class="rh-ico movie">🎬</div>
                      <div class="rh-body">
                        <p class="rh-title">${h.title}</p>
                        <p class="rh-result">결과: <b>${h.mainName}</b></p>
                        <p class="rh-date">${h.regDate}</p>
                      </div>
                    </article>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>

          <!-- 책 -->
          <section class="rh-section">
            <div class="rh-sec-head">
              <h3>📚 책 <span class="rh-mini">최근 3개</span></h3>
              <p>클릭하면 상세 보기</p>
            </div>

            <div class="rh-grid">
              <c:choose>
                <c:when test="${empty bookList}">
                  <article class="rh-card js-rh-card rh-empty"
                           data-title="아직 기록이 없어요"
                           data-result="북레인저로 추천을 먼저 받아보세요"
                           data-date="-">
                    <div class="rh-ico book">📚</div>
                    <div class="rh-body">
                      <p class="rh-title">아직 기록이 없어요</p>
                      <p class="rh-result">북레인저로 추천을 받아보세요</p>
                      <p class="rh-date">-</p>
                      <span class="rh-badge">눌러서 안내 보기</span>
                    </div>
                  </article>
                </c:when>

                <c:otherwise>
                  <c:forEach var="h" items="${bookList}">
                    <article class="rh-card js-rh-card"
                             data-title="${h.title}"
                             data-result="${h.mainName}"
                             data-date="${h.regDate}">
                      <div class="rh-ico book">📚</div>
                      <div class="rh-body">
                        <p class="rh-title">${h.title}</p>
                        <p class="rh-result">결과: <b>${h.mainName}</b></p>
                        <p class="rh-date">${h.regDate}</p>
                      </div>
                    </article>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>

          <!-- 음악 -->
          <section class="rh-section">
            <div class="rh-sec-head">
              <h3>🎵 음악 <span class="rh-mini">최근 3개</span></h3>
              <p>클릭하면 상세 보기</p>
            </div>

            <div class="rh-grid">
              <c:choose>
                <c:when test="${empty musicList}">
                  <article class="rh-card js-rh-card rh-empty"
                           data-title="아직 기록이 없어요"
                           data-result="뮤직레인저로 추천을 먼저 받아보세요"
                           data-date="-">
                    <div class="rh-ico music">🎵</div>
                    <div class="rh-body">
                      <p class="rh-title">아직 기록이 없어요</p>
                      <p class="rh-result">뮤직레인저로 추천을 받아보세요</p>
                      <p class="rh-date">-</p>
                      <span class="rh-badge">눌러서 안내 보기</span>
                    </div>
                  </article>
                </c:when>

                <c:otherwise>
                  <c:forEach var="h" items="${musicList}">
                    <article class="rh-card js-rh-card"
                             data-title="${h.title}"
                             data-result="${h.mainName}"
                             data-date="${h.regDate}">
                      <div class="rh-ico music">🎵</div>
                      <div class="rh-body">
                        <p class="rh-title">${h.title}</p>
                        <p class="rh-result">결과: <b>${h.mainName}</b></p>
                        <p class="rh-date">${h.regDate}</p>
                      </div>
                    </article>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </div>
          </section>

        </div>
      </div>
    </div>
  </main>
</div>

<!-- 상세 모달 -->
<div class="rh-modal" id="rhModal" aria-hidden="true">
  <div class="rh-modal-backdrop" id="rhModalClose"></div>
  <div class="rh-modal-card" role="dialog" aria-modal="true">
    <div class="rh-modal-head">
      <h3 id="rhModalTitle">상세</h3>
      <button type="button" class="rh-modal-x" id="rhModalX">✕</button>
    </div>
    <div class="rh-modal-body">
      <p class="rh-modal-line"><b>결과:</b> <span id="rhModalResult"></span></p>
      <p class="rh-modal-line"><b>날짜:</b> <span id="rhModalDate"></span></p>
    </div>
    <div class="rh-modal-foot">
      <button type="button" class="btn primary" id="rhModalOk">확인</button>
    </div>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  const modal = document.getElementById('rhModal');
  const closeBackdrop = document.getElementById('rhModalClose');
  const xBtn = document.getElementById('rhModalX');
  const okBtn = document.getElementById('rhModalOk');

  const titleEl = document.getElementById('rhModalTitle');
  const resultEl = document.getElementById('rhModalResult');
  const dateEl = document.getElementById('rhModalDate');

  function openModal(title, result, date){
    titleEl.textContent = title || '상세';
    resultEl.textContent = result || '-';
    dateEl.textContent = date || '-';
    modal.classList.add('show');
    modal.setAttribute('aria-hidden','false');
  }

  function closeModal(){
    modal.classList.remove('show');
    modal.setAttribute('aria-hidden','true');
  }

  document.querySelectorAll('.js-rh-card').forEach(card => {
    card.addEventListener('click', () => {
      openModal(card.dataset.title, card.dataset.result, card.dataset.date);
    });
  });

  [closeBackdrop, xBtn, okBtn].forEach(el => {
    if(el) el.addEventListener('click', closeModal);
  });

  document.addEventListener('keydown', (e) => {
    if(e.key === 'Escape') closeModal();
  });
});
</script>

</body>
</html>
