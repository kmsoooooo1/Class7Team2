package team2.coupon.db;

public class CouponDTO {
	
	private int num;
	private String co_target;
	private String co_name;
	private String co_rate;
	private String co_startDate;
	private String co_endDate;
	private String co_status;
	private String co_image;
	
	private String used;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCo_target() {
		return co_target;
	}
	public void setCo_target(String co_target) {
		this.co_target = co_target;
	}
	public String getCo_name() {
		return co_name;
	}
	public void setCo_name(String co_name) {
		this.co_name = co_name;
	}
	public String getCo_rate() {
		return co_rate;
	}
	public void setCo_rate(String co_rate) {
		this.co_rate = co_rate;
	}
	public String getCo_startDate() {
		return co_startDate;
	}
	public void setCo_startDate(String co_startDate) {
		this.co_startDate = co_startDate;
	}
	public String getCo_endDate() {
		return co_endDate;
	}
	public void setCo_endDate(String co_endDate) {
		this.co_endDate = co_endDate;
	}
	public String getCo_status() {
		return co_status;
	}
	public void setCo_status(String co_status) {
		this.co_status = co_status;
	}
	public String getCo_image() {
		return co_image;
	}
	public void setCo_image(String co_image) {
		this.co_image = co_image;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	
}
