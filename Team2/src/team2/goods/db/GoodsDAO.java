package team2.goods.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GoodsDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
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
			
			System.out.println(" 자원해제 완료 ");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//////////////////////////////////////////////////////////////////////
	
	//insertGoods(gdto);
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
			sql = "INSERT INTO team2_goods VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,now())";
			
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
			pstmt.setString(13, gdto.getContent());
			pstmt.setInt(14, 0);
			
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
	
	//getGoodsList();
	public List<GoodsDTO> getGoodsList(String category, String sub_category, String sub_category_index){
		
		List<GoodsDTO> goodsList = new ArrayList<GoodsDTO>();
		
		try {
			con = getConnection();
			
			//StringBuffer: 저장공간(메모리)
			StringBuffer SQL = new StringBuffer();
			
			//SQL buffer 안에 sql 구문 넣어주기
			
			//만약 category가 all이고 sub_category가 없고 sub_category_index도 없을때(관리자 페이지에서 모든 동물을 부를때)
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){
				SQL.append("select * from team2_goods order by num desc");
			}
			//category가 먹이 이면
			else if(category.equals("먹이")){
				SQL.append("SELECT * FROM team2_goods WHERE category = '먹이' ");
				// sub_category가 없으면
				if(sub_category.equals("all")){
					SQL.append("order by num desc");
				}
				// sub_category가 있으면
				else{
					SQL.append("AND sub_category = ? ");
					// sub_category_index가 없으면
					if(sub_category_index.equals("all")){
						SQL.append("order by num desc");
					}
					//만약 sub_category_index가 있으면
					else {
						SQL.append("AND sub_category_index = ? order by num desc");
					}
				}
			}else if(category.equals("사육용품")){
				SQL.append("SELECT * FROM team2_goods WHERE category = '사육용품'");
				//만약 sub_category가 없으면	
				if(sub_category.equals("all")) {
					SQL.append("order by num");
				}
				//만약 sub_category가 있으면
				else {
					SQL.append("AND sub_category = ? order by num desc");
				}
			}
			
			pstmt = con.prepareStatement(SQL.toString());
			
			// ?에 값 지정
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){}
			else if(category.equals("먹이")){
				if(sub_category.equals("all")) {}
				else {
					pstmt.setString(1, sub_category);
					if(sub_category_index.equals("all")){
					}
					else {
						pstmt.setString(2, sub_category_index);
					}
				}
			}else if(category.equals("사육용품")){
				if(sub_category.equals("all")) {
				}
				else {
					pstmt.setString(1, sub_category);
				}
			}
			
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
	}
	//getGoodsList();
	
	
	
	
	
	
	
}
