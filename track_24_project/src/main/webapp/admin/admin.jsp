<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="css/admin.css" rel="stylesheet">
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드 | 결정레인저</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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
            
            <div class="menu-item active" data-category="all" onclick="showCategory('all')">
                <span class="icon">📊</span>
                <span class="text">전체 현황</span>
            </div>
            <div class="menu-item food" data-category="food" onclick="showCategory('food')">
                <span class="icon">🍜</span>
                <span class="text">맛레인저</span>
            </div>
            <div class="menu-item drink" data-category="drink" onclick="showCategory('drink')">
                <span class="icon">🥤</span>
                <span class="text">드링크레인저</span>
            </div>
            <div class="menu-item movie" data-category="movie" onclick="showCategory('movie')">
                <span class="icon">🎬</span>
                <span class="text">무비레인저</span>
            </div>
            <div class="menu-item book" data-category="book" onclick="showCategory('book')">
                <span class="icon">📚</span>
                <span class="text">북레인저</span>
            </div>
            <div class="menu-item music" data-category="music" onclick="showCategory('music')">
                <span class="icon">🎵</span>
                <span class="text">뮤직레인저</span>
            </div>
            
            <div class="menu-title" style="margin-top: 30px;">관리</div>
            <div class="menu-item" onclick="location.href='Power?t_gubun=admin_users'">
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
            <!-- 전체 현황 -->
            <section class="charts-section active" id="section-all">
                <div class="page-header">
                    <h1>📊 전체 현황</h1>
                    <p>모든 카테고리의 통계를 한눈에 확인하세요</p>
                </div>
                
                <div class="stats-row">
                    <div class="stat-card food">
                        <div class="label">🍜 맛레인저</div>
                        <div class="value">${foodTotal}</div>
                        <div class="change">↑ 12% 이번 주</div>
                    </div>
                    <div class="stat-card drink">
                        <div class="label">🥤 드링크레인저</div>
                        <div class="value">${drinkTotal}</div>
                        <div class="change">↑ 8% 이번 주</div>
                    </div>
                    <div class="stat-card movie">
                        <div class="label">🎬 무비레인저</div>
                        <div class="value">${movieTotal}</div>
                        <div class="change">↑ 15% 이번 주</div>
                    </div>
                    <div class="stat-card book">
                        <div class="label">📚 북레인저</div>
                        <div class="value">${bookTotal}</div>
                        <div class="change">↑ 5% 이번 주</div>
                    </div>
                </div>
                
                <!-- 전체 월별 추이 -->
                <div class="trend-card">
                    <h3>📈 월별 사용 추이</h3>
                    <canvas id="allTrendChart"></canvas>
                </div>
            </section>
            
            <!-- 맛레인저 -->
            <section class="charts-section" id="section-food">
                <div class="page-header">
                    <h1>🍜 맛레인저 통계</h1>
                    <p>음식 추천 질문별 선택 현황</p>
                </div>
                
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>Q1. 오늘 기분이 어때?</h3>
                        <canvas id="foodQ1Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q2. 어떤 식사야?</h3>
                        <canvas id="foodQ2Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q3. 어떤 스타일?</h3>
                        <canvas id="foodQ3Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q4. 누구랑 먹어?</h3>
                        <canvas id="foodQ4Chart"></canvas>
                    </div>
                </div>
                
                <div class="trend-card">
                    <h3>📈 맛레인저 월별 추이</h3>
                    <canvas id="foodTrendChart"></canvas>
                </div>
            </section>
            
            <!-- 드링크레인저 -->
            <section class="charts-section" id="section-drink">
                <div class="page-header">
                    <h1>🥤 드링크레인저 통계</h1>
                    <p>음료 추천 질문별 선택 현황</p>
                </div>
                
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>Q1. 오늘 기분이 어때?</h3>
                        <canvas id="drinkQ1Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q2. 차가운 거? 따뜻한 거?</h3>
                        <canvas id="drinkQ2Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q3. 어떤 종류?</h3>
                        <canvas id="drinkQ3Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q4. 단 거 좋아해?</h3>
                        <canvas id="drinkQ4Chart"></canvas>
                    </div>
                </div>
                
                <div class="trend-card">
                    <h3>📈 드링크레인저 월별 추이</h3>
                    <canvas id="drinkTrendChart"></canvas>
                </div>
            </section>
            
            <!-- 무비레인저 -->
            <section class="charts-section" id="section-movie">
                <div class="page-header">
                    <h1>🎬 무비레인저 통계</h1>
                    <p>영화 추천 질문별 선택 현황</p>
                </div>
                
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>Q1. 오늘 기분이 어때?</h3>
                        <canvas id="movieQ1Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q2. 어떤 장르?</h3>
                        <canvas id="movieQ2Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q3. 어떤 분위기?</h3>
                        <canvas id="movieQ3Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q4. 누구랑 볼 거야?</h3>
                        <canvas id="movieQ4Chart"></canvas>
                    </div>
                </div>
                
                <div class="trend-card">
                    <h3>📈 무비레인저 월별 추이</h3>
                    <canvas id="movieTrendChart"></canvas>
                </div>
            </section>
            
            <!-- 북레인저 -->
            <section class="charts-section" id="section-book">
                <div class="page-header">
                    <h1>📚 북레인저 통계</h1>
                    <p>책 추천 질문별 선택 현황</p>
                </div>
                
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>Q1. 오늘 기분이 어때?</h3>
                        <canvas id="bookQ1Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q2. 어떤 장르?</h3>
                        <canvas id="bookQ2Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q3. 분량은?</h3>
                        <canvas id="bookQ3Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q4. 읽는 목적?</h3>
                        <canvas id="bookQ4Chart"></canvas>
                    </div>
                </div>
                
                <div class="trend-card">
                    <h3>📈 북레인저 월별 추이</h3>
                    <canvas id="bookTrendChart"></canvas>
                </div>
            </section>
            
            <!-- 뮤직레인저 -->
            <section class="charts-section" id="section-music">
                <div class="page-header">
                    <h1>🎵 뮤직레인저 통계</h1>
                    <p>음악 추천 질문별 선택 현황</p>
                </div>
                
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>Q1. 오늘 기분이 어때?</h3>
                        <canvas id="musicQ1Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q2. 어떤 장르?</h3>
                        <canvas id="musicQ2Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q3. 어떤 상황?</h3>
                        <canvas id="musicQ3Chart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h3>Q4. 템포는?</h3>
                        <canvas id="musicQ4Chart"></canvas>
                    </div>
                </div>
                
                <div class="trend-card">
                    <h3>📈 뮤직레인저 월별 추이?</h3>
                    <canvas id="musicTrendChart"></canvas>
                </div>
            </section>
        </main>
    </div>
    
    <script>
        // 카테고리 전환
        function showCategory(category) {
            // 메뉴 active 변경
            document.querySelectorAll('.menu-item').forEach(item => {
                item.classList.remove('active');
            });
            document.querySelector('.menu-item[data-category="' + category + '"]').classList.add('active');
            
            // 섹션 전환
            document.querySelectorAll('.charts-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById('section-' + category).classList.add('active');
        }
        
        // 차트 색상
        const colors = {
            food: ['#dc2626', '#f97316', '#fb923c', '#fdba74'],
            drink: ['#ca8a04', '#eab308', '#facc15', '#fde047'],
            movie: ['#7c3aed', '#8b5cf6', '#a78bfa', '#c4b5fd'],
            book: ['#059669', '#10b981', '#34d399', '#6ee7b7'],
            music: ['#2563eb', '#3b82f6', '#60a5fa', '#93c5fd']
        };
        
        // ===== 전체 월별 추이 차트 =====
        new Chart(document.getElementById('allTrendChart'), {
    type: 'line',
    data: {
        labels: ['1월', '2월', '3월', '4월', '5월', '6월'],
        datasets: [
            {
                label: '맛레인저',
                data: [${foodMonthly}],
                borderColor: '#f97316',
                tension: 0.3
            },
            // ... 나머지 데이터셋
        ]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { position: 'bottom' }
        },
        // ⭐ Y축 설정 추가
        scales: {
            y: {
                beginAtZero: true,  // 0부터 시작
                min: 0              // 최소값 0 (마이너스 없음)
            }
        }
    }
});
        // ===== 맛레인저 차트 =====
        // Q1 차트
        new Chart(document.getElementById('foodQ1Chart'), {
            type: 'doughnut',
            data: {
                labels: ['기분 좋아', '피곤해', '스트레스', '배고파'],
                datasets: [{
                    data: [${foodQ1Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q2 차트
        new Chart(document.getElementById('foodQ2Chart'), {
            type: 'doughnut',
            data: {
                labels: ['아침', '점심', '저녁', '야식'],
                datasets: [{
                    data: [${foodQ2Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q3 차트
        new Chart(document.getElementById('foodQ3Chart'), {
            type: 'doughnut',
            data: {
                labels: ['매운맛', '담백한맛', '달콤한맛', '느끼한맛'],
                datasets: [{
                    data: [${foodQ3Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q4 차트
        new Chart(document.getElementById('foodQ4Chart'), {
            type: 'doughnut',
            data: {
                labels: ['혼자', '친구', '가족', '연인'],
                datasets: [{
                    data: [${foodQ4Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
     // ===== 드링크레인저 차트 =====
        // Q1 차트
        new Chart(document.getElementById('foodQ1Chart'), {
            type: 'doughnut',
            data: {
                labels: ['기분 좋아', '피곤해', '스트레스', '배고파'],
                datasets: [{
                    data: [${foodQ1Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q2 차트
        new Chart(document.getElementById('foodQ2Chart'), {
            type: 'doughnut',
            data: {
                labels: ['아침', '점심', '저녁', '야식'],
                datasets: [{
                    data: [${foodQ2Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q3 차트
        new Chart(document.getElementById('foodQ3Chart'), {
            type: 'doughnut',
            data: {
                labels: ['매운맛', '담백한맛', '달콤한맛', '느끼한맛'],
                datasets: [{
                    data: [${foodQ3Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q4 차트
        new Chart(document.getElementById('foodQ4Chart'), {
            type: 'doughnut',
            data: {
                labels: ['혼자', '친구', '가족', '연인'],
                datasets: [{
                    data: [${foodQ4Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
     // ===== 무비레인저 차트 =====
        // Q1 차트
        new Chart(document.getElementById('foodQ1Chart'), {
            type: 'doughnut',
            data: {
                labels: ['기분 좋아', '피곤해', '스트레스', '배고파'],
                datasets: [{
                    data: [${foodQ1Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q2 차트
        new Chart(document.getElementById('foodQ2Chart'), {
            type: 'doughnut',
            data: {
                labels: ['아침', '점심', '저녁', '야식'],
                datasets: [{
                    data: [${foodQ2Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q3 차트
        new Chart(document.getElementById('foodQ3Chart'), {
            type: 'doughnut',
            data: {
                labels: ['매운맛', '담백한맛', '달콤한맛', '느끼한맛'],
                datasets: [{
                    data: [${foodQ3Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
     // Q4 차트
        new Chart(document.getElementById('foodQ4Chart'), {
            type: 'doughnut',
            data: {
                labels: ['혼자', '친구', '가족', '연인'],
                datasets: [{
                    data: [${foodQ4Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        }); 
        
     // ===== 북레인저 차트 =====
        // Q1 차트
        new Chart(document.getElementById('foodQ1Chart'), {
            type: 'doughnut',
            data: {
                labels: ['기분 좋아', '피곤해', '스트레스', '배고파'],
                datasets: [{
                    data: [${foodQ1Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q2 차트
        new Chart(document.getElementById('foodQ2Chart'), {
            type: 'doughnut',
            data: {
                labels: ['아침', '점심', '저녁', '야식'],
                datasets: [{
                    data: [${foodQ2Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q3 차트
        new Chart(document.getElementById('foodQ3Chart'), {
            type: 'doughnut',
            data: {
                labels: ['매운맛', '담백한맛', '달콤한맛', '느끼한맛'],
                datasets: [{
                    data: [${foodQ3Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q4 차트
        new Chart(document.getElementById('foodQ4Chart'), {
            type: 'doughnut',
            data: {
                labels: ['혼자', '친구', '가족', '연인'],
                datasets: [{
                    data: [${foodQ4Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        
        
        
     // ===== 뮤직레인저 차트 =====
        // Q1 차트
        new Chart(document.getElementById('foodQ1Chart'), {
            type: 'doughnut',
            data: {
                labels: ['기분 좋아', '피곤해', '스트레스', '배고파'],
                datasets: [{
                    data: [${foodQ1Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q2 차트
        new Chart(document.getElementById('foodQ2Chart'), {
            type: 'doughnut',
            data: {
                labels: ['아침', '점심', '저녁', '야식'],
                datasets: [{
                    data: [${foodQ2Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q3 차트
        new Chart(document.getElementById('foodQ3Chart'), {
            type: 'doughnut',
            data: {
                labels: ['매운맛', '담백한맛', '달콤한맛', '느끼한맛'],
                datasets: [{
                    data: [${foodQ3Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
        // Q4 차트
        new Chart(document.getElementById('foodQ4Chart'), {
            type: 'doughnut',
            data: {
                labels: ['혼자', '친구', '가족', '연인'],
                datasets: [{
                    data: [${foodQ4Data}],
                    backgroundColor: colors.food
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { position: 'bottom' } }
            }
        });
        
     // ===== 맛레인저 월별 추이 =====
        new Chart(document.getElementById('foodTrendChart'), {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '사용 횟수',
                    data: [${foodMonthlyDetail}],
                    backgroundColor: '#f97316'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, min: 0 }
                }
            }
        });

        // ===== 드링크레인저 월별 추이 =====
        new Chart(document.getElementById('drinkTrendChart'), {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '사용 횟수',
                    data: [${drinkMonthlyDetail}],
                    backgroundColor: '#eab308'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, min: 0 }
                }
            }
        });

        // ===== 무비레인저 월별 추이 =====
        new Chart(document.getElementById('movieTrendChart'), {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '사용 횟수',
                    data: [${movieMonthlyDetail}],
                    backgroundColor: '#a855f7'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, min: 0 }
                }
            }
        });

        // ===== 북레인저 월별 추이 =====
        new Chart(document.getElementById('bookTrendChart'), {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '사용 횟수',
                    data: [${bookMonthlyDetail}],
                    backgroundColor: '#22c55e'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, min: 0 }
                }
            }
        });

        // ===== 뮤직레인저 월별 추이 =====
        new Chart(document.getElementById('musicTrendChart'), {
            type: 'bar',
            data: {
                labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                datasets: [{
                    label: '사용 횟수',
                    data: [${musicMonthlyDetail}],
                    backgroundColor: '#3b82f6'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, min: 0 }
                }
            }
        });
    </script>
</body>
</html>