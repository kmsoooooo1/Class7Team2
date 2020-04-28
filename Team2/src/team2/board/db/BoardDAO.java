package team2.board.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class BoardDAO {
	
	Connection conn;
	Statement stmt;
	ResultSet rs;
	String sql;
	
	public BoardDAO() {
		getConnection();
	}
	
	public int insert(BoardDTO dto){
		int chk = 0;
		
		sql = "select coalesce(max(b_idx),0) idx from team2_board";
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				sql = "insert into team2_project.team2_board"
						+ "(b_idx,b_category,b_p_cate,b_title,b_writer, b_content, b_ref,ip_addr,b_file)"
						+ "values ("
						+ (rs.getInt("idx")+1) + ",'"
						+ dto.getB_category() + "','"
						+ dto.getB_p_cate() + "','"
						+ dto.getB_title() + "','"
						+ dto.getB_writer() + "','"
						+ dto.getB_content() + "',"
						+ (rs.getInt("idx")+1) + ",'"
						+ dto.getIp_addr() + "','"
						+ dto.getB_file() + "')";
			
				chk = stmt.executeUpdate(sql);
			}else{
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chk;
	}
	
	
	
	
	
	private void getConnection(){
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
			conn = ds.getConnection();
			
			System.out.println("Connection 성공");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void closeDB(){
		try {
			if(conn!=null)conn.close();
			if(stmt!=null)stmt.close();
			if(rs!=null)rs.close();
			
			System.out.println("Close 성공!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
