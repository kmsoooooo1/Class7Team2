package team2.animal.action;

import java.util.Arrays;

public class aSet {
	
	public static final String[] Category = {"파충류","양서류"};
	public static final String[] sub_Category = {"도마뱀", "뱀", "거북"};
	public static final String[] sub_Category_index = {"프로그", "살라맨더", "팩맨"};

	private String category;
	private String sub_category;
	private String sub_category_index;
	
	public aSet() {
		this.category = "파충류";
		this.sub_category = "도마뱀";
		this.sub_category_index = "프로그";
	}
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSub_category() {
		return sub_category;
	}
	public void setSub_category(String sub_category) {
		this.sub_category = sub_category;
	}
	public String getSub_category_index() {
		return sub_category_index;
	}
	public void setSub_category_index(String sub_category_index) {
		this.sub_category_index = sub_category_index;
	}
	
	@Override
	public String toString() {
		return "aSet [category=" + category + ", sub_category=" + sub_category + ", sub_category_index="
				+ sub_category_index + "]";
	}

}
