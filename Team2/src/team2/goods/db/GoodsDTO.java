package team2.goods.db;

import java.sql.Date;

public class GoodsDTO {
	private int num;
	private String category;
	private String sub_category;
	private String sub_category_index;
	private String g_name;
	private String g_code;
	private String g_thumbnail;
	private int g_amount;
	private int g_price_origin;
	private int g_discount_rate;
	private int g_price_sale;
	private int g_mileage;
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
	public String getG_thumbnail() {
		return g_thumbnail;
	}
	public void setG_thumbnail(String g_thumbnail) {
		this.g_thumbnail = g_thumbnail;
	}
	public int getG_amount() {
		return g_amount;
	}
	public void setG_amount(int g_amount) {
		this.g_amount = g_amount;
	}
	public int getG_price_origin() {
		return g_price_origin;
	}
	public void setG_price_origin(int g_price_origin) {
		this.g_price_origin = g_price_origin;
	}
	public int getG_discount_rate() {
		return g_discount_rate;
	}
	public void setG_discount_rate(int g_discount_rate) {
		this.g_discount_rate = g_discount_rate;
	}
	public int getG_price_sale() {
		return g_price_sale;
	}
	public void setG_price_sale(int g_price_sale) {
		this.g_price_sale = g_price_sale;
	}
	public int getG_mileage() {
		return g_mileage;
	}
	public void setG_mileage(int g_mileage) {
		this.g_mileage = g_mileage;
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
				+ ", sub_category_index=" + sub_category_index + ", g_name=" + g_name + ", g_code=" + g_code
				+ ", g_thumbnail=" + g_thumbnail + ", g_amount=" + g_amount + ", g_price_origin=" + g_price_origin
				+ ", g_discount_rate=" + g_discount_rate + ", g_price_sale=" + g_price_sale + ", g_mileage=" + g_mileage
				+ ", content=" + content + ", g_view_count=" + g_view_count + ", date=" + date + "]";
	}
	
	
	
	
	
	
}
