package team2.animal.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AnimalDAO {
	
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
	
	//새로운 동물 추가하는 함수
	public void insertAnimal(AnimalDTO adto) {
		int num = 0;
		try {
			con = getConnection();
			//num 계산
			sql = "select max(num) from team2_animals";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			sql = "insert into team2_animals values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, adto.getCategory());
			pstmt.setString(3, adto.getSub_category());
			pstmt.setString(4, adto.getSub_category_index());
			pstmt.setString(5, adto.getA_morph());
			pstmt.setString(6, adto.getA_sex());
			pstmt.setString(7, adto.getA_status());
			pstmt.setString(8, adto.getA_code());
			pstmt.setString(9, adto.getA_image());
			pstmt.setInt(10, adto.getA_amount());
			pstmt.setInt(11, adto.getA_price());
			pstmt.setString(12, adto.getContent());
			pstmt.setInt(13, 0);
			pstmt.executeUpdate();
			
			System.out.println(pstmt.toString());
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	
	
	
	
	

}
