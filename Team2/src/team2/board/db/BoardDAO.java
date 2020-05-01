package team2.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import team2.board.action.Criteria;
import team2.board.action.cSet;


public class BoardDAO {
	
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
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

	//insertBoard(BoardDTO bdto)
	public void insertBoard(BoardDTO bdto) {
		System.out.println("insertBoard(BoardDTO bdto) 호출");
		int b_idx = 0;
		
		try {
	
			sql = "select max(b_idx) from team2_board";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				b_idx = rs.getInt("max(b_idx)")+1;
			}
			System.out.println("글 번호 b_idx = " + b_idx);
			
			sql = "insert into team2_board(b_idx,b_category,b_p_cate,b_title,b_writer,b_content,b_ref,ip_addr,b_file) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, b_idx);
			pstmt.setString(2, bdto.getB_category());
			pstmt.setString(3, "1");
			pstmt.setString(4, bdto.getB_title());
			pstmt.setString(5, bdto.getB_writer());
			pstmt.setString(6, bdto.getB_content());
			pstmt.setInt(7, 1);
			pstmt.setString(8, bdto.getIp_addr());
			pstmt.setString(9, bdto.getB_file());
			
			pstmt.executeUpdate();
			
			System.out.println("작성 글 DB 등록 완료!!");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//insertBoard(BoardDTO bdto)
	
	//getBoardCount(cSet cset)
	public int getBoardCount(cSet cset) {
		int total = 0;
		
		int sub = cset.getPc();
		System.out.println("category : " +cset.getCategory());
	
		try {
			if(sub==0){
				//서브카테고리가 없을 떄
				
				sql = "select count(*) from team2_board where b_category = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cset.getCategory());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					total = rs.getInt(1);
				}
				System.out.println(cset + " 글 개수 확인 : " + total);
				
			}else{
				//서브카테고리가 있을 때
			
				sql = "select count(*) from team2_board where b_category = ? AND and b_p_cate = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cset.getCategory());
				pstmt.setString(2, cset.getP_category());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					total = rs.getInt(1);
				}
				System.out.println(cset + "게시판 글 개수 확인 : " + total);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
	//getBoardCount(cSet cset)
	
	//getBoardList(cSet cset, Criteria cri)
		public ArrayList<BoardDTO> getBoardList(cSet cset, Criteria cri){
			ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
			
			int sub = cset.getPc();
			
			try {
				if(sub==0){
				//서브카테고리가 없을 떄
					sql = "select * from team2_board where b_category = ? order by b_idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, cset.getCategory());
					pstmt.setInt(2, cri.getPageStart());
					pstmt.setInt(3, cri.getPerpageNum());
					
					rs = pstmt.executeQuery();
					
					while(rs.next()){
						BoardDTO bdto = new BoardDTO();
						
						bdto.setB_title(rs.getString("b_title"));
						bdto.setB_writer(rs.getString("b_writer"));
						bdto.setIp_addr(rs.getString("ip_addr"));
						bdto.setB_reg_date(rs.getDate("b_reg_date"));
						bdto.setB_category(rs.getString("b_category"));
						bdto.setB_content(rs.getString("b_content"));
						bdto.setB_file(rs.getString("b_file"));
						bdto.setB_idx(rs.getInt("b_idx"));
						bdto.setB_like(rs.getInt("b_like"));
						bdto.setB_view(rs.getInt("b_view"));
						bdto.setB_p_cate(rs.getString("b_p_cate"));
						
						
						boardList.add(bdto);
					}
				}else{
					//서브카테고리가 있을 떄
					sql = "select * from team2_board where b_category = ? and b_p_cate = ? order by b_idx desc limit ?,?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, cset.getCategory());
					pstmt.setString(1, cset.getP_category());
					pstmt.setInt(2, cri.getPageStart());
					pstmt.setInt(3, cri.getPerpageNum());
					
					rs = pstmt.executeQuery();
					
					while(rs.next()){
						BoardDTO bdto = new BoardDTO();
						
						bdto.setB_title(rs.getString("b_title"));
						bdto.setB_writer(rs.getString("b_writer"));
						bdto.setIp_addr(rs.getString("ip_addr"));
						bdto.setB_reg_date(rs.getDate("b_reg_date"));
						bdto.setB_category(rs.getString("b_category"));
						bdto.setB_content(rs.getString("b_content"));
						bdto.setB_file(rs.getString("b_file"));
						bdto.setB_idx(rs.getInt("b_idx"));
						bdto.setB_like(rs.getInt("b_like"));
						bdto.setB_view(rs.getInt("b_view"));
						bdto.setB_p_cate(rs.getString("b_p_cate"));
						
						
						boardList.add(bdto);
					}
				}
				System.out.println("게시판 글 arraylist로 저장 완료 : " + boardList);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return boardList;
			
		}
		//getBoardList(cSet cset, Criteria cri)
		
		//updateView(int num)
		public void updateView(int num) {
			
			try {
				
				sql = "update team2_board "
						+ "set b_view = b_view + 1 where b_idx = ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				pstmt.executeUpdate();
				
				System.out.println("해당글 ("+num+") 조회수 1 증가");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//updateView(int num)
		
		// BoardDTO getBoard(int num)
		public BoardDTO getBoard(int num) {
			
			BoardDTO bdto = null;
			
			try {
				
				sql = "select * from team2_board where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					bdto = new BoardDTO();
					
					bdto.setB_idx(rs.getInt("b_idx"));
					bdto.setB_title(rs.getString("b_title"));
					bdto.setB_category(rs.getString("b_category"));
					bdto.setB_p_cate(rs.getString("b_p_cate"));
					bdto.setB_title(rs.getString("b_title"));
					bdto.setB_writer(rs.getString("b_writer"));
					bdto.setB_content(rs.getString("b_content"));
					bdto.setB_ref(rs.getInt("b_ref"));
					bdto.setB_view(rs.getInt("b_view"));
					bdto.setB_reg_date(rs.getDate("b_reg_date"));
					bdto.setIp_addr(rs.getString("ip_addr"));
					bdto.setB_file(rs.getString("b_file"));
					
					
				}
				
				System.out.println("cotent DTO 저장 : " +bdto);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return bdto;
		}
		// BoardDTO getBoard(int num)

		//updateBoard()
		public void updateBoard(BoardDTO bdto) {
			
			try {
				sql = "update team2_board set b_category=?,b_p_cate=?,b_title=?,b_content=? where b_idx=?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bdto.getB_category());
				pstmt.setString(2, bdto.getB_p_cate());
				pstmt.setString(3, bdto.getB_title());
				pstmt.setString(4, bdto.getB_content());
				pstmt.setInt(5, bdto.getB_idx());
				
				pstmt.executeUpdate();
				
				System.out.println("Content 수정 완료! ");
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("Content 수정 실패@@@");
			}
			
		}
		//updateBoard()
		
		
		
		
		
		
		
}
