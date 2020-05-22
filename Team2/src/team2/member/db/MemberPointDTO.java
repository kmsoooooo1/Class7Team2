package team2.member.db;

import java.util.Date;

public class MemberPointDTO {
	
	private String id;
	private int point;
	private String point_description;
	private Date date;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getPoint_description() {
		return point_description;
	}
	public void setPoint_description(String point_description) {
		this.point_description = point_description;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "MemberPointDTO [id=" + id + ", point=" + point + ", point_description=" + point_description + ", date="
				+ date + "]";
	}

}
