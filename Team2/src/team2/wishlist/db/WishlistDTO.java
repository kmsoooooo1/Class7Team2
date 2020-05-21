package team2.wishlist.db;

public class WishlistDTO {
	private int w_num;
	private String id;
	private String w_code;
	
	public int getW_num() {
		return w_num;
	}
	public void setW_num(int w_num) {
		this.w_num = w_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getW_code() {
		return w_code;
	}
	public void setW_code(String w_code) {
		this.w_code = w_code;
	}
	
	@Override
	public String toString() {
		return "WishlistDTO [w_num=" + w_num + ", id=" + id + ", w_code=" + w_code + "]";
	}
	
	
}
