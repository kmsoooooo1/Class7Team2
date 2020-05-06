package team2.board.db;

import java.sql.Timestamp;

public class CommentDTO {
	
	private int c_idx;
	private int c_b_idx;
	private String c_id;
	private String c_comment;
	private int c_like;
	private Timestamp c_regdate;
	private String ip_addr;
	
	public CommentDTO() {}
	
	public CommentDTO(int c_idx, int c_content_idx, String c_id, String c_comment, int c_like,
			Timestamp c_regdate, String ip_addr) {
		super();
		this.c_idx = c_idx;
		this.c_b_idx = c_content_idx;
		this.c_id = c_id;
		this.c_comment = c_comment;
		this.c_like = c_like;
		this.c_regdate = c_regdate;
		this.ip_addr = ip_addr;
	}
	
	
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public int getC_b_idx() {
		return c_b_idx;
	}
	public void setC_b_idx(int c_content_idx) {
		this.c_b_idx = c_content_idx;
	}
	public String getC_id() {
		return c_id;
	}
	public void setC_id(String c_id) {
		this.c_id = c_id;
	}
	public String getC_comment() {
		return c_comment;
	}
	public void setC_comment(String c_comment) {
		this.c_comment = c_comment;
	}
	public int getC_like() {
		return c_like;
	}
	public void setC_like(int c_like) {
		this.c_like = c_like;
	}
	public Timestamp getC_regdate() {
		return c_regdate;
	}
	public void setC_regdate(Timestamp c_regdate) {
		this.c_regdate = c_regdate;
	}
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}
	@Override
	public String toString() {
		return "CommentDTO [c_idx=" + c_idx + ", c_b_idx=" + c_b_idx
				+ ", c_id=" + c_id + ", c_comment=" + c_comment + ", c_like=" + c_like + ", c_regdate=" + c_regdate
				+ ", ip_addr=" + ip_addr + "]";
	}

}
