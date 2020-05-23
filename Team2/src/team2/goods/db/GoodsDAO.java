package team2.goods.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.board.action.Criteria;
import team2.board.db.ProductDTO;

public class GoodsDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	Statement stmt;
	ResultSet rs = null;
	String sql = "";
	
	// 디비 연결(커넥션 풀 사용)
	private Connection getConnection() throws Exception {
		// Context 객체를 생성
		Context init = new InitialContext();

		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/team2");

		con = ds.getConnection();
		
		System.out.println(" 디비 연결 완료 : "+con);
		return con;
	}

	// 자원 해제
	public void closeDB() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
			if(stmt!=null)stmt.close();
			System.out.println(" 자원해제 완료 ");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//////////////////////////////////////////////////////////////////////
	
	//insertGoods(gdto); 관리자
	public void insertGoods(GoodsDTO gdto){
		int num = 0;
		
		try {
			con = getConnection();
			
			// sql
			// num(상품번호) 계산
			sql = "SELECT max(num) FROM team2_goods";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			
			// ? 추가
			sql = "INSERT INTO team2_goods VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, gdto.getCategory());
			pstmt.setString(3, gdto.getSub_category());
			pstmt.setString(4, gdto.getSub_category_index());
			pstmt.setString(5, gdto.getG_name());
			pstmt.setString(6, gdto.getG_code());
			pstmt.setString(7, gdto.getG_thumbnail());
			pstmt.setInt(8, gdto.getG_amount());
			pstmt.setInt(9, gdto.getG_price_origin());
			pstmt.setInt(10, gdto.getG_discount_rate());
			pstmt.setInt(11, gdto.getG_price_sale());
			pstmt.setInt(12, gdto.getG_mileage());
			pstmt.setString(13, gdto.getG_delivery());
			pstmt.setString(14, gdto.getG_option());
			pstmt.setInt(15, gdto.getG_option_price());
			pstmt.setString(16, gdto.getContent());
			pstmt.setInt(17, 0);
			
			// 실행
			pstmt.executeUpdate();
			
			System.out.println("상품 등록 성공");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("상품 등록 실패");
		}finally{
			closeDB();
		}//자원반납
	}//insertGoods(gdto);
	
	//getGoodsList(); 관리자
	public List<GoodsDTO> getGoodsList(){
		
		List<GoodsDTO> goodsList = new ArrayList<GoodsDTO>();
		
		try {
			con = getConnection();
			
			sql="SELECT * FROM team2_goods order by num desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				GoodsDTO gdto = new GoodsDTO();
				gdto.setNum(rs.getInt("num"));
				gdto.setCategory(rs.getString("category"));
				gdto.setSub_category(rs.getString("sub_category"));
				gdto.setSub_category_index(rs.getString("sub_category_index"));
				gdto.setG_name(rs.getString("g_name"));
				gdto.setG_code(rs.getString("g_code"));
				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
				gdto.setG_amount(rs.getInt("g_amount"));
				gdto.setG_price_origin(rs.getInt("g_price_origin"));
				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
				gdto.setG_price_sale(rs.getInt("g_price_sale"));
				gdto.setG_mileage(rs.getInt("g_mileage"));
				gdto.setG_delivery(rs.getString("g_delivery"));
				gdto.setG_option(rs.getString("g_option"));
				gdto.setG_option_price(rs.getInt("g_option_price"));
				gdto.setContent(rs.getString("content"));
				gdto.setG_view_count(rs.getInt("g_view_count"));
				gdto.setDate(rs.getDate("date"));
				
				goodsList.add(gdto);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return goodsList;
	}//getGoodsList();
	
	//getGoods(num); 관리자
	public GoodsDTO getGoods(int num){
		
		GoodsDTO gdto = null;
		
		try {
			con = getConnection();
			
			sql = "SELECT * FROM team2_goods WHERE num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				gdto = new GoodsDTO();
				
				gdto.setCategory(rs.getString("category"));
				gdto.setContent(rs.getString("content"));
				gdto.setDate(rs.getDate("date"));
				gdto.setG_amount(rs.getInt("g_amount"));
				gdto.setG_code(rs.getString("g_code"));
				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
				gdto.setG_mileage(rs.getInt("g_mileage"));
				gdto.setG_name(rs.getString("g_name"));
				gdto.setG_price_origin(rs.getInt("g_price_origin"));
				gdto.setG_price_sale(rs.getInt("g_price_sale"));
				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
				gdto.setG_view_count(rs.getInt("g_view_count"));
				gdto.setNum(rs.getInt("num"));
				gdto.setSub_category(rs.getString("sub_category"));
				gdto.setSub_category_index(rs.getString("sub_category_index"));
				gdto.setG_delivery(rs.getString("g_delivery"));
				gdto.setG_option(rs.getString("g_option"));
				gdto.setG_option_price(rs.getInt("g_option_price"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return gdto;
	}//getGoods(num);
	
	//modifyGoods(gdto); 관리자
	public void modifyGoods(GoodsDTO gdto){
		// 상품정보 수정
		
		try {
			con = getConnection();
			
			sql="UPDATE team2_goods SET "
					+ "category=?,sub_category=?,sub_category_index=?,g_name=?,g_code=?,g_thumbnail=?,g_amount=?,g_price_origin=?,"
					+ "g_discount_rate=?,g_price_sale=?,g_mileage=?,g_delivery=?,g_option=?,g_option_price=?,content=? "
					+ "WHERE num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, gdto.getCategory());
			pstmt.setString(2, gdto.getSub_category());
			pstmt.setString(3, gdto.getSub_category_index());
			pstmt.setString(4, gdto.getG_name());
			pstmt.setString(5, gdto.getG_code());
			pstmt.setString(6, gdto.getG_thumbnail());
			pstmt.setInt(7, gdto.getG_amount());
			pstmt.setInt(8, gdto.getG_price_origin());
			pstmt.setInt(9, gdto.getG_discount_rate());
			pstmt.setInt(10, gdto.getG_price_sale());
			pstmt.setInt(11, gdto.getG_mileage());
			pstmt.setString(12, gdto.getG_delivery());
			pstmt.setString(13, gdto.getG_option());
			pstmt.setInt(14, gdto.getG_option_price());
			pstmt.setString(15, gdto.getContent());
			pstmt.setInt(16, gdto.getNum());
			
			pstmt.executeUpdate();
			
			System.out.println("상품 정보 수정 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
	}//modifyGoods(gdto);
	
	//deleteGoods(num) 관리자
	public void deleteGoods(int num){
		try {
			con = getConnection();
			
			sql="DELETE FROM team2_goods WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println(num+"번 상품 삭제 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}//deleteGoods(num)
	
//	//AdminGoodsPage(cri)
//	public List<GoodsDTO> AdminGoodsPage(String category, Criteria cri){
//		
//		List<GoodsDTO> list = new ArrayList<>();
//		
//		try {
//			con = getConnection();
//			
//			sql="select * from team2_goods where category ='" +category+ "' order by num desc limit " + cri.getPageStart() + ", " + cri.getPerpageNum();
//			
//			pstmt = con.prepareStatement(sql);
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()){
//				GoodsDTO gdto = new GoodsDTO();
//				
//				gdto.setCategory(rs.getString("category"));
//				gdto.setContent(rs.getString("content"));
//				gdto.setDate(rs.getDate("date"));
//				gdto.setG_amount(rs.getInt("g_amount"));
//				gdto.setG_code(rs.getString("g_code"));
//				gdto.setG_delivery(rs.getString("g_delivery"));
//				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
//				gdto.setG_mileage(rs.getInt("g_mileage"));
//				gdto.setG_name(rs.getString("g_name"));
//				gdto.setG_option(rs.getString("g_option"));
//				gdto.setG_option_price(rs.getInt("g_option_price"));
//				gdto.setG_price_origin(rs.getInt("g_price_origin"));
//				gdto.setG_price_sale(rs.getInt("g_price_sale"));
//				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
//				gdto.setG_view_count(rs.getInt("g_view_count"));
//				gdto.setNum(rs.getInt("num"));
//				gdto.setSub_category(rs.getString("sub_category"));
//				gdto.setSub_category_index(rs.getString("sub_category_index"));
//				
//				list.add(gdto);
//			}
//		
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally{
//			closeDB();
//		}
//		
//		return list;
//		
//	}//AdminGoodsPage(cri)
	
	
	// 관리자 제어 끝 일반사용자 제어 시작
	
	// GoodsList(category, sub_category, sub_category_index)
	public List<GoodsDTO> GoodsList(String category,String sub_category,String sub_category_index){
		List<GoodsDTO> goodsList = new ArrayList<GoodsDTO>();

		
		try {
			
			con = getConnection();

			//StringBuffer: 저장공간(메모리)
			StringBuffer SQL = new StringBuffer();
			
			//SQL buffer 안에 sql 구문 넣어주기
			
			//만약 category가 all이고 sub_category가 없고 sub_category_index도 없을때(관리자 페이지에서 상품을 부를때)
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){
				SQL.append("SELECT * FROM team2_goods order by num desc");
			}
			//만약 category가 먹이 이면
			else if(category.equals("먹이")){
				SQL.append("select category,sub_category,sub_category_index,g_code,g_thumbnail,g_price_origin,g_discount_rate,"
						+ "g_price_sale,content,date,g_mileage,g_name,g_view_count,num,g_delivery,group_concat(g_option) as g_option,"
						+ "max(g_amount) as g_amount from team2_goods where category='먹이' ");
				
				// 만약 sub_category가 없으면
				if(sub_category.equals("all")) {
					SQL.append("group by g_code order by num desc");
				}
				//만약 sub_category가 있으면
				else {
					SQL.append("AND sub_category = ? group by g_code order by num desc");
				}
			}
			// sub_category_index는 메뉴에서 다루지 않음.
			// sub_category 클릭 시 index 나오게 구현할 예정
			else if(category.equals("사육용품")){
				SQL.append("select category,sub_category,sub_category_index,g_code,g_thumbnail,g_price_origin,g_discount_rate,"
						+ "g_price_sale,content,date,g_mileage,g_name,g_view_count,num,g_delivery,group_concat(g_option) as g_option,"
						+ "max(g_amount) as g_amount from team2_goods where category='사육용품' ");
				//만약 sub_category가 없으면
				if(sub_category.equals("all")) {
					SQL.append("group by g_code order by num desc");
				}
				//만약 sub_category가 있으면
				else {
					SQL.append("AND sub_category = ? ");
					
					//만약 sub_category_index가 없으면
					if(sub_category_index.equals("all")){
						SQL.append("group by g_code order by num desc");
					}
					//만약 sub_category_index가 있으면
					else{
						SQL.append("AND sub_category_index = ? group by g_code order by num desc");
					}
				}
			}
			
			pstmt = con.prepareStatement(SQL.toString());
			
			//?에 값 지정하기
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){
			}
			else if(category.equals("먹이")){
				if(sub_category.equals("all")){
				}
				else{
					pstmt.setString(1, sub_category);
				}
			}else if(category.equals("사육용품")){
				if(sub_category.equals("all")) {
				}
				else {
					pstmt.setString(1, sub_category);
					
					if(sub_category_index.equals("all")){
					}else{
						pstmt.setString(2, sub_category_index);
					}
				}
			}
			
			System.out.println(SQL);
			
			rs = pstmt.executeQuery();
	
			
			
			// 상품이 있을때마다
			while(rs.next()){
				GoodsDTO gdto = new GoodsDTO();
				
				gdto.setCategory(rs.getString("category"));
				gdto.setContent(rs.getString("content"));
				gdto.setDate(rs.getDate("date"));
				gdto.setG_amount(rs.getInt("g_amount"));
				gdto.setG_code(rs.getString("g_code"));
				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
				gdto.setG_mileage(rs.getInt("g_mileage"));
				gdto.setG_name(rs.getString("g_name"));
				gdto.setG_price_origin(rs.getInt("g_price_origin"));
				gdto.setG_price_sale(rs.getInt("g_price_sale"));
				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
				gdto.setG_view_count(rs.getInt("g_view_count"));
				gdto.setNum(rs.getInt("num"));
				gdto.setSub_category(rs.getString("sub_category"));
				gdto.setSub_category_index(rs.getString("sub_category_index"));
				gdto.setG_delivery(rs.getString("g_delivery"));
				gdto.setG_option(rs.getString("g_option"));
				
				goodsList.add(gdto);
			}
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}finally{
			closeDB();
		}
		
		return goodsList;
	}
	// GoodsList(category, sub_category, sub_category_index)
	
	//updateGoodsViewCount(g_code)
	public void updateGoodsViewCount(String g_code){
		
		try {
			con = getConnection();
			
			sql = "UPDATE team2_goods SET g_view_count = g_view_count + 1 WHERE g_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, g_code);
			pstmt.executeUpdate();
			
			System.out.println("상품 페이지 조회수 1 증가 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}//updateGoodsViewCount(g_code)
	
	public int getG_amount(String g_code){
		int result = 0;
		
		try {
			con = getConnection();
			
			sql="select sum(g_amount) from team2_goods  where g_code = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				result = rs.getInt("sum(g_amount)");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return result;
	} 
	
	
	//getGoodsDetailList(g_code) 상품 상세정보 가져오는 함수
	public List<GoodsDTO> getGoodsDetailList(String g_code){
		List<GoodsDTO> detailList = new ArrayList<GoodsDTO>();
		
	try {
			con = getConnection();
			
			sql="select * from team2_goods where g_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				GoodsDTO gdto = new GoodsDTO();
				
				gdto = new GoodsDTO();
				// 만약 상품이 db에 있다면
				gdto.setCategory(rs.getString("category"));
				gdto.setSub_category(rs.getString("sub_category"));
				gdto.setSub_category_index(rs.getString("sub_category_index"));
				gdto.setG_name(rs.getString("g_name"));
				gdto.setG_code(rs.getString("g_code"));
				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
				gdto.setG_amount(rs.getInt("g_amount"));
				gdto.setG_price_origin(rs.getInt("g_price_origin"));
				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
				gdto.setG_price_sale(rs.getInt("g_price_sale"));
				gdto.setG_mileage(rs.getInt("g_mileage"));
				gdto.setG_delivery(rs.getString("g_delivery"));
				gdto.setG_option(rs.getString("g_option"));
				gdto.setG_option_price(rs.getInt("g_option_price"));
				gdto.setContent(rs.getString("content"));
				gdto.setG_view_count(rs.getInt("g_view_count"));
				gdto.setDate(rs.getDate("date"));
				
				detailList.add(gdto);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return detailList;
	}//getGoodsDetail(g_code)
	
	public List<ProductDTO> searchKeyword(String keyword){
		List<ProductDTO> list = new ArrayList<>();
		
		sql = "select g_code, category, sub_category, sub_category_index, g_name, g_thumbnail from team2_goods where g_name like '%" + keyword +"%'";
		ProductDTO dto = null;
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				dto = new ProductDTO(rs.getString("g_code"));
				dto.setCategory(rs.getString("category"));
				dto.setSub_category(rs.getString("sub_category"));
				dto.setSub_category_idx(rs.getString("sub_category_index"));
				dto.setName(rs.getString("g_name"));
				dto.setImg_src(rs.getString("g_thumbnail"));
				
				list.add(dto);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	
	public int getGoodsCount(String category, String sub_category, String sub_category_idx){
		
		int total = 0;
		
		sql = "select count(num) from team2_goods where category='" + category + "'";
		if(sub_category!=""){
			sql+=" and sub_category='"+sub_category+"'";
		}
		if(sub_category_idx!=""){
			sql+=" and sub_category_index='"+sub_category_idx+"'";
		}
		
		try {
			con = getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return total;
	}

	public List<GoodsDTO> GoodsPage(String category, String sub_category, String sub_category_idx, Criteria cri) {
		
		List<GoodsDTO> list = new ArrayList<>();
		
		sql = "select category,sub_category,sub_category_index,g_code,g_thumbnail,g_price_origin,g_discount_rate,"
				+ "g_price_sale,content,date,g_mileage,g_name,g_view_count,num,g_delivery,group_concat(g_option) as g_option,"
				+ "max(g_amount) as g_amount from team2_goods where category='"+category+"'";
		if(sub_category!=""){
			sql+=" and sub_category='"+sub_category+"'";
		}
		if(sub_category_idx!=""){
			sql+=" and sub_category_index='"+sub_category_idx+"'";
		}
		sql+=" group by g_code order by num desc limit " + cri.getPageStart() + ", " + cri.getPerpageNum();
		
		try {
			
			System.out.println(sql);
			con = getConnection();
		
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
		
		
			while(rs.next()){
				GoodsDTO gdto = new GoodsDTO();
				
				gdto.setCategory(rs.getString("category"));
				gdto.setContent(rs.getString("content"));
				gdto.setDate(rs.getDate("date"));
				gdto.setG_amount(rs.getInt("g_amount"));
				gdto.setG_code(rs.getString("g_code"));
				gdto.setG_discount_rate(rs.getInt("g_discount_rate"));
				gdto.setG_mileage(rs.getInt("g_mileage"));
				gdto.setG_name(rs.getString("g_name"));
				gdto.setG_price_origin(rs.getInt("g_price_origin"));
				gdto.setG_price_sale(rs.getInt("g_price_sale"));
				gdto.setG_thumbnail(rs.getString("g_thumbnail"));
				gdto.setG_view_count(rs.getInt("g_view_count"));
				gdto.setNum(rs.getInt("num"));
				gdto.setSub_category(rs.getString("sub_category"));
				gdto.setSub_category_index(rs.getString("sub_category_index"));
				gdto.setG_delivery(rs.getString("g_delivery"));
				gdto.setG_option(rs.getString("g_option"));
				
				list.add(gdto);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return list;
	}
	
	
	
	
	
	
	
}
