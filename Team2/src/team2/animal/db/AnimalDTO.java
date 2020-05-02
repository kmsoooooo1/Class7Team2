package team2.animal.db;

import java.sql.Date;

public class AnimalDTO {
	
	private int num;
	private String category;
	private String sub_category;
	private String sub_category_index;
	private String a_morph;
	private String a_sex;
	private String a_status;
	private String a_code;
	private String a_thumbnail;
	private int a_amount;
	private int a_price_origin;
	private int a_discount_rate;
	private int a_price_sale;
	private int a_mileage;
	private String content;
	private int a_view_count;
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
	public String getA_morph() {
		return a_morph;
	}
	public void setA_morph(String a_morph) {
		this.a_morph = a_morph;
	}
	public String getA_sex() {
		return a_sex;
	}
	public void setA_sex(String a_sex) {
		this.a_sex = a_sex;
	}
	public String getA_status() {
		return a_status;
	}
	public void setA_status(String a_status) {
		this.a_status = a_status;
	}
	public String getA_code() {
		return a_code;
	}
	public void setA_code(String a_code) {
		this.a_code = a_code;
	}
	public String getA_thumbnail() {
		return a_thumbnail;
	}
	public void setA_thumbnail(String a_thumbnail) {
		this.a_thumbnail = a_thumbnail;
	}
	public int getA_amount() {
		return a_amount;
	}
	public void setA_amount(int a_amount) {
		this.a_amount = a_amount;
	}
	public int getA_price_origin() {
		return a_price_origin;
	}
	public void setA_price_origin(int a_price_origin) {
		this.a_price_origin = a_price_origin;
	}
	public int getA_discount_rate() {
		return a_discount_rate;
	}
	public void setA_discount_rate(int a_discount_rate) {
		this.a_discount_rate = a_discount_rate;
	}
	public int getA_price_sale() {
		return a_price_sale;
	}
	public void setA_price_sale(int a_price_sale) {
		this.a_price_sale = a_price_sale;
	}
	public int getA_mileage() {
		return a_mileage;
	}
	public void setA_mileage(int a_mileage) {
		this.a_mileage = a_mileage;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getA_view_count() {
		return a_view_count;
	}
	public void setA_view_count(int a_view_count) {
		this.a_view_count = a_view_count;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "AnimalDTO [num=" + num + ", category=" + category + ", sub_category=" + sub_category
				+ ", sub_category_index=" + sub_category_index + ", a_morph=" + a_morph + ", a_sex=" + a_sex
				+ ", a_status=" + a_status + ", a_code=" + a_code + ", a_thumbnail=" + a_thumbnail + ", a_amount="
				+ a_amount + ", a_price_origin=" + a_price_origin + ", a_discount_rate=" + a_discount_rate
				+ ", a_price_sale=" + a_price_sale + ", a_mileage=" + a_mileage + ", content=" + content
				+ ", a_view_count=" + a_view_count + ", date=" + date + "]";
	}

}
