package team2.coupon.db;

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

import team2.goods.db.GoodsDTO;

public class CouponDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	Statement stmt;
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
			if(stmt!=null)stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//새로운 쿠폰 추가하는 함수
	public void insertCoupon(CouponDTO cdto) {
		int num = 0;
		try {
			con = getConnection();
			//num 계산
			sql = "select max(num) from team2_coupon_admin";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				num = rs.getInt(1) + 1;
			}
			sql = "insert into team2_coupon_admin values(?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, cdto.getCo_target());
			pstmt.setString(3, cdto.getCo_name());
			pstmt.setString(4, cdto.getCo_rate());
			pstmt.setString(5, cdto.getCo_startDate());
			pstmt.setString(6, cdto.getCo_endDate());
			pstmt.setString(7, cdto.getCo_status());
			pstmt.setString(8, cdto.getCo_image());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	//쿠폰 리스트 가져오는 함수
	public List<CouponDTO> getCouponsList(){
		List<CouponDTO> couponsList = new ArrayList<CouponDTO>();
		try {
			con = getConnection();
			sql="SELECT * FROM team2_coupon_admin where co_status = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "true");
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CouponDTO cdto = new CouponDTO();
				cdto.setCo_target(rs.getString("co_target"));
				cdto.setCo_name(rs.getString("co_name"));
				cdto.setCo_rate(rs.getString("co_rate"));
				cdto.setCo_startDate(rs.getString("co_startDate"));
				cdto.setCo_endDate(rs.getString("co_endDate"));
				cdto.setCo_image(rs.getString("co_image"));
				couponsList.add(cdto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return couponsList;
	}
}
