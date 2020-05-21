package team2.basket.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.product.db.ProductDTO;

public class BasketDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	// 디비 연결(커넥션 풀 사용)
	private Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/team2");
		con = ds.getConnection();
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
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// checkGoods(bkdto)
	public int checkGoods(BasketDTO bkdto){
		int check = 0;		
		try {
			con = getConnection();
			sql = "select * from team2_basket where id=? and b_code=? and b_option=?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bkdto.getId());
			pstmt.setString(2, bkdto.getB_code());
			pstmt.setString(3, bkdto.getB_option());

			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sql = "update team2_basket set b_amount = b_amount+? "
						+ "where id=? and b_code=? and b_option=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bkdto.getB_amount());
				pstmt.setString(2, bkdto.getId());
				pstmt.setString(3, bkdto.getB_code());
				pstmt.setString(4, bkdto.getB_option());
				
				check = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return check;
	}

	
	// basketAdd(bkdto)
	public void basketAdd(BasketDTO bkdto){
		int b_num = 0;
		try {
			con = getConnection();
			// b_num 계산
			sql ="select max(b_num) from team2_basket";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				b_num = rs.getInt(1)+1;
			}
			
			sql = "select * from team2_basket where id= ? and b_code = ? and b_option = ? and b_delivery_method = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bkdto.getId());
			pstmt.setString(2, bkdto.getB_code());
			pstmt.setString(3, bkdto.getB_option());
			pstmt.setString(4, bkdto.getB_delivery_method());
			rs = pstmt.executeQuery();

			//현재 추가하고자 하는 상품의 옵션정보가  DB에 있으면 상품 수량만 늘리는 구문으로 넘어가기
			if(rs.next()){
				sql="update team2_basket set b_amount = b_amount + ? where id = ? and b_code = ? and b_option = ? and b_delivery_method = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bkdto.getB_amount());
				pstmt.setString(2, bkdto.getId());
				pstmt.setString(3, bkdto.getB_code());
				pstmt.setString(4, bkdto.getB_option());
				pstmt.setString(5, bkdto.getB_delivery_method());
				pstmt.executeUpdate();
			}
			
			//현재 추가하고자 하는 상품의 옵션정보가 DB에 없으면 insert 구문으로 넘어가고
			else{
				// 상품을 장바구니에 저장
				// 장바구니에 상품 정보를 저장
				sql="insert into team2_basket values(?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, b_num);
				pstmt.setString(2, bkdto.getId());
				pstmt.setString(3, bkdto.getB_code());
				pstmt.setInt(4, bkdto.getB_amount());
				pstmt.setString(5, bkdto.getB_option());
				pstmt.setString(6, bkdto.getB_delivery_method());
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	
	
	// getBasketList(id)
	public Vector getBasketList(String id){
		
		Vector vec = new Vector();
		
		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		//장바구니 정보 저장
		ArrayList basketList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			// 장바구니 정보 저장
			sql="select * from team2_basket where id = ? order by b_num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				BasketDTO bkdto = new BasketDTO();
				bkdto.setB_num(rs.getInt("b_num"));
				bkdto.setId(rs.getString("id"));
				bkdto.setB_code(rs.getString("b_code"));
				bkdto.setB_amount(rs.getInt("b_amount"));
				bkdto.setB_option(rs.getString("b_option"));
				bkdto.setB_delivery_method(rs.getString("b_delivery_method"));
				basketList.add(bkdto); // 장바구니 하나의 정보를 리스트 한칸에 저장
				
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("b_code").charAt(0);
				
				//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
				if(first_letter == 'a'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql ="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, bkdto.getB_code());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("a_thumbnail"));	
						pdto.setProduct_name(rs2.getString("a_morph"));
						pdto.setProduct_price_sale(rs2.getInt("a_price_sale"));
						pdto.setProduct_mileage(rs2.getInt("a_mileage"));
						pdto.setProduct_discount_rate(rs2.getInt("a_discount_rate"));
						pdto.setProduct_price_origin(rs2.getInt("a_price_origin"));
						pdto.setProduct_amount(rs2.getInt("a_amount"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
				//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장	
					sql ="select * from team2_goods where g_code = ? and g_option = ?";	
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, bkdto.getB_code());
					pstmt2.setString(2, bkdto.getB_option());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){	
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("g_thumbnail"));
						pdto.setProduct_name(rs2.getString("g_name"));
						pdto.setProduct_price_sale(rs2.getInt("g_price_sale"));
						pdto.setProduct_mileage(rs2.getInt("g_mileage"));
						pdto.setProduct_discount_rate(rs2.getInt("g_discount_rate"));
						pdto.setProduct_price_origin(rs2.getInt("g_price_origin"));
						pdto.setProduct_amount(rs2.getInt("g_amount"));
						pdto.setProduct_option_price(rs2.getInt("g_option_price"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
			}
			vec.add(0, basketList);
			vec.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return vec;
	}
	
	// getBasketList(id, BasketDTO bdto)
	public ArrayList getBasketList(String id, List<BasketDTO> basketList_temp){
		
		ArrayList all_list = new ArrayList();
		
		//장바구니 정보 저장
		ArrayList basketList = new ArrayList();

		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			for(int i=0; i<basketList_temp.size(); i++) {
				BasketDTO bdto = (BasketDTO) basketList_temp.get(i);
				
				con = getConnection();
				// 장바구니 정보 저장
				sql="select * from team2_basket where id = ? and b_code = ? and b_option = ? and b_delivery_method = ? order by b_num desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, bdto.getB_code());
				pstmt.setString(3, bdto.getB_option());
				pstmt.setString(4, bdto.getB_delivery_method());
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					BasketDTO bkdto = new BasketDTO();
					bkdto.setB_num(rs.getInt("b_num"));
					bkdto.setId(rs.getString("id"));
					bkdto.setB_code(rs.getString("b_code"));
					bkdto.setB_amount(rs.getInt("b_amount"));
					bkdto.setB_option(rs.getString("b_option"));
					bkdto.setB_delivery_method(rs.getString("b_delivery_method"));
					basketList.add(bkdto);
					
					//b_code 값들 중에 맨 앞글자 따오기
					char first_letter = rs.getString("b_code").charAt(0);
					
					//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
					if(first_letter == 'a'){
						// 각각의 장바구니에 해당하는 상품 정보 저장
						sql ="select * from team2_animals where a_code = ?";
						pstmt2 = con.prepareStatement(sql);
						pstmt2.setString(1, bkdto.getB_code());
						rs2 = pstmt2.executeQuery();
						
						if(rs2.next()){
							ProductDTO pdto = new ProductDTO();
							pdto.setProduct_thumbnail(rs2.getString("a_thumbnail"));	
							pdto.setProduct_name(rs2.getString("a_morph"));
							pdto.setProduct_price_sale(rs2.getInt("a_price_sale"));
							pdto.setProduct_mileage(rs2.getInt("a_mileage"));
							pdto.setProduct_discount_rate(rs2.getInt("a_discount_rate"));
							pdto.setProduct_price_origin(rs2.getInt("a_price_origin"));
							pdto.setProduct_amount(rs2.getInt("a_amount"));
							productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
						}
					}
					//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
					else if(first_letter == 'g'){
						// 각각의 장바구니에 해당하는 상품 정보 저장
						sql ="select * from team2_goods where g_code = ?";	
						pstmt2 = con.prepareStatement(sql);
						pstmt2.setString(1, bkdto.getB_code());
						rs2 = pstmt2.executeQuery();
						
						if(rs2.next()){	
							ProductDTO pdto = new ProductDTO();
							pdto.setProduct_thumbnail(rs2.getString("g_thumbnail"));
							pdto.setProduct_name(rs2.getString("g_name"));
							pdto.setProduct_price_sale(rs2.getInt("g_price_sale"));
							pdto.setProduct_mileage(rs2.getInt("g_mileage"));
							pdto.setProduct_discount_rate(rs2.getInt("g_discount_rate"));
							pdto.setProduct_price_origin(rs2.getInt("g_price_origin"));
							pdto.setProduct_amount(rs2.getInt("g_amount"));
							productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
						}
					}
				}
			}
			all_list.add(0, basketList);
			all_list.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return all_list;
	}
	
	
	//장바구니 수량 수정하는 함수
	public void modiAmount(BasketDTO bdto) {
		try {
			con = getConnection();
			sql="select * from team2_basket where b_code = ? and b_option = ? and b_delivery_method = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getB_code());
			pstmt.setString(2, bdto.getB_option());
			pstmt.setString(3, bdto.getB_delivery_method());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				//상품이 존재하면
				sql="update team2_basket set b_amount = ? where b_code = ? and b_option = ? and b_delivery_method = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bdto.getB_amount());
				pstmt.setString(2, bdto.getB_code());
				pstmt.setString(3, bdto.getB_option());
				pstmt.setString(4, bdto.getB_delivery_method());
				pstmt.executeUpdate();
			}	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	
	//장바구니 정보 삭제하는 함수
	public void deleteBasket(BasketDTO bdto){
		try {
			con = getConnection();
			sql = "delete from team2_basket where b_code = ? and b_option = ? and b_delivery_method = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bdto.getB_code());
			pstmt.setString(2, bdto.getB_option());
			pstmt.setString(3, bdto.getB_delivery_method());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	
	
	
	
	
	
	
}
