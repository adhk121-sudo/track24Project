package dto;

public class ProjectDto {
	private String id, name, pw, pw_length, age, area,
	mobile_1, mobile_2, mobile_3, email_1, email_2,
	gender, mbti, style, food, drink, music, movie, book, allergy, reg_date, update_date;

	
	
	public ProjectDto(String style, String food, String drink, String music, String movie, String book,
			String allergy) {
		super();
		this.style = style;
		this.food = food;
		this.drink = drink;
		this.music = music;
		this.movie = movie;
		this.book = book;
		this.allergy = allergy;
	}

	public ProjectDto(String id, String name, String style) {
		super();
		this.id = id;
		this.name = name;
		this.style = style;
	}

	public ProjectDto(String id, String name, String pw, String pw_length, String age, String area, String mobile_1,
			String mobile_2, String mobile_3, String email_1, String email_2, String gender, String mbti, String style,
			String food, String drink, String music, String movie, String book, String allergy, String reg_date, String update_date) {
		super();
		this.id = id;
		this.name = name;
		this.pw = pw;
		this.pw_length = pw_length;
		this.age = age;
		this.area = area;
		this.mobile_1 = mobile_1;
		this.mobile_2 = mobile_2;
		this.mobile_3 = mobile_3;
		this.email_1 = email_1;
		this.email_2 = email_2;
		this.gender = gender;
		this.mbti = mbti;
		this.style = style;
		this.food = food;
		this.drink = drink;
		this.music = music;
		this.movie = movie;
		this.book = book;
		this.allergy = allergy;
		this.reg_date = reg_date;
		this.update_date = update_date;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getPw() {
		return pw;
	}

	public String getPw_length() {
		return pw_length;
	}

	public String getAge() {
		return age;
	}

	public String getArea() {
		return area;
	}

	public String getMobile_1() {
		return mobile_1;
	}

	public String getMobile_2() {
		return mobile_2;
	}

	public String getMobile_3() {
		return mobile_3;
	}

	public String getEmail_1() {
		return email_1;
	}

	public String getEmail_2() {
		return email_2;
	}

	public String getGender() {
		return gender;
	}

	public String getMbti() {
		return mbti;
	}

	public String getStyle() {
		return style;
	}

	public String getFood() {
		return food;
	}

	public String getDrink() {
		return drink;
	}

	public String getMusic() {
		return music;
	}

	public String getMovie() {
		return movie;
	}

	public String getBook() {
		return book;
	}

	public String getAllergy() {
		return allergy;
	}

	public String getReg_date() {
		return reg_date;
	}

	public String getUpdate_date() {
		return update_date;
	}
	
	
}
