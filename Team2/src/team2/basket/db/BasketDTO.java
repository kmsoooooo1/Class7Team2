package team2.basket.db;

public class BasketDTO {
	private int b_num;
	private String id;
	private String b_code;
	private int b_amount;
	private String b_option;
	private String b_delivery_method;
	
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
	public String getB_delivery_method() {
		return b_delivery_method;
	}
	public void setB_delivery_method(String b_delivery_method) {
		this.b_delivery_method = b_delivery_method;
	}
	
	@Override
	public String toString() {
		return "BasketDTO [b_num=" + b_num + ", id=" + id + ", b_code=" + b_code + ", b_amount=" + b_amount
				+ ", b_option=" + b_option + ", b_delivery_method=" + b_delivery_method + "]";
	}
}
