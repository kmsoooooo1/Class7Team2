package team2.board.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {

	private Connection conn;
	private Statement stmt;
	private ResultSet rs;
	
	public CommentDAO() {
		// TODO Auto-generated constructor stub
		getConnection();
	}
	
	private void getConnection() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
			conn = ds.getConnection();
			stmt = conn.createStatement();
			
			System.out.println("Comment : DB 연결 성공!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void closeDB() {
		try {
			if(conn!=null)conn.close();
			if(stmt!=null)stmt.close();
			if(rs!=null)rs.close();
			
			System.out.println("Comment : 자원해제 성공");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int insertComment(CommentDTO cdto) {
		int chk = 0;
		
		String sql = "insert into team2_comment (c_idx, c_b_idx, c_id, c_comment, ip_addr)" + 
				"values ((select num from (select coalesce(max(c_idx),0) num from team2_project.team2_comment innerTable) outertable)+1,"
				+ cdto.getC_b_idx() + ",'"
				+ cdto.getC_id() + "','"
				+ cdto.getC_comment() + "','"
				+ cdto.getIp_addr() + "')";
		
		try {
			chk = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chk;
	}
	
//	단일 select문
//		댓글을 하나하나 가지고 오는 경우는 없을 것 같아 주석처리 해놓음
	
//	public CommentDTO select(String str) {
//		
//		CommentDTO dto = null;
//		
//		try {
//			stmt = conn.createStatement();
//			rs = stmt.executeQuery(str);
//			
//			dto = new CommentDTO(
//					rs.getInt("c_idx"),
//					rs.getString("c_category"),
//					rs.getInt("c_content_idx"),
//					rs.getString("c_id"),
//					rs.getString("c_comment"),
//					rs.getInt("c_like"),
//					rs.getTimestamp("c_regdate"),
//					rs.getString("ip_addr")
//					);
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return dto;	
//	}
	
	public List<CommentDTO> selectList(String str){
		
		List<CommentDTO> list = null;
		CommentDTO dto = null;
		
		try {
			
			rs = stmt.executeQuery(str);
			list = new ArrayList<CommentDTO>();
			while(rs.next()) {
				dto = new CommentDTO(
						rs.getInt("c_idx"),
						rs.getInt("c_b_idx"),
						rs.getString("c_id"),
						rs.getString("c_comment"),
						rs.getInt("c_like"),
						rs.getTimestamp("c_regdate"),
						rs.getString("ip_addr")
						);
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List<CommentDTO> getList(int c_b_idx){
		
		String sql = "select * from team2_comment where c_b_idx=" + c_b_idx;
		
		List<CommentDTO> list = selectList(sql);
		
		return list;
	}
	
	
	public int deleteComment(int c_idx) {
		int chk = 0;
		
		String sql = "delete from team2_comment where c_idx=" + c_idx;
		
		try {
			chk = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chk;
	}
	
	
	
}
