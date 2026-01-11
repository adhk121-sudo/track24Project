<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.io.*,java.util.*,java.time.*,java.time.format.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
/* ===========================
   0) member 더미 (DB 연결 전 화면용)
   =========================== */
if (request.getAttribute("member") == null) {
    Map<String, Object> member = new HashMap<>();
    member.put("name", "테스트유저");
    member.put("email_1", "test");
    member.put("email_2", "gmail.com");
    request.setAttribute("member", member);
}

/* ===========================
   1) 파일에서 결과이력 읽어서 분야별 최신 3개 세팅
   - /WEB-INF/mock/result_history.tsv
   - TSV: category \t title \t mainName \t regDate(yyyy-MM-dd)
   =========================== */
if (request.getAttribute("foodList") == null && request.getAttribute("drinkList") == null
    && request.getAttribute("movieList") == null && request.getAttribute("bookList") == null
    && request.getAttribute("musicList") == null) {

    class Row {
        String category, title, mainName, regDate;
        LocalDate date;
        Row(String c, String t, String m, String d, LocalDate ld) {
            category = c;
            title = t;
            mainName = m;
            regDate = d;
            date = ld;
        }
    }

    Map<String, List<Row>> grouped = new HashMap<>();
    grouped.put("food",  new ArrayList<>());
    grouped.put("drink", new ArrayList<>());
    grouped.put("movie", new ArrayList<>());
    grouped.put("book",  new ArrayList<>());
    grouped.put("music", new ArrayList<>());

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    InputStream is = application.getResourceAsStream("/WEB-INF/mock/result_history.tsv");
    if (is != null) {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty()) continue;

                String[] p = line.split("\\t");
                if (p.length < 4) continue;

                String category = p[0].trim();
                String title    = p[1].trim();
                String mainName = p[2].trim();
                String regDate  = p[3].trim();

                if (!grouped.containsKey(category)) continue;

                LocalDate d;
                try { d = LocalDate.parse(regDate, fmt); }
                catch (Exception e) { d = LocalDate.of(1970, 1, 1); }

                grouped.get(category).add(new Row(category, title, mainName, regDate, d));
            }
        } catch (Exception e) {
            // 파일 읽기 실패해도 화면은 뜨게 둠
        }
    }

    // 날짜 내림차순 정렬 후 3개만
    for (String key : grouped.keySet()) {
        grouped.get(key).sort((a, b) -> b.date.compareTo(a.date));
        if (grouped.get(key).size() > 3) {
            grouped.put(key, new ArrayList<>(grouped.get(key).subList(0, 3)));
        }
    }

    // JSTL에서 쓰기 좋은 List<Map<String,String>> 로 변환
    java.util.function.Function<List<Row>, List<Map<String, String>>> toListMap = (rows) -> {
        List<Map<String, String>> list = new ArrayList<>();
        for (Row r : rows) {
            Map<String, String> m = new HashMap<>();
            m.put("title", r.title);
            m.put("mainName", r.mainName);
            m.put("regDate", r.regDate);
            list.add(m);
        }
        return list;
    };

    request.setAttribute("foodList",  toListMap.apply(grouped.get("food")));
    request.setAttribute("drinkList", toListMap.apply(grouped.get("drink")));
    request.setAttribute("movieList", toListMap.apply(grouped.get("movie")));
    request.setAttribute("bookList",  toListMap.apply(grouped.get("book")));
    request.setAttribute("musicList", toListMap.apply(grouped.get("music")));
}
%>

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
        <p>분야별 최근 3개씩 표시 (파일 기반)</p>
      </div>

      <div class="rh-wrap">
        <div class="rh-sections">

          <!-- 공통 템플릿: 빈카드/결과카드 모두 "js-rh-card"로 통일 -->
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

<!-- JS는 하나만 -->
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

  // ✅ 결과/빈 카드 모두 클릭 가능 (클래스 통일: js-rh-card)
  document.querySelectorAll('.js-rh-card').forEach(card=>{
    card.addEventListener('click', ()=>{
      openModal(card.dataset.title, card.dataset.result, card.dataset.date);
    });
  });

  // 닫기 이벤트
  [closeBackdrop, xBtn, okBtn].forEach(el=>{
    if(el) el.addEventListener('click', closeModal);
  });
  document.addEventListener('keydown', (e)=>{ if(e.key === 'Escape') closeModal(); });

});
</script>

</body>
</html>
