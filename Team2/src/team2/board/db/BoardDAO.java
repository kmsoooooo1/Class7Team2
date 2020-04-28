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
