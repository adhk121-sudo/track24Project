<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리 | 결정러 관리자</title>
    <link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!-- 사이드바 -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>⚡ 결정러</h2>
                <span>관리자 대시보드</span>
            </div>
            
            <div class="menu-title">카테고리 통계</div>
            
            <div class="menu-item" onclick="location.href='AdminDashboard'">
                <span class="icon">📊</span>
                <span class="text">전체 현황</span>
            </div>
            <div class="menu-item food" onclick="location.href='AdminDashboard?category=food'">
                <span class="icon">🍜</span>
                <span class="text">맛레인저</span>
            </div>
            <div class="menu-item drink" onclick="location.href='AdminDashboard?category=drink'">
                <span class="icon">🥤</span>
                <span class="text">드링크레인저</span>
            </div>
            <div class="menu-item movie" onclick="location.href='AdminDashboard?category=movie'">
                <span class="icon">🎬</span>
                <span class="text">무비레인저</span>
            </div>
            <div class="menu-item book" onclick="location.href='AdminDashboard?category=book'">
                <span class="icon">📚</span>
                <span class="text">북레인저</span>
            </div>
            <div class="menu-item music" onclick="location.href='AdminDashboard?category=music'">
                <span class="icon">🎵</span>
                <span class="text">뮤직레인저</span>
            </div>
            
            <div class="menu-title" style="margin-top: 30px;">관리</div>
            <div class="menu-item active">
                <span class="icon">👥</span>
                <span class="text">회원 관리</span>
            </div>
            <div class="menu-item" onclick="location.href='Power'">
                <span class="icon">🏠</span>
                <span class="text">메인으로</span>
            </div>
        </aside>
        
        <!-- 메인 영역 -->
        <main class="main">
            <div class="page-header">
                <h1>👥 회원 관리</h1>
                <p>전체 회원 목록을 확인하고 관리하세요</p>
            </div>
            
            <!-- 통계 카드 -->
            <div class="stats-row">
                <div class="stat-card">
                    <div class="label">전체 회원</div>
                    <div class="value">${totalUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="label">이번 달 가입</div>
                    <div class="value">${monthlyUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="label">오늘 가입</div>
                    <div class="value">${todayUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="label">남성 / 여성</div>
                    <div class="value">${maleUsers} / ${femaleUsers}</div>
                </div>
            </div>
            
            <!-- 검색 & 필터 -->
            <div class="filter-bar">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="아이디, 닉네임 검색..." onkeyup="searchUsers()">
                    <button class="search-btn">🔍</button>
                </div>
                <div class="filter-group">
                    <select id="filterGender" onchange="filterUsers()">
                        <option value="">성별 전체</option>
                        <option value="M">남성</option>
                        <option value="F">여성</option>
                        <option value="N">비공개</option>
                    </select>
                    <select id="filterArea" onchange="filterUsers()">
                        <option value="">지역 전체</option>
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
            </div>
            
            <!-- 회원 테이블 -->
            <div class="table-card">
                <table class="user-table" id="userTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>아이디</th>
                            <th>닉네임</th>
                            <th>나이</th>
                            <th>성별</th>
                            <th>지역</th>
                            <th>MBTI</th>
                            <th>가입일</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- 샘플 데이터 - 나중에 c:forEach로 변경 -->
                        <tr>
                            <td>1</td>
                            <td>user001</td>
                            <td>홍길동</td>
                            <td>25</td>
                            <td><span class="badge male">남</span></td>
                            <td>서울</td>
                            <td>ENFP</td>
                            <td>2025-01-10</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('user001')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('user001')">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>user002</td>
                            <td>김영희</td>
                            <td>28</td>
                            <td><span class="badge female">여</span></td>
                            <td>부산</td>
                            <td>ISTJ</td>
                            <td>2025-01-09</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('user002')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('user002')">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>user003</td>
                            <td>이철수</td>
                            <td>32</td>
                            <td><span class="badge male">남</span></td>
                            <td>대전</td>
                            <td>INTP</td>
                            <td>2025-01-08</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('user003')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('user003')">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>user004</td>
                            <td>박지민</td>
                            <td>22</td>
                            <td><span class="badge female">여</span></td>
                            <td>대구</td>
                            <td>ESFJ</td>
                            <td>2025-01-07</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('user004')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('user004')">삭제</button>
                            </td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>user005</td>
                            <td>최민수</td>
                            <td>27</td>
                            <td><span class="badge other">비공개</span></td>
                            <td>인천</td>
                            <td>ENTJ</td>
                            <td>2025-01-06</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('user005')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('user005')">삭제</button>
                            </td>
                        </tr>
                        
                        <!-- 실제 데이터는 이렇게 -->
                        <!--
                        <c:forEach var="user" items="${userList}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${user.id}</td>
                                <td>${user.name}</td>
                                <td>${user.age}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.gender == 'M'}">
                                            <span class="badge male">남</span>
                                        </c:when>
                                        <c:when test="${user.gender == 'F'}">
                                            <span class="badge female">여</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge other">비공개</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${user.area}</td>
                                <td>${user.mbti}</td>
                                <td>${user.regDate}</td>
                                <td>
                                    <button class="btn-view" onclick="viewUser('${user.id}')">상세</button>
                                    <button class="btn-delete" onclick="deleteUser('${user.id}')">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                        -->
                    </tbody>
                </table>
            </div>
            
            <!-- 페이지네이션 -->
            <div class="pagination">
                <a href="#" class="page-btn disabled">« 이전</a>
                <a href="#" class="page-btn active">1</a>
                <a href="#" class="page-btn">2</a>
                <a href="#" class="page-btn">3</a>
                <a href="#" class="page-btn">4</a>
                <a href="#" class="page-btn">5</a>
                <a href="#" class="page-btn">다음 »</a>
            </div>
            
        </main>
    </div>
    
    <!-- 회원 상세 모달 -->
    <div class="modal" id="userModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>👤 회원 상세 정보</h3>
                <button class="modal-close" onclick="closeModal()">×</button>
            </div>
            <div class="modal-body">
                <div class="user-detail">
                    <div class="detail-section">
                        <h4>기본 정보</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="label">아이디</span>
                                <span class="value" id="modalId">user001</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">닉네임</span>
                                <span class="value" id="modalName">홍길동</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">나이</span>
                                <span class="value" id="modalAge">25</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">성별</span>
                                <span class="value" id="modalGender">남</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">지역</span>
                                <span class="value" id="modalArea">서울</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">MBTI</span>
                                <span class="value" id="modalMbti">ENFP</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>연락처</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="label">전화번호</span>
                                <span class="value" id="modalPhone">010-1234-5678</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">이메일</span>
                                <span class="value" id="modalEmail">user001@gmail.com</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>취향 정보</h4>
                        <div class="preference-tags">
                            <div class="pref-group">
                                <span class="pref-label">🍜 음식</span>
                                <div class="tags" id="modalFood">
                                    <span class="tag food">한식</span>
                                    <span class="tag food">양식</span>
                                </div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🥤 음료</span>
                                <div class="tags" id="modalDrink">
                                    <span class="tag drink">커피</span>
                                    <span class="tag drink">차</span>
                                </div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🎬 영화</span>
                                <div class="tags" id="modalMovie">
                                    <span class="tag movie">액션</span>
                                    <span class="tag movie">코미디</span>
                                </div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">📚 책</span>
                                <div class="tags" id="modalBook">
                                    <span class="tag book">소설</span>
                                </div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🎵 음악</span>
                                <div class="tags" id="modalMusic">
                                    <span class="tag music">K-POP</span>
                                    <span class="tag music">발라드</span>
                                </div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">⚠️ 알레르기</span>
                                <div class="tags" id="modalAllergy">
                                    <span class="tag allergy">견과류</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>가입 정보</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="label">말투</span>
                                <span class="value" id="modalStyle">반말</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">가입일</span>
                                <span class="value" id="modalRegDate">2025-01-10</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn outline" onclick="closeModal()">닫기</button>
                <button class="btn danger" onclick="deleteUser('')">회원 삭제</button>
            </div>
        </div>
    </div>
    
    
    
    <script>
        // 검색
        function searchUsers() {
            var input = document.getElementById('searchInput').value.toLowerCase();
            var rows = document.querySelectorAll('#userTable tbody tr');
            
            rows.forEach(function(row) {
                var id = row.cells[1].textContent.toLowerCase();
                var name = row.cells[2].textContent.toLowerCase();
                
                if (id.includes(input) || name.includes(input)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        // 필터
        function filterUsers() {
            var gender = document.getElementById('filterGender').value;
            var area = document.getElementById('filterArea').value;
            var rows = document.querySelectorAll('#userTable tbody tr');
            
            rows.forEach(function(row) {
                var rowGender = row.cells[4].textContent.trim();
                var rowArea = row.cells[5].textContent.trim();
                
                var genderMatch = !gender || 
                    (gender === 'M' && rowGender === '남') ||
                    (gender === 'F' && rowGender === '여') ||
                    (gender === 'N' && rowGender === '비공개');
                var areaMatch = !area || rowArea === area;
                
                if (genderMatch && areaMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        // 회원 상세 보기
        function viewUser(userId) {
            document.getElementById('userModal').classList.add('show');
            // TODO: Ajax로 회원 정보 가져오기
        }
        
        // 모달 닫기
        function closeModal() {
            document.getElementById('userModal').classList.remove('show');
        }
        
        // 회원 삭제
        function deleteUser(userId) {
            if (confirm('정말 이 회원을 삭제하시겠습니까?')) {
                // TODO: Ajax로 삭제 요청
                alert('삭제되었습니다.');
                closeModal();
            }
        }
        
        // 모달 외부 클릭 시 닫기
        document.getElementById('userModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
    </script>
</body>
</html>