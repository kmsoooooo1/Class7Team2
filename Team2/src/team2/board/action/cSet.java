package team2.board.action;

import java.util.ArrayList;
import java.util.Arrays;

public class cSet {

	public static final String[] Category = {"Notice","Review","QnA"};
	
	//	Category index
	private int c;

	// Category별 index 문자 변환
	private String category;

	// Category 초기값 지정
	public cSet() {
		this.c = 0;
		StrDate();
	}

	public cSet(int c, int pc) {
		super();
		this.c = c;
	}
	
	// Category별 index 문자열 변환
	private void StrDate() {
		this.category = Category[c];
	}
	
	//문자열로 받은 카테고리 int로 선언
	private void IntDate(String a) {
		this.c = Arrays.asList(Category).indexOf(a);
	}
	
	public int getC() {
		return c;
	}

	public void setC(int c) {
		this.c = c;
		StrDate();
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
		IntDate(category);
	}

	@Override
	public String toString() {
		return "Selected Now : cSet [Category=" + Category[c] + "]";
	}

}
