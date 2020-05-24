package team2.board.action;

import java.util.Arrays;

public class cSet {

	public static final String[] Category = {"Notice","Review","QnA","All"};
	public static final String[] ANIMAL = {"파충류","양서류"};
	public static final String[] ANIMAL_R = {"도마뱀", "뱀", "거북"};
	public static final String[] ANIMAL_A = {"프로그", "살라맨더", "팩맨"};
	public static final String[] GOODS = {"먹이","사육용품"};
	public static final String[] GOODS_F = {"생먹이", "냉동먹이", "인공사료", "칼슘/약품"};
	public static final String[] GOODS_B = {"사육장","수족관", "장식/그릇", "램프", "바닥재", "온/습도 관련", "보조용품"};
	
	
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
	
	public String getPCate(String category, int idx){
		String result = null;
		
		if(category.equals("ANIMAL")){
			result = ANIMAL[idx];
		}else if(category.equals("ANIMAL_R")){
			result = ANIMAL_R[idx];
		}else if(category.equals("ANIMAL_A")){
			result = ANIMAL_A[idx];
		}else if(category.equals("GOODS")){
			result = GOODS[idx];
		}
		
		return result;
	}

	@Override
	public String toString() {
		return "Selected Now : cSet [Category=" + Category[c] + "]";
	}

}
