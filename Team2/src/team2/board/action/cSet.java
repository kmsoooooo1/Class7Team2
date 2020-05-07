package team2.board.action;

import java.util.ArrayList;
import java.util.Arrays;

public class cSet {

	public static final String[] Category = {"Notice","Review","QnA"};
	public static final String[] p_Category = {"해당없음","파충류","세부카테2","세부카테3","세부카테4"};
	
	//	Category index
	private int c;
	
	//	p_Category index
	private int pc;

	// Category별 index 문자 변환
	private String category;
	private String p_category;

	// Category 초기값 지정
	public cSet() {
		this.c = 0;
		this.pc = 0;
		StrDate();
	}

	public cSet(int c, int pc) {
		super();
		this.c = c;
		this.pc = pc;
	}
	
	// Category별 index 문자열 변환
	private void StrDate() {
		this.category = Category[c];
		this.p_category = p_Category[pc];
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

	public int getPc() {
		return pc;
	}

	public void setPc(int pc) {
		this.pc = pc;
		StrDate();
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
		IntDate(category);
	}

	public String getP_category() {
		return p_category;
	}

	public void setP_category(String p_category) {
		this.p_category = p_category;
	}
	@Override
	public String toString() {
		return "Selected Now : cSet [Category=" + Category[c] + ", p_Category=" + p_Category[pc] + "]";
	}

}
