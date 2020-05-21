package team2.couponMember.db;

public class CouponMemberDTO {
	
	private int num;
	private String id;
	private int co_num;
	private String used;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCo_num() {
		return co_num;
	}
	public void setCo_num(int co_num) {
		this.co_num = co_num;
	}
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	
	@Override
	public String toString() {
		return "CouponMemberDTO [num=" + num + ", id=" + id + ", co_num=" + co_num + ", used=" + used + "]";
	}

}
