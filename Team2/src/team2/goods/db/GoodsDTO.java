package team2.goods.db;

import java.sql.Date;

public class GoodsDTO {
	private int num;
	private String category;
	private String sub_category;
	private String sub_category_index;
	private String g_name;
	private String g_code;
	private String g_image;
	private int g_amount;
	private int g_price;
	private String content;
	private int g_view_count;
	private Date date;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSub_category() {
		return sub_category;
	}
	public void setSub_category(String sub_category) {
		this.sub_category = sub_category;
	}
	public String getSub_category_index() {
		return sub_category_index;
	}
	public void setSub_category_index(String sub_category_index) {
		this.sub_category_index = sub_category_index;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public String getG_code() {
		return g_code;
	}
	public void setG_code(String g_code) {
		this.g_code = g_code;
	}
	public String getG_image() {
		return g_image;
	}
	public void setG_image(String g_image) {
		this.g_image = g_image;
	}
	public int getG_amount() {
		return g_amount;
	}
	public void setG_amount(int g_amount) {
		this.g_amount = g_amount;
	}
	public int getG_price() {
		return g_price;
	}
	public void setG_price(int g_price) {
		this.g_price = g_price;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getG_view_count() {
		return g_view_count;
	}
	public void setG_view_count(int g_view_count) {
		this.g_view_count = g_view_count;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "GoodsDTO [num=" + num + ", category=" + category + ", sub_category=" + sub_category
				+ ", sub_category_index=" + sub_category_index + ", g_name=" + g_name + ", g_code=" + g_code + ", g_image=" + g_image
				+ ", g_amount=" + g_amount + ", g_price=" + g_price + ", content=" + content + ", g_view_count="
				+ g_view_count + ", date=" + date + "]";
	}
	
	
	
	
	
	
}
