package team2.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql="";
	
	// 디비 연결(커넥션 풀 사용)
	private Connection getConnection() throws Exception{
		// Context 객체를 생성
		Context init = new InitialContext();
		
		DataSource ds 
		 = (DataSource) init.lookup("java:comp/env/jdbc/team2");
		
		con = ds.getConnection();
		
		return con;
	}
	
	// 자원 해제 
	
	public void closeDB(){
		try {
			if(rs !=null) rs.close();
			if(pstmt !=null) pstmt.close();
			if(con !=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// insertMember(mdto)
	public void insertMember(MemberDTO mdto){
		try {
			getConnection();
			sql="insert into team2_member values(?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			pstmt.setString(2, mdto.getPass());
			pstmt.setString(3, mdto.getName());
			pstmt.setString(4, mdto.getPhone());
			pstmt.setString(5, mdto.getZipcode());
			pstmt.setString(6, mdto.getAddr1());
			pstmt.setString(7, mdto.getAddr2());
			pstmt.setString(8, mdto.getEmail());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
	// insertMember(mdto)
	
	// idCheck(id,pass)
	public int idCheck(String id, String pass){
		int check = -1;
		try {
			getConnection();
			sql="select pass from team2_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					check = 1;
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}
			
			System.out.println("아이디 체크 완료 : "+check);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	// idCheck(id,pass)
	
	
	
	
	
	
	
	
	
}
