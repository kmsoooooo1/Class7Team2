package team2.wishlist.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.product.db.ProductDTO;

public class WishlistDAO {
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
	
	//wishlistAdd(wldto)
	public int wishlistAdd(WishlistDTO wldto){
		int check = 0;
		int w_num = 0;
		
		try {
			con = getConnection();
			
			sql = "select * from team2_wishlist where id=? and w_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, wldto.getId());
			pstmt.setString(2, wldto.getW_code());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = -1;
			}else{
				// w_num 계산
				sql = "select max(w_num) from team2_wishlist";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					w_num = rs.getInt(1) + 1;
				}
				
				sql = "insert into team2_wishlist values(?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, w_num);
				pstmt.setString(2, wldto.getId());
				pstmt.setString(3, wldto.getW_code());
					
				pstmt.executeUpdate();
				
				check = 1;
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("관심상품 등록 실패");
		}finally{
			closeDB();
		}
		
		return check;
	} //wishlistAdd(wldto)
	
	
	//getWishlist()
	public Vector getWishlist(String id){
		
		Vector vec = new Vector();
		
		// 상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		// 관심상품 정보 저장
		ArrayList  wishList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			
			// 장바구니 정보 저장
			sql = "select * from team2_wishlist where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				WishlistDTO wldto = new WishlistDTO();
				wldto.setW_num(rs.getInt("w_num"));
				wldto.setId(rs.getString("id"));
				wldto.setW_code(rs.getString("w_code"));
				
				wishList.add(wldto); //관심상품에 하나의 정보를 리스트 한칸에 저장
				
				// w_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("w_code").charAt(0);
				
				// 만약 w_code의 앞에 한글자가 a이면 동물 db로 들어가기
				if(first_letter == 'a'){
					// 각각의 관심상품에 해당하는 상품 정보 저장
					sql="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, wldto.getW_code());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("a_thumbnail"));
						pdto.setProduct_name(rs2.getString("a_morph"));
						pdto.setProduct_price_sale(rs2.getInt("a_price_sale"));
						pdto.setProduct_price_origin(rs2.getInt("a_price_origin"));
						pdto.setProduct_discount_rate(rs2.getInt("a_discount_rate"));
						
						productInfoList.add(pdto);
					}
				}
				//만약 w_code의 앞에 한글자가 g이면 상품db로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql = "select * from team2_goods where g_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, wldto.getW_code());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("g_thumbnail"));
						pdto.setProduct_name(rs2.getString("g_name"));
						pdto.setProduct_price_sale(rs2.getInt("g_price_sale"));
						pdto.setProduct_price_origin(rs2.getInt("g_price_origin"));
						pdto.setProduct_discount_rate(rs2.getInt("g_discount_rate"));
						
						productInfoList.add(pdto);
					}
				}
			}
			vec.add(0, wishList);
			vec.add(1, productInfoList);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
		return vec;
	}//getWishlist()
	
	
	//deleteWishList(wldto)
	public void deleteWishList(WishlistDTO wldto){
		try {
			con = getConnection();
			
			sql = "delete from team2_wishlist where w_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, wldto.getW_code());
			pstmt.executeUpdate();
			
			System.out.println("관심상품 삭제 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}//deleteWishList(wldto)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
