package team2.board.db;

import java.util.Date;

public class BoardDTO {

	private int b_idx;
	private String b_category;
	private String b_p_cate;
	private String b_title;
	private String b_writer;
	private String b_content;
	private int b_ref;
	private int b_like;
	private int b_view;
	private Date b_reg_date;
	private String ip_addr;
	private String b_file;
	
	public BoardDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public BoardDTO(int b_idx, String b_category, String b_p_cate, String b_title, String b_writer, String b_content,
			int b_ref, int b_like, int b_view, Date b_reg_date, String ip_addr, String b_file) {
		super();
		this.b_idx = b_idx;
		this.b_category = b_category;
		this.b_p_cate = b_p_cate;
		this.b_title = b_title;
		this.b_writer = b_writer;
		this.b_content = b_content;
		this.b_ref = b_ref;
		this.b_like = b_like;
		this.b_view = b_view;
		this.b_reg_date = b_reg_date;
		this.ip_addr = ip_addr;
		this.b_file = b_file;
	}


	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public String getB_category() {
		return b_category;
	}
	public void setB_category(String b_category) {
		this.b_category = b_category;
	}
	public String getB_p_cate() {
		return b_p_cate;
	}
	public void setB_p_cate(String b_p_cate) {
		this.b_p_cate = b_p_cate;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_writer() {
		return b_writer;
	}
	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public int getB_ref() {
		return b_ref;
	}
	public void setB_ref(int b_ref) {
		this.b_ref = b_ref;
	}
	public int getB_like() {
		return b_like;
	}
	public void setB_like(int b_like) {
		this.b_like = b_like;
	}
	public int getB_view() {
		return b_view;
	}
	public void setB_view(int b_view) {
		this.b_view = b_view;
	}
	public Date getB_reg_date() {
		return b_reg_date;
	}
	public void setB_reg_date(Date b_reg_date) {
		this.b_reg_date = b_reg_date;
	}
	public String getIp_addr() {
		return ip_addr;
	}
	public void setIp_addr(String ip_addr) {
		this.ip_addr = ip_addr;
	}
	public String getB_file() {
		return b_file;
	}
	public void setB_file(String b_file) {
		this.b_file = b_file;
	}
	@Override
	public String toString() {
		return "BoardDTO [b_idx=" + b_idx + ", b_category=" + b_category + ", b_p_cate=" + b_p_cate + ", b_title="
				+ b_title + ", b_writer=" + b_writer + ", b_content=" + b_content + ", b_ref=" + b_ref + ", b_like="
				+ b_like + ", b_view=" + b_view + ", b_reg_date=" + b_reg_date + ", ip_addr=" + ip_addr + ", b_file="
				+ b_file + "]";
	}
}
