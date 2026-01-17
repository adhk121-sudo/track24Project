<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 관리 | 결정레인저 관리자</title>
    <link href="<%=request.getContextPath()%>/css/admin.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!-- 사이드바 -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <h2>⚡ 결정레인저</h2>
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
                        <c:forEach items="${list}" var="dto" varStatus="status">
                        <tr>
                            <td>${(currentPage - 1) * pageSize + status.count}</td>
                            <td>${dto.id}</td>
                            <td>${dto.name}</td>
                            <td>${dto.age}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${dto.gender == 'M'}">
                                        <span class="badge male">남</span>
                                    </c:when>
                                    <c:when test="${dto.gender == 'F'}">
                                        <span class="badge female">여</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge other">비공개</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${dto.area}</td>
                            <td>${dto.mbti}</td>
                            <td>${dto.reg_date}</td>
                            <td>
                                <button class="btn-view" onclick="viewUser('${dto.id}')">상세</button>
                                <button class="btn-delete" onclick="deleteUser('${dto.id}')">삭제</button>
                            </td>
                        </tr>
                        </c:forEach>
                        
                        <c:if test="${empty list}">
                        <tr>
                            <td colspan="9" style="text-align: center; padding: 40px;">
                                등록된 회원이 없습니다.
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- 페이지네이션 -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="AdminUsers?action=list&page=${currentPage - 1}" class="page-btn">« 이전</a>
                </c:if>
                <c:if test="${currentPage <= 1}">
                    <a href="#" class="page-btn disabled">« 이전</a>
                </c:if>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <a href="#" class="page-btn active">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="AdminUsers?action=list&page=${i}" class="page-btn">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                <c:if test="${currentPage < totalPages}">
                    <a href="AdminUsers?action=list&page=${currentPage + 1}" class="page-btn">다음 »</a>
                </c:if>
                <c:if test="${currentPage >= totalPages}">
                    <a href="#" class="page-btn disabled">다음 »</a>
                </c:if>
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
                                <span class="value" id="modalId">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">닉네임</span>
                                <span class="value" id="modalName">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">나이</span>
                                <span class="value" id="modalAge">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">성별</span>
                                <span class="value" id="modalGender">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">지역</span>
                                <span class="value" id="modalArea">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">MBTI</span>
                                <span class="value" id="modalMbti">-</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>연락처</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="label">전화번호</span>
                                <span class="value" id="modalPhone">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">이메일</span>
                                <span class="value" id="modalEmail">-</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>취향 정보</h4>
                        <div class="preference-tags">
                            <div class="pref-group">
                                <span class="pref-label">🍜 음식</span>
                                <div class="tags" id="modalFood"></div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🥤 음료</span>
                                <div class="tags" id="modalDrink"></div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🎬 영화</span>
                                <div class="tags" id="modalMovie"></div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">📚 책</span>
                                <div class="tags" id="modalBook"></div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">🎵 음악</span>
                                <div class="tags" id="modalMusic"></div>
                            </div>
                            <div class="pref-group">
                                <span class="pref-label">⚠️ 알레르기</span>
                                <div class="tags" id="modalAllergy"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-section">
                        <h4>가입 정보</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <span class="label">말투</span>
                                <span class="value" id="modalStyle">-</span>
                            </div>
                            <div class="detail-item">
                                <span class="label">가입일</span>
                                <span class="value" id="modalRegDate">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn outline" onclick="closeModal()">닫기</button>
                <button class="btn danger" id="modalDeleteBtn" onclick="deleteUser('')">회원 삭제</button>
            </div>
        </div>
    </div>
    
    <script>
        var currentUserId = '';
        
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
        
        // 회원 상세 보기 (Ajax)
        function viewUser(userId) {
            currentUserId = userId;
            
            fetch('AdminUsers?action=detail&userId=' + userId)
                .then(response => response.json())
                .then(data => {
                    // 기본 정보
                    document.getElementById('modalId').textContent = data.id || '-';
                    document.getElementById('modalName').textContent = data.name || '-';
                    document.getElementById('modalAge').textContent = data.age || '-';
                    
                    var gender = '-';
                    if (data.gender === 'M') gender = '남성';
                    else if (data.gender === 'F') gender = '여성';
                    else if (data.gender === 'N') gender = '비공개';
                    document.getElementById('modalGender').textContent = gender;
                    
                    document.getElementById('modalArea').textContent = data.area || '-';
                    document.getElementById('modalMbti').textContent = data.mbti || '-';
                    
                    // 연락처
                    var phone = '-';
                    if (data.mobile_1 && data.mobile_2 && data.mobile_3) {
                        phone = data.mobile_1 + '-' + data.mobile_2 + '-' + data.mobile_3;
                    }
                    document.getElementById('modalPhone').textContent = phone;
                    
                    var email = '-';
                    if (data.email_1 && data.email_2) {
                        email = data.email_1 + '@' + data.email_2;
                    }
                    document.getElementById('modalEmail').textContent = email;
                    
                    // 취향 태그
                    setTags('modalFood', data.food, 'food');
                    setTags('modalDrink', data.drink, 'drink');
                    setTags('modalMovie', data.movie, 'movie');
                    setTags('modalBook', data.book, 'book');
                    setTags('modalMusic', data.music, 'music');
                    setTags('modalAllergy', data.allergy, 'allergy');
                    
                    // 가입 정보
                    document.getElementById('modalStyle').textContent = data.style || '-';
                    document.getElementById('modalRegDate').textContent = data.reg_date || '-';
                    
                    // 삭제 버튼에 userId 설정
                    document.getElementById('modalDeleteBtn').onclick = function() {
                        deleteUser(userId);
                    };
                    
                    // 모달 열기
                    document.getElementById('userModal').classList.add('show');
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('회원 정보를 불러오는데 실패했습니다.');
                });
        }
        
        // 태그 설정 함수
        function setTags(elementId, value, tagClass) {
            var container = document.getElementById(elementId);
            container.innerHTML = '';
            
            if (value && value.trim() !== '') {
                var items = value.split(',');
                items.forEach(function(item) {
                    item = item.trim();
                    if (item) {
                        var tag = document.createElement('span');
                        tag.className = 'tag ' + tagClass;
                        tag.textContent = item;
                        container.appendChild(tag);
                    }
                });
            } else {
                container.innerHTML = '<span style="color: #999;">없음</span>';
            }
        }
        
        // 모달 닫기
        function closeModal() {
            document.getElementById('userModal').classList.remove('show');
            currentUserId = '';
        }
        
        // 회원 삭제 (Ajax)
        function deleteUser(userId) {
            if (!userId) userId = currentUserId;
            if (!userId) {
                alert('삭제할 회원을 선택해주세요.');
                return;
            }
            
            if (confirm('정말 "' + userId + '" 회원을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
                fetch('AdminUsers?action=delete&userId=' + userId)
                    .then(response => response.json())
                    .then(data => {
                        if (data.result === 1) {
                            alert('회원이 삭제되었습니다.');
                            closeModal();
                            location.reload();  // 페이지 새로고침
                        } else {
                            alert('삭제에 실패했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('삭제 요청 중 오류가 발생했습니다.');
                    });
            }
        }
        
        // 모달 외부 클릭 시 닫기
        document.getElementById('userModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });
        
        // ESC 키로 모달 닫기
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });
    </script>
</body>
</html>