package team2.board.action;

public class cSet {

	public static final String[] Category = {"Notice","Review","QnA"};
	public static final String[] p_Category = {"파충류","세부카테2","세부카테3","세부카테4"};
	
	//	Category index
	private int c;
	
	//	p_Category index
	private int pc;
	
	public cSet() {}

	public cSet(int c, int pc) {
		super();
		this.c = c;
		this.pc = pc;
	}

	public int getC() {
		return c;
	}

	public void setC(int c) {
		this.c = c;
	}

	public int getPc() {
		return pc;
	}

	public void setPc(int pc) {
		this.pc = pc;
	}

	@Override
	public String toString() {
		return "Selected Now : cSet [Category=" + Category[c] + ", p_Category=" + p_Category[pc] + "]";
	}

}
