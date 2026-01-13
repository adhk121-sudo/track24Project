<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.io.*,java.util.*,java.time.*,java.time.format.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  // ============================================
  // 결과이력 샘플 데이터 (TSV/DB 없이 화면 확인용)
  // ============================================
  if (request.getAttribute("foodList") == null) {

    class Row {
      String category, title, mainName, regDate;
      LocalDate date;
      Row(String c, String t, String m, String d, LocalDate ld){
        category=c; title=t; mainName=m; regDate=d; date=ld;
      }
    }

    Map<String, List<Row>> grouped = new HashMap<>();
    grouped.put("food", new ArrayList<>());
    grouped.put("drink", new ArrayList<>());
    grouped.put("movie", new ArrayList<>());
    grouped.put("book", new ArrayList<>());
    grouped.put("music", new ArrayList<>());

    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // 샘플 라인: category \t title \t result(mainName) \t date(yyyy-MM-dd)
    String[] sampleLines = {
      "food\t오늘 뭐 먹지?\t치킨\t2026-01-11",
      "food\t혼밥 추천\t김치찌개\t2026-01-10",
      "food\t야식 추천\t떡볶이\t2026-01-09",
      "food\t가벼운 한끼\t샐러드\t2026-01-08",

      "drink\t오늘 뭐 마실까?\t아이스 아메리카노\t2026-01-11",
      "drink\t카페 메뉴 추천\t카페라떼\t2026-01-10",
      "drink\t디저트랑 어울리는 음료\t바닐라라떼\t2026-01-09",
      "drink\t상큼한 음료\t레몬에이드\t2026-01-08",

      "movie\t오늘 영화 추천\t인셉션\t2026-01-11",
      "movie\t가볍게 보기 좋은 영화\t라라랜드\t2026-01-10",
      "movie\t액션 추천\t존 윅\t2026-01-09",
      "movie\t드라마 추천\t쇼생크 탈출\t2026-01-08",

      "book\t책 추천\t데미안\t2026-01-11",
      "book\t자기계발 추천\t아주 작은 습관의 힘\t2026-01-10",
      "book\t소설 추천\t82년생 김지영\t2026-01-09",
      "book\t인문 추천\t사피엔스\t2026-01-08",

      "music\t오늘 노래 추천\tDitto\t2026-01-11",
      "music\t출근길 추천\tDynamite\t2026-01-10",
      "music\t집중할 때\tLofi HipHop\t2026-01-09",
      "music\t감성 발라드\t사건의 지평선\t2026-01-08"
    };

    for(String line : sampleLines){
      String[] p = line.split("\\t");
      if(p.length < 4) continue;

      String category = p[0].trim();
      String title    = p[1].trim();
      String mainName = p[2].trim();
      String regDate  = p[3].trim();

      if(!grouped.containsKey(category)) continue;

      LocalDate d;
      try { d = LocalDate.parse(regDate, fmt); }
      catch(Exception e){ d = LocalDate.of(1970,1,1); }

      grouped.get(category).add(new Row(category, title, mainName, regDate, d));
    }

    // 최신순 정렬 + 최근 3개만
    for (String key : grouped.keySet()) {
      grouped.get(key).sort((a,b)-> b.date.compareTo(a.date));
      if (grouped.get(key).size() > 3) {
        grouped.put(key, new ArrayList<>(grouped.get(key).subList(0, 3)));
      }
    }

    // JSTL에서 쓰기 쉽게 List<Map<String,String>>로 변환
    java.util.function.Function<List<Row>, List<Map<String,String>>> toListMap = (rows) -> {
      List<Map<String,String>> result = new ArrayList<>();
      for (Row r : rows) {
        Map<String,String> m = new HashMap<>();
        m.put("title", r.title);
        m.put("mainName", r.mainName);
        m.put("regDate", r.regDate);
        result.add(m);
      }
      return result;
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
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>마이페이지 | 결정러</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage_result.css">
  
</head>

<body>

  <!-- 공통 헤더 -->
  <%@ include file="../common/common_header.jsp" %>

  <!-- 메인 컨텐츠 -->
  <div class="mypage-container">

    <!-- 왼쪽: 사이드 메뉴 -->
    <aside class="mp-sidebar">
      <div class="mp-profile">
        <div class="mp-avatar">😊</div>
        <div class="mp-name">${member.name}님</div>
        <div class="mp-email">${member.email_1}@${member.email_2}</div>
      </div>

      <ul class="mp-menu">
        <li class="mp-menu-item active" data-tab="profile">
          <span class="mp-icon">👤</span>
          <span>상세정보</span>
        </li>

        <li class="mp-menu-item" data-tab="taste">
          <span class="mp-icon">🎯</span>
          <span>취향선택</span>
        </li>

        <li class="mp-menu-item" data-tab="result">
          <span class="mp-icon">📊</span>
          <span>결과이력</span>
        </li>

        <li class="mp-menu-item" data-tab="pw">
          <span class="mp-icon">🔐</span>
          <span>비밀번호 변경</span>
        </li>
      </ul>

      <div class="mp-logout">
        <a href="<%=request.getContextPath()%>/auth/logout.jsp" class="btn-logout">로그아웃</a>
      </div>
    </aside>

    <!-- 오른쪽: 컨텐츠 -->
    <main class="mp-main">

      <!-- ================= TAB 1: 상세정보 ================= -->
      <div class="mp-panel active" data-tab="profile">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>👤 상세정보</h2>
            <p>내 기본 정보를 확인/수정할 수 있어요</p>
          </div>

          <form method="post" action="<%=request.getContextPath()%>/mypage?t_gubun=updateProfile" id="profileForm">
            <div class="mp-form-grid">

              <div class="field">
                <div class="label">닉네임</div>
                <input type="text" name="name" value="${member.name}" placeholder="닉네임">
              </div>

              <div class="field">
                <div class="label">나이</div>
                <input type="number" name="age" value="${member.age}" placeholder="예) 25" min="0" max="120">
              </div>

              <div class="field">
                <div class="label">지역</div>
                <select name="area">
                  <option value="">선택</option>
                  <option value="서울" <c:if test="${member.area=='서울'}">selected</c:if>>서울</option>
                  <option value="경기" <c:if test="${member.area=='경기'}">selected</c:if>>경기</option>
                  <option value="인천" <c:if test="${member.area=='인천'}">selected</c:if>>인천</option>
                  <option value="부산" <c:if test="${member.area=='부산'}">selected</c:if>>부산</option>
                  <option value="대구" <c:if test="${member.area=='대구'}">selected</c:if>>대구</option>
                  <option value="광주" <c:if test="${member.area=='광주'}">selected</c:if>>광주</option>
                  <option value="대전" <c:if test="${member.area=='대전'}">selected</c:if>>대전</option>
                  <option value="울산" <c:if test="${member.area=='울산'}">selected</c:if>>울산</option>
                  <option value="세종" <c:if test="${member.area=='세종'}">selected</c:if>>세종</option>
                  <option value="강원" <c:if test="${member.area=='강원'}">selected</c:if>>강원</option>
                  <option value="충북" <c:if test="${member.area=='충북'}">selected</c:if>>충북</option>
                  <option value="충남" <c:if test="${member.area=='충남'}">selected</c:if>>충남</option>
                  <option value="전북" <c:if test="${member.area=='전북'}">selected</c:if>>전북</option>
                  <option value="전남" <c:if test="${member.area=='전남'}">selected</c:if>>전남</option>
                  <option value="경북" <c:if test="${member.area=='경북'}">selected</c:if>>경북</option>
                  <option value="경남" <c:if test="${member.area=='경남'}">selected</c:if>>경남</option>
                  <option value="제주" <c:if test="${member.area=='제주'}">selected</c:if>>제주</option>
                </select>
              </div>

              <div class="field">
                <div class="label">성별</div>
                <select name="gender">
                  <option value="">선택</option>
                  <option value="M" <c:if test="${member.gender=='M'}">selected</c:if>>남</option>
                  <option value="F" <c:if test="${member.gender=='F'}">selected</c:if>>여</option>
                  <option value="N" <c:if test="${member.gender=='N'}">selected</c:if>>비공개</option>
                </select>
              </div>

              <div class="field span-2">
                <div class="label">이메일</div>
                <div class="email-row">
                  <input type="text" name="email_1" value="${member.email_1}" placeholder="example">
                  <span class="at">@</span>
                  <select name="email_2">
                    <option value="">선택</option>
                    <option value="gmail.com" <c:if test="${member.email_2=='gmail.com'}">selected</c:if>>gmail.com</option>
                    <option value="naver.com" <c:if test="${member.email_2=='naver.com'}">selected</c:if>>naver.com</option>
                    <option value="kakao.com" <c:if test="${member.email_2=='kakao.com'}">selected</c:if>>kakao.com</option>
                    <option value="daum.net" <c:if test="${member.email_2=='daum.net'}">selected</c:if>>daum.net</option>
                  </select>
                </div>
              </div>

              <div class="field span-2">
                <div class="label">전화번호</div>
                <div class="phone-row">
                  <input type="text" name="mobile_1" maxlength="3" value="${member.mobile_1}" placeholder="010">
                  <span class="dash">-</span>
                  <input type="text" name="mobile_2" maxlength="4" value="${member.mobile_2}" placeholder="1234">
                  <span class="dash">-</span>
                  <input type="text" name="mobile_3" maxlength="4" value="${member.mobile_3}" placeholder="5678">
                </div>
              </div>

              <div class="field">
                <div class="label">MBTI</div>
                <input type="text" name="mbti" maxlength="4" value="${member.mbti}" placeholder="예) INFP">
              </div>

              <div class="field">
                <div class="label">말투</div>
                <select name="style">
                  <option value="">선택</option>
                  <option value="존댓말" <c:if test="${member.style=='존댓말'}">selected</c:if>>존댓말</option>
                  <option value="반말" <c:if test="${member.style=='반말'}">selected</c:if>>반말</option>
                  <option value="메이드" <c:if test="${member.style=='메이드'}">selected</c:if>>메이드</option>
                </select>
              </div>

            </div>

            <div class="mp-actions">
              <button type="button" class="btn outline" id="btnEdit">✏️ 수정하기</button>
 			 <button type="submit" class="btn primary" id="btnSave" style="display:none;">💾 저장하기</button>
            </div>
          </form>
        </div>
      </div>

      <!-- ================= TAB 2: 취향선택 ================= -->
      <div class="mp-panel" data-tab="taste">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>🎯 취향선택</h2>
            <p>좋아하는 것들을 선택해주세요! 추천이 더 정확해져요</p>
          </div>

          <form name="tasteForm" method="post"
                action="<%=request.getContextPath()%>/mypage?t_gubun=updateTaste"
                id="tasteForm">

            <!-- 음식 -->
            <div class="chip-group">
              <div class="chip-title">🍔 좋아하는 음식</div>
              <div class="checkbox-group" data-category="food">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_korean" name="food" value="한식"
                    <c:if test="${pref.food != null && pref.food.contains('한식')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_korean"><span class="checkbox-box"></span><span>한식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_japanese" name="food" value="일식"
                    <c:if test="${pref.food != null && pref.food.contains('일식')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_japanese"><span class="checkbox-box"></span><span>일식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_chinese" name="food" value="중식"
                    <c:if test="${pref.food != null && pref.food.contains('중식')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_chinese"><span class="checkbox-box"></span><span>중식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_western" name="food" value="양식"
                    <c:if test="${pref.food != null && pref.food.contains('양식')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_western"><span class="checkbox-box"></span><span>양식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_snack" name="food" value="분식"
                    <c:if test="${pref.food != null && pref.food.contains('분식')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_snack"><span class="checkbox-box"></span><span>분식</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_food_dessert" name="food" value="디저트"
                    <c:if test="${pref.food != null && pref.food.contains('디저트')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_food_dessert"><span class="checkbox-box"></span><span>디저트</span></label>
                </div>
              </div>
            </div>
			<!-- 음료 -->
			<div class="chip-group">
			  <div class="chip-title">🥤 좋아하는 음료</div>
			  <div class="checkbox-group" data-category="drink">
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_ame" name="drink" value="아메리카노"
			        <c:if test="${pref.drink != null && pref.drink.contains('아메리카노')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_ame">
			        <span class="checkbox-box"></span><span>아메리카노</span>
			      </label>
			    </div>
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_latte" name="drink" value="라떼"
			        <c:if test="${pref.drink != null && pref.drink.contains('라떼')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_latte">
			        <span class="checkbox-box"></span><span>라떼</span>
			      </label>
			    </div>
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_tea" name="drink" value="차"
			        <c:if test="${pref.drink != null && pref.drink.contains('차')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_tea">
			        <span class="checkbox-box"></span><span>차</span>
			      </label>
			    </div>
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_ade" name="drink" value="에이드"
			        <c:if test="${pref.drink != null && pref.drink.contains('에이드')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_ade">
			        <span class="checkbox-box"></span><span>에이드</span>
			      </label>
			    </div>
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_soda" name="drink" value="탄산"
			        <c:if test="${pref.drink != null && pref.drink.contains('탄산')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_soda">
			        <span class="checkbox-box"></span><span>탄산</span>
			      </label>
			    </div>
			
			    <div class="checkbox-item">
			      <input type="checkbox" id="mp_drink_none" name="drink" value="없음"
			        <c:if test="${pref.drink != null && pref.drink.contains('없음')}">checked</c:if>>
			      <label class="checkbox-label" for="mp_drink_none">
			        <span class="checkbox-box"></span><span>없음</span>
			      </label>
			    </div>
			
			  </div>
			</div>
            <!-- 음악 -->
            <div class="chip-group">
              <div class="chip-title">🎵 좋아하는 음악</div>
              <div class="checkbox-group" data-category="music">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_kpop" name="music" value="K-POP"
                    <c:if test="${pref.music != null && pref.music.contains('K-POP')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_kpop"><span class="checkbox-box"></span><span>K-POP</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_hiphop" name="music" value="힙합"
                    <c:if test="${pref.music != null && pref.music.contains('힙합')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_hiphop"><span class="checkbox-box"></span><span>힙합</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_ballad" name="music" value="발라드"
                    <c:if test="${pref.music != null && pref.music.contains('발라드')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_ballad"><span class="checkbox-box"></span><span>발라드</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_edm" name="music" value="EDM"
                    <c:if test="${pref.music != null && pref.music.contains('EDM')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_edm"><span class="checkbox-box"></span><span>EDM</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_jazz" name="music" value="재즈"
                    <c:if test="${pref.music != null && pref.music.contains('재즈')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_jazz"><span class="checkbox-box"></span><span>재즈</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_music_rock" name="music" value="락"
                    <c:if test="${pref.music != null && pref.music.contains('락')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_music_rock"><span class="checkbox-box"></span><span>락</span></label>
                </div>
              </div>
            </div>

            <!-- 영화 -->
            <div class="chip-group">
              <div class="chip-title">🎬 좋아하는 영화</div>
              <div class="checkbox-group" data-category="movie">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_action" name="movie" value="액션"
                    <c:if test="${pref.movie != null && pref.movie.contains('액션')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_action"><span class="checkbox-box"></span><span>액션</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_romance" name="movie" value="로맨스"
                    <c:if test="${pref.movie != null && pref.movie.contains('로맨스')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_romance"><span class="checkbox-box"></span><span>로맨스</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_comedy" name="movie" value="코미디"
                    <c:if test="${pref.movie != null && pref.movie.contains('코미디')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_comedy"><span class="checkbox-box"></span><span>코미디</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_sf" name="movie" value="SF"
                    <c:if test="${pref.movie != null && pref.movie.contains('SF')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_sf"><span class="checkbox-box"></span><span>SF</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_horror" name="movie" value="공포"
                    <c:if test="${pref.movie != null && pref.movie.contains('공포')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_horror"><span class="checkbox-box"></span><span>공포</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_movie_drama" name="movie" value="드라마"
                    <c:if test="${pref.movie != null && pref.movie.contains('드라마')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_movie_drama"><span class="checkbox-box"></span><span>드라마</span></label>
                </div>
              </div>
            </div>

            <!-- 책 -->
            <div class="chip-group">
              <div class="chip-title">📚 좋아하는 책</div>
              <div class="checkbox-group" data-category="book">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_novel" name="book" value="소설"
                    <c:if test="${pref.book != null && pref.book.contains('소설')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_book_novel"><span class="checkbox-box"></span><span>소설</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_self" name="book" value="자기계발"
                    <c:if test="${pref.book != null && pref.book.contains('자기계발')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_book_self"><span class="checkbox-box"></span><span>자기계발</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_economy" name="book" value="경제"
                    <c:if test="${pref.book != null && pref.book.contains('경제')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_book_economy"><span class="checkbox-box"></span><span>경제</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_human" name="book" value="인문"
                    <c:if test="${pref.book != null && pref.book.contains('인문')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_book_human"><span class="checkbox-box"></span><span>인문</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_book_comic" name="book" value="만화"
                    <c:if test="${pref.book != null && pref.book.contains('만화')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_book_comic"><span class="checkbox-box"></span><span>만화</span></label>
                </div>
              </div>
            </div>

            <!-- 알레르기 -->
            <div class="chip-group">
              <div class="chip-title">⚠️ 알레르기</div>
              <div class="checkbox-group" data-category="allergy">
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_nut" name="allergy" value="견과류"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('견과류')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_nut"><span class="checkbox-box"></span><span>견과류</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_milk" name="allergy" value="우유"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('우유')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_milk"><span class="checkbox-box"></span><span>우유</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_egg" name="allergy" value="계란"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('계란')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_egg"><span class="checkbox-box"></span><span>계란</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_wheat" name="allergy" value="밀"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('밀')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_wheat"><span class="checkbox-box"></span><span>밀</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_seafood" name="allergy" value="갑각류"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('갑각류')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_seafood"><span class="checkbox-box"></span><span>갑각류</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_soy" name="allergy" value="대두"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('대두')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_soy"><span class="checkbox-box"></span><span>대두</span></label>
                </div>
                <div class="checkbox-item">
                  <input type="checkbox" id="mp_allergy_none" name="allergy" value="없음"
                    <c:if test="${pref.allergy != null && pref.allergy.contains('없음')}">checked</c:if>>
                  <label class="checkbox-label" for="mp_allergy_none"><span class="checkbox-box"></span><span>없음</span></label>
                </div>
              </div>
            </div>

            <div class="mp-actions">
              <button type="submit" class="btn primary">💾 수정하기</button>
            </div>

          </form>
        </div>
      </div>

      <!-- ================= TAB 3: 결과이력 ================= -->
      <div class="mp-panel" data-tab="result">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>📊 결과이력</h2>
            <p>추천 결과 이력을 확인할 수 있어요</p>
          </div>

          <div class="rh-wrap" style="padding:16px;">
  <div class="rh-sections">

    <!-- 음식 -->
    <section class="rh-section">
  <div class="rh-sec-head">
    <h3>🍜 음식 <span class="rh-mini">최근 3개</span></h3>
    
  </div>

  <div class="rh-grid">
    <c:forEach var="h" items="${foodList}">
      <article class="rh-card"
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
  </div>
</section>

    <!-- 음료 -->
    <section class="rh-section">
      <div class="rh-sec-head">
        <h3>🥤 음료 <span class="rh-mini">최근 3개</span></h3>
        
      </div>
      <div class="rh-grid">
        <c:forEach var="h" items="${drinkList}">
          <article class="rh-card "
                   data-title="${h.title}" data-result="${h.mainName}" data-date="${h.regDate}">
            <div class="rh-ico drink">🥤</div>
            <div class="rh-body">
              <p class="rh-title">${h.title}</p>
              <p class="rh-result">결과: <b>${h.mainName}</b></p>
              <p class="rh-date">${h.regDate}</p>
            </div>
          </article>
        </c:forEach>
      </div>
    </section>

    <!-- 영화 -->
    <section class="rh-section">
      <div class="rh-sec-head">
        <h3>🎬 영화 <span class="rh-mini">최근 3개</span></h3>
        
      </div>
      <div class="rh-grid">
        <c:forEach var="h" items="${movieList}">
          <article class="rh-card "
                   data-title="${h.title}" data-result="${h.mainName}" data-date="${h.regDate}">
            <div class="rh-ico movie">🎬</div>
            <div class="rh-body">
              <p class="rh-title">${h.title}</p>
              <p class="rh-result">결과: <b>${h.mainName}</b></p>
              <p class="rh-date">${h.regDate}</p>
            </div>
          </article>
        </c:forEach>
      </div>
    </section>

    <!-- 책 -->
    <section class="rh-section">
      <div class="rh-sec-head">
        <h3>📚 책 <span class="rh-mini">최근 3개</span></h3>
        
      </div>
      <div class="rh-grid">
        <c:forEach var="h" items="${bookList}">
          <article class="rh-card "
                   data-title="${h.title}" data-result="${h.mainName}" data-date="${h.regDate}">
            <div class="rh-ico book">📚</div>
            <div class="rh-body">
              <p class="rh-title">${h.title}</p>
              <p class="rh-result">결과: <b>${h.mainName}</b></p>
              <p class="rh-date">${h.regDate}</p>
            </div>
          </article>
        </c:forEach>
      </div>
    </section>

    <!-- 음악 -->
    <section class="rh-section">
      <div class="rh-sec-head">
        <h3>🎵 음악 <span class="rh-mini">최근 3개</span></h3>
        
      </div>
      <div class="rh-grid">
        <c:forEach var="h" items="${musicList}">
          <article class="rh-card "
                   data-title="${h.title}" data-result="${h.mainName}" data-date="${h.regDate}">
            <div class="rh-ico music">🎵</div>
            <div class="rh-body">
              <p class="rh-title">${h.title}</p>
              <p class="rh-result">결과: <b>${h.mainName}</b></p>
              <p class="rh-date">${h.regDate}</p>
            </div>
          </article>
        </c:forEach>
      </div>
    </section>

  </div>
</div>

        </div>
      </div>

      <!-- ================= TAB 4: 비밀번호 변경 ================= -->
      <div class="mp-panel" data-tab="pw">
        <div class="mp-card">
          <div class="mp-card-header">
            <h2>🔐 비밀번호 변경</h2>
            <p>현재 비밀번호 확인 후 변경할 수 있어요</p>
          </div>

          <form method="post" action="<%=request.getContextPath()%>/mypage?t_gubun=pwUpdate" id="pwForm">
  <div class="mp-form-grid">
    <div class="field span-2">
      <div class="label">현재 비밀번호</div>
      <input type="password" name="t_now_pw" required>
    </div>
    <div class="field">
      <div class="label">새 비밀번호</div>
      <input type="password" name="t_new_pw" required>
    </div>
    <div class="field">
      <div class="label">새 비밀번호 확인</div>
      <input type="password" name="t_new_pw_confirm" required>
    </div>
  </div>
  <div class="mp-actions">
    <button type="submit" class="btn primary">변경하기</button>
  </div>
</form>
        </div>
      </div>

    </main>

    
  </div>

  <!-- 푸터 -->
  <footer class="footer">
    <%@ include file="../common/common_footer.jsp" %>
  </footer>

  <!-- ================= JS: 탭 전환 + 주소 고정 (중복X) ================= -->
  <script>
  
/*//====== [진단] 클릭이 안 먹을 때, 실제 클릭된 요소가 뭔지 확인 ======
  document.addEventListener("click", function(e){
    // input/select 클릭 시도했는데 다른게 잡히면 범인임
    const tag = e.target.tagName;
    console.log("CLICK TARGET:", tag, e.target);
  }, true);

  // ====== [진단] 입력칸 위를 덮는 요소가 있는지 확인 (마우스 위치 기준) ======
  document.addEventListener("mousemove", function(e){
    const el = document.elementFromPoint(e.clientX, e.clientY);
    // input/select 위에 마우스 올렸는데 el이 input이 아니면 덮개임
    if(el && (el.tagName !== "INPUT" && el.tagName !== "SELECT" && el.tagName !== "TEXTAREA")){
      // 너무 많이 찍히면 렉이니 주석처리 가능
      // console.log("TOP ELEMENT:", el.tagName, el.className);
    }
  });*/
//탭 전환
  document.querySelectorAll('.mp-menu-item[data-tab]').forEach(item => {
    item.addEventListener('click', function () {
      const tab = this.dataset.tab;

      document.querySelectorAll('.mp-menu-item').forEach(m => m.classList.remove('active'));
      this.classList.add('active');

      document.querySelectorAll('.mp-panel').forEach(p => p.classList.remove('active'));
      const target = document.querySelector('.mp-panel[data-tab="' + tab + '"]');
      if (target) target.classList.add('active');

      history.replaceState(null, '', '<%=request.getContextPath()%>/mypage');
    });
  });

  // ===== 상세정보: 수정모드 토글 =====
  const editBtn = document.getElementById("btnEdit");
  const saveBtn = document.getElementById("btnSave");
  const profileForm = document.getElementById("profileForm");

  if (profileForm && editBtn && saveBtn) {

    // 1) 처음엔 입력만 잠그기 (버튼은 잠그지 않음)
    profileForm.querySelectorAll("input, select").forEach(el => {
      // 버튼류/hidden은 건드리지 않기(안전)
      if (el.type === "hidden" || el.type === "button" || el.type === "submit") return;
      el.disabled = true;
    });

    // 2) 수정하기 누르면 입력 활성화 + 저장버튼 표시
    editBtn.addEventListener("click", () => {
      profileForm.querySelectorAll("input, select").forEach(el => {
        if (el.type === "hidden" || el.type === "button" || el.type === "submit") return;
        el.disabled = false;
      });
      editBtn.style.display = "none";
      saveBtn.style.display = "inline-flex";
    });

    // 3) 저장(submit) 직전에 disabled 풀어서 값 전송되게
    profileForm.addEventListener("submit", () => {
      profileForm.querySelectorAll("input, select").forEach(el => el.disabled = false);
    });
  }
  
  /*(function(){
    const box = document.createElement('div');
    box.style.cssText =
      'position:fixed;left:12px;bottom:12px;z-index:999999;' +
      'background:#fff;padding:8px 10px;border:1px solid #000;' +
      'font-size:12px;border-radius:6px;opacity:.95';
    box.textContent = 'click test ready';
    document.body.appendChild(box);

    document.addEventListener('click', function(e){
      const top = document.elementFromPoint(e.clientX, e.clientY);
      const cs = top ? getComputedStyle(top) : null;

      box.textContent =
        'TOP: ' + (top ? top.tagName : '-') +
        ' #' + (top && top.id ? top.id : '-') +
        ' .' + (top && top.className ? top.className : '-') +
        ' | z=' + (cs ? cs.zIndex : '-') +
        ' | pos=' + (cs ? cs.position : '-');
    }, true);
  })();*/
  
  </script>


</body>
</html>
