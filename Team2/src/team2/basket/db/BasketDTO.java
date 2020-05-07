package team2.basket.db;

public class BasketDTO {
	private int b_num;
	private String id;
	private String b_code;
	private int b_amount;
	private String b_option;
	private int b_a_num;
	private int b_g_num;
	
	public int getB_a_num() {
		return b_a_num;
	}
	public void setB_a_num(int b_a_num) {
		this.b_a_num = b_a_num;
	}
	public int getB_g_num() {
		return b_g_num;
	}
	public void setB_g_num(int b_g_num) {
		this.b_g_num = b_g_num;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getB_code() {
		return b_code;
	}
	public void setB_code(String b_code) {
		this.b_code = b_code;
	}
	public int getB_amount() {
		return b_amount;
	}
	public void setB_amount(int b_amount) {
		this.b_amount = b_amount;
	}
	public String getB_option() {
		return b_option;
	}
	public void setB_option(String b_option) {
		this.b_option = b_option;
	}
	@Override
	public String toString() {
		return "BasketDTO [b_num=" + b_num + ", id=" + id + ", b_code=" + b_code + ", b_amount=" + b_amount
				+ ", b_option=" + b_option + ", b_a_num=" + b_a_num + ", b_g_num=" + b_g_num + ", getB_a_num()="
				+ getB_a_num() + ", getB_g_num()=" + getB_g_num() + ", getB_num()=" + getB_num() + ", getId()="
				+ getId() + ", getB_code()=" + getB_code() + ", getB_amount()=" + getB_amount() + ", getB_option()="
				+ getB_option() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
	
	
}
