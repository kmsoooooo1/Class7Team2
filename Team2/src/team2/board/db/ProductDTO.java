package team2.board.db;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;
import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class ProductDTO {
	
	private String p_code;
	private String category;
	private String sub_category;
	private String sub_category_idx;
	private String name;
	private String img_src;
	
	
	public String getP_code() {
		return p_code;
	}

	public void setP_code(String p_code) {
		this.p_code = p_code;
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

	public String getSub_category_idx() {
		return sub_category_idx;
	}

	public void setSub_category_idx(String sub_category_idx) {
		this.sub_category_idx = sub_category_idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImg_src() {
		return img_src;
	}

	public void setImg_src(String img_src) {
		this.img_src = img_src;
	}

	public ProductDTO(String p_code) {
		// TODO Auto-generated constructor stub
		this.p_code = p_code;
		getProduct(p_code);
	}
	
	private void getProduct(String p_code){
		char c = p_code.charAt(0);
		System.out.println("c : " + c);
		if(c=='a'){
			System.out.println("Animals 검색");
			AnimalDAO dao = new AnimalDAO();
			AnimalDTO dto = dao.getAnimalDetail(p_code);
			dao.closeDB();
			if(dto!=null){
				this.category = dto.getCategory();
				this.sub_category = dto.getSub_category();
				this.sub_category_idx = dto.getSub_category_index();
				this.name = dto.getA_morph();
				this.img_src = dto.getA_thumbnail();
			}
		}else if(c=='g'){
			System.out.println("Goods 검색");
			GoodsDAO dao = new GoodsDAO();
			GoodsDTO dto = dao.getGoodsDetail(p_code);
			dao.closeDB();
			if(dto!=null){
				this.category = dto.getCategory();
				this.sub_category = dto.getSub_category();
				this.sub_category_idx = dto.getSub_category_index();
				this.name = dto.getG_name();
				this.img_src = dto.getG_thumbnail();
			}
		}
	}

	@Override
	public String toString() {
		return "ProductDTO [p_code=" + p_code + ", category=" + category + ", sub_category=" + sub_category
				+ ", sub_category_idx=" + sub_category_idx + ", name=" + name + ", img_src=" + img_src + "]";
	}
	
	
}
