package team2.basket.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
			
			sql = "select * from team2_basket "
					+ "where id=? and b_code=? and b_option=?";
			
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
	// checkGoods(bkdto)
	
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
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	// basketAdd(bkdto)
	
	
	
	
	
	
	
	
	
	
}
