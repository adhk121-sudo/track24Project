package dto;

/**
 * 추천 결과 이력 DTO
 * - 결과이력 페이지에서 분야별 최근 3개 표시용
 */
public class HistoryDto {
    private int historyId;
    private String category;
    private String title;     // 음식/음료/영화/책/노래 이름
    private String mainName;  // 식당/카페/감독/저자/가수
    private String genre;
    private String reason;
    private String regDate;   // yyyy-MM-dd

    public HistoryDto() {}

    
    
    
    public HistoryDto(int historyId, String category, String title, String mainName) {
		super();
		this.historyId = historyId;
		this.category = category;
		this.title = title;
		this.mainName = mainName;
	}




	public HistoryDto(int historyId, String category, String title, String mainName,
                      String genre, String reason, String regDate) {
        this.historyId = historyId;
        this.category = category;
        this.title = title;
        this.mainName = mainName;
        this.genre = genre;
        this.reason = reason;
        this.regDate = regDate;
    }

    public int getHistoryId() { return historyId; }
    public void setHistoryId(int historyId) { this.historyId = historyId; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getMainName() { return mainName; }
    public void setMainName(String mainName) { this.mainName = mainName; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }
}
