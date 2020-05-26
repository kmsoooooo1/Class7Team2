package team2.order.db;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.member.db.MemberPointDTO;
import team2.product.db.ProductDTO;

public class OrderDAO {
	
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
	
	//현재 DB에 나의 주문 번호 첫번째 값 가지기 위한 함수 
	public int find_MaxO_num(String id){
		int o_first_num = 0;
		
		try {
			con = getConnection();
			sql = "select max(o_num) from team2_order where o_m_id = ? limit 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()){
				o_first_num = rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return o_first_num;
	}
	
	//주문한정보 저장하는 함수
	public String addOrder(OrderDTO odto, int o_first_num){
		String o_trade_num = "";
		
		int o_num = 0;
		int trade_num = o_first_num;
		
		Calendar cal = Calendar.getInstance();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		try {
			con = getConnection();
			sql = "select MAX(o_num) from team2_order";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				o_num = rs.getInt(1) + 1;
			}else{
				o_num = 1;
			}
				
			sql = "insert into team2_order values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, now(), ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, o_num);
			pstmt.setString(2, sdf.format(cal.getTime()).toString() + "-" + trade_num); // 20200331-1
			pstmt.setString(3, odto.getO_p_code());
			pstmt.setInt(4, odto.getO_p_amount());
			pstmt.setString(5, odto.getO_p_option());
			pstmt.setString(6, odto.getO_p_delivery_method());
			
			pstmt.setString(7, odto.getO_m_id());
			pstmt.setString(8, odto.getO_receive_name());
			pstmt.setString(9, odto.getO_receive_zipcode());
			pstmt.setString(10, odto.getO_receive_addr1());
			pstmt.setString(11, odto.getO_receive_addr2());
			pstmt.setString(12, odto.getO_receive_mobile());
			pstmt.setString(13, odto.getO_receive_phone());
			pstmt.setString(14, odto.getO_memo());
			
			pstmt.setInt(15, odto.getO_sum_money());
			pstmt.setString(16, odto.getO_trade_type());
			pstmt.setString(17, odto.getO_trade_payer());
			
			pstmt.setString(18, "");
			pstmt.setInt(19, 0);
			
			pstmt.executeUpdate();
			
			o_num++;
			
			o_trade_num = sdf.format(cal.getTime()).toString() + "-" + trade_num;
			
			//장바구니 DB 들어가서 추가하고자 하는  삭제시키기
			sql = "delete from team2_basket where b_code = ? and b_option = ? and b_delivery_method = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, odto.getO_p_code());
			pstmt.setString(2, odto.getO_p_option());
			pstmt.setString(3, odto.getO_p_delivery_method());
			pstmt.executeUpdate();
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return o_trade_num;
	}
	
	// 주문 정보 모두 가져오는 함수
	public Vector getOrderList(String o_m_id, String o_trade_num) {
		
		Vector vec = new Vector();
		
		ArrayList orderList = new ArrayList();
		
		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			// 본인의 정보만 가지고이동, o_trade_num기준으로 내림차순 정렬
			sql = "select * from team2_order where o_m_id = ? and o_trade_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_m_id);
			pstmt.setString(2, o_trade_num);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				OrderDTO odto = new OrderDTO();
				odto.setO_trade_num(rs.getString("o_trade_num"));
				odto.setO_p_code(rs.getString("o_p_code"));
				odto.setO_p_amount(rs.getInt("o_p_amount"));
				odto.setO_p_option(rs.getString("o_p_option"));
				odto.setO_p_delivery_method(rs.getString("o_p_delivery_method"));
				
				odto.setO_m_id(o_m_id);
				odto.setO_receive_name(rs.getString("o_receive_name"));
				odto.setO_receive_zipcode(rs.getString("o_receive_zipcode"));
				odto.setO_receive_addr1(rs.getString("o_receive_addr1"));
				odto.setO_receive_addr2(rs.getString("o_receive_addr2"));
				odto.setO_receive_mobile(rs.getString("o_receive_mobile"));
				odto.setO_receive_phone(rs.getString("o_receive_phone"));
				odto.setO_memo(rs.getString("o_memo"));
				
				odto.setO_sum_money(rs.getInt("o_sum_money"));
				odto.setO_trade_type(rs.getString("o_trade_type"));
				odto.setO_trade_payer(rs.getString("o_trade_payer"));
				odto.setO_trade_date(rs.getDate("o_trade_date"));
				
				odto.setO_trans_num(rs.getString("o_trans_num"));
				odto.setO_date(rs.getDate("o_date"));
				odto.setO_status(rs.getInt("o_status"));
				orderList.add(odto);
	
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("o_p_code").charAt(0);
				
				//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
				if(first_letter == 'a'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql ="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
				//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장	
					sql ="select * from team2_goods where g_code = ? and g_option = ?";	
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
					pstmt2.setString(2, odto.getO_p_option());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
			}
			vec.add(0, orderList);
			vec.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return vec;
	}
	
	
	// 주문 정보 모두 가져오는 함수
	public Vector getOrderList(String o_m_id) {
		
		Vector vec = new Vector();
		
		ArrayList orderList = new ArrayList();
		
		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			// 본인의 정보만 가지고이동, o_trade_num기준으로 내림차순 정렬
			sql = "select * from team2_order where o_m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_m_id);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				OrderDTO odto = new OrderDTO();
				odto.setO_trade_num(rs.getString("o_trade_num"));
				odto.setO_p_code(rs.getString("o_p_code"));
				odto.setO_p_amount(rs.getInt("o_p_amount"));
				odto.setO_p_option(rs.getString("o_p_option"));
				odto.setO_p_delivery_method(rs.getString("o_p_delivery_method"));
				
				odto.setO_m_id(o_m_id);
				odto.setO_receive_name(rs.getString("o_receive_name"));
				odto.setO_receive_zipcode(rs.getString("o_receive_zipcode"));
				odto.setO_receive_addr1(rs.getString("o_receive_addr1"));
				odto.setO_receive_addr2(rs.getString("o_receive_addr2"));
				odto.setO_receive_mobile(rs.getString("o_receive_mobile"));
				odto.setO_receive_phone(rs.getString("o_receive_phone"));
				odto.setO_memo(rs.getString("o_memo"));
				
				odto.setO_sum_money(rs.getInt("o_sum_money"));
				odto.setO_trade_type(rs.getString("o_trade_type"));
				odto.setO_trade_payer(rs.getString("o_trade_payer"));
				odto.setO_trade_date(rs.getDate("o_trade_date"));
				
				odto.setO_trans_num(rs.getString("o_trans_num"));
				odto.setO_date(rs.getDate("o_date"));
				odto.setO_status(rs.getInt("o_status"));
				orderList.add(odto);
	
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("o_p_code").charAt(0);
				
				//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
				if(first_letter == 'a'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql ="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
				//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장	
					sql ="select * from team2_goods where g_code = ? and g_option = ?";	
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
					pstmt2.setString(2, odto.getO_p_option());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
			}
			vec.add(0, orderList);
			vec.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return vec;
	}
	
	// 주문 정보 모두 가져오는 함수(인수 없이)
	public Vector getOrderList() {
		
		Vector vec = new Vector();
		
		ArrayList orderList = new ArrayList();
		
		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			sql = "select * from team2_order group by o_trade_num";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				OrderDTO odto = new OrderDTO();
				odto.setO_trade_num(rs.getString("o_trade_num"));
				odto.setO_p_code(rs.getString("o_p_code"));
				odto.setO_p_amount(rs.getInt("o_p_amount"));
				odto.setO_p_option(rs.getString("o_p_option"));
				odto.setO_p_delivery_method(rs.getString("o_p_delivery_method"));
				
				odto.setO_m_id(rs.getString("o_m_id"));
				odto.setO_receive_name(rs.getString("o_receive_name"));
				odto.setO_receive_zipcode(rs.getString("o_receive_zipcode"));
				odto.setO_receive_addr1(rs.getString("o_receive_addr1"));
				odto.setO_receive_addr2(rs.getString("o_receive_addr2"));
				odto.setO_receive_mobile(rs.getString("o_receive_mobile"));
				odto.setO_receive_phone(rs.getString("o_receive_phone"));
				odto.setO_memo(rs.getString("o_memo"));
				
				odto.setO_sum_money(rs.getInt("o_sum_money"));
				odto.setO_trade_type(rs.getString("o_trade_type"));
				odto.setO_trade_payer(rs.getString("o_trade_payer"));
				odto.setO_trade_date(rs.getDate("o_trade_date"));
				
				odto.setO_trans_num(rs.getString("o_trans_num"));
				odto.setO_date(rs.getDate("o_date"));
				odto.setO_status(rs.getInt("o_status"));
				orderList.add(odto);
	
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("o_p_code").charAt(0);
				
				//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
				if(first_letter == 'a'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql ="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
				//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장	
					sql ="select * from team2_goods where g_code = ? and g_option = ?";	
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
					pstmt2.setString(2, odto.getO_p_option());
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
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
			}
			vec.add(0, orderList);
			vec.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return vec;
	}
	
	//운송장번호를 입력했을때 수정하는 함수
	public void updateOrderStatus(String o_trade_num, String o_trans_num){
		try {
			con = getConnection();
			sql = "SELECT * FROM team2_order where o_trade_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_trade_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				//운송장번호 추가하기
				sql = "update team2_order set o_trans_num = ?, o_status = ? where o_trade_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, o_trans_num);
				if(o_trans_num.equals("")){
					pstmt.setInt(2, 1);
				}else{
					pstmt.setInt(2, 2);
				}
				pstmt.setString(3, o_trade_num);
				pstmt.executeUpdate();
			}
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
	}
	
	//o_trade_num 만 가지고 오는 함수
	public List<OrderDTO> getTradeNumList(String id){
		ArrayList trade_num_List = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from team2_order where o_m_id = ? group by o_trade_num";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				OrderDTO odto = new OrderDTO();
				odto.setO_trade_num(rs.getString("o_trade_num"));
				trade_num_List.add(odto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return trade_num_List;
	}
	
	//o_status 수정하는 함수
	public void modiStatus(String o_trade_num){
		try {
			con = getConnection();
			sql = "SELECT * FROM team2_order where o_trade_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_trade_num);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				//운송장번호 추가하기
				sql = "update team2_order set o_status = ? where o_trade_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, 1);
				pstmt.setString(2, o_trade_num);
				pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	// 총주문 횟수 구하기
	public int countOrder(String id){
		int countOrderNum = 0;
		
		try {
			con = getConnection();
			
			sql = "SELECT o_trade_num FROM team2_order where o_m_id=? group by o_trade_num";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				countOrderNum += 1;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return countOrderNum;

	}
	
	
	

}
