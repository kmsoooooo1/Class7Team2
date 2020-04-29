package team2.goods.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
			sql = "INSERT INTO team2_goods VALUES(?,?,?,?,?,?,?,?,?,?,?,now())";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, gdto.getCategory());
			pstmt.setString(3, gdto.getSub_category());
			pstmt.setString(4, gdto.getSub_category_index());
			pstmt.setString(5, gdto.getG_name());
			pstmt.setString(6, gdto.getG_code());
			pstmt.setString(7, gdto.getG_image());
			pstmt.setInt(8, gdto.getG_amount());
			pstmt.setInt(9, gdto.getG_price());
			pstmt.setString(10, gdto.getContent());
			pstmt.setInt(11, 0);
			
			// 실행
			pstmt.executeUpdate();
			
			System.out.println("상품 등록 성공");
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("상품 등록 실패");
		}finally{
			closeDB();
		}//자원반납
	}//insertGoods(gdto);
	
	
	
	
	
	
	
	
	
}
