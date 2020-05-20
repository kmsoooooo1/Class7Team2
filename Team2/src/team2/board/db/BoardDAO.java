package team2.board.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

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
	
	////////////////////////////////////////////////////////////
	//	insertBoard
	//	board DB에 글 등록
	
	public int insertBoard(BoardDTO dto){
		int chk = 0;
		System.out.println(dto);
		sql = "select coalesce(max(b_idx),0) idx from team2_board";
		try {
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				sql = "insert into team2_project.team2_board"
						+ "(b_idx,b_category,b_title,b_writer, b_content, b_ref,ip_addr,b_file,b_p_code)"
						+ "values ("
						+ (rs.getInt("idx")+1) + ",'"
						+ dto.getB_category() + "','"
						+ dto.getB_title() + "','"
						+ dto.getB_writer() + "','"
						+ dto.getB_content() + "',"
						+ (rs.getInt("idx")+1) + ",'"
						+ dto.getIp_addr() + "','"
						+ dto.getB_file() + "','"
						+ dto.getB_p_code() + "')";
			
				System.out.println(sql);
				chk = stmt.executeUpdate(sql);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chk;
	}
	
	//	insertBoard End
	////////////////////////////////////////////////////////
  
	
	
	///////////////////////////////////////////////////////
	//	getConnection - 초기 세팅
	//	closeDB - 필수 함수
	
	private void getConnection(){
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/team2");
			conn = ds.getConnection();
			stmt = conn.createStatement();
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
	
	//	getConnection
	//	closeDB 		End
	///////////////////////////////////////////////////////

	///////////////////////////////////////////////////////
	//getBoardCount(cSet cset)
	public int getBoardCount(cSet cset) {
		int total = 0;
		
		System.out.println("category : " +cset.getCategory());
	
		try {

				sql = "select count(*) from team2_board where b_category = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cset.getCategory());
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					total = rs.getInt(1);
				}
				System.out.println(cset + " 글 개수 확인 : " + total);
				
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
	//getBoardCount(cSet cset)
	///////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////
	//getBoardList(cSet cset, Criteria cri)
	
	public ArrayList<BoardDTO> getBoardList(cSet cset, Criteria cri){
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		try {

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
					
					
					boardList.add(bdto);
				}
			
			System.out.println("getBoardList(cSet cset, Criteria cri) 성공");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return boardList;
		
	}
	
	//getBoardList(cSet cset, Criteria cri)
	///////////////////////////////////////////////////////
		
	///////////////////////////////////////////////////////	
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
	///////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////
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
				bdto.setB_title(rs.getString("b_title"));
				bdto.setB_writer(rs.getString("b_writer"));
				bdto.setB_content(rs.getString("b_content"));
				bdto.setB_ref(rs.getInt("b_ref"));
				bdto.setB_view(rs.getInt("b_view"));
				bdto.setB_reg_date(rs.getDate("b_reg_date"));
				bdto.setIp_addr(rs.getString("ip_addr"));
				bdto.setB_file(rs.getString("b_file"));
				bdto.setB_p_code(rs.getString("b_p_code"));
				
			}
			
			System.out.println("cotent DTO 저장 : " +bdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bdto;
	}
	// BoardDTO getBoard(int num)

	//updateBoard()
	public int updateBoard(BoardDTO bdto) {
		int chk = -1;
		
		try {
			sql = "update team2_board set b_category=?,b_title=?,b_content=?, b_file=? where b_idx=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bdto.getB_category());
			pstmt.setString(2, bdto.getB_title());
			pstmt.setString(3, bdto.getB_content());
			pstmt.setString(4, bdto.getB_file());
			pstmt.setInt(5, bdto.getB_idx());
			
			chk = pstmt.executeUpdate();
			
			System.out.println("Content 수정 완료! ");
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Content 수정 실패@@@");
			chk = 0;
		}
		
		return chk;
	}
	//updateBoard()
	
	
	
	//////////////////////////////////////////////////////////////
	//	board getList
	
	public List<BoardDTO> getList(String sql){
		List<BoardDTO> list = new ArrayList<>();
		
		try {
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				BoardDTO dto = new BoardDTO();
				dto.setB_idx(rs.getInt("b_idx"));
				dto.setB_category(rs.getString("b_category"));
				dto.setB_title(rs.getString("b_title"));
				dto.setB_writer(rs.getString("b_writer"));
				dto.setB_content(rs.getString("b_content"));
				dto.setB_ref(rs.getInt("b_ref"));
				dto.setB_like(rs.getInt("b_like"));
				dto.setB_view(rs.getInt("b_view"));
				dto.setB_reg_date(rs.getDate("b_reg_date"));
				dto.setIp_addr(rs.getString("ip_addr"));
				dto.setB_file(rs.getString("b_file"));
				dto.setB_p_code(rs.getString("b_p_code"));
				
				System.out.println(dto);
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public List<BoardDTO> getPList(int C, String b_p_code){
		String sql = "select * from team2_board where b_category='" + cSet.Category[C] + "' and b_p_code='" + b_p_code + "' order by b_idx desc";
		System.out.println(sql);
		return getList(sql);
	}
	
	public List<BoardDTO> getBoardAll(int C){
		String sql = "select * from team2_board where b_category='" + cSet.Category[C] + "' order by b_idx desc";
		System.out.println(sql);
		return getList(sql);
	}
		
	//	board getList End
	////////////////////////////////////////////////////////////////////
	
	public void deleteBoard(int num) {
		
		try {
			sql = "delete from team2_board where b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println("DB 삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//관리자 삭제
	public void deleteBoard(String chks) {
		
		int idx = Integer.parseInt(chks);
		
		try {
			sql = "delete from team2_board where b_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			
			pstmt.executeUpdate();
			
			System.out.println(idx+" 삭제 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<BoardDTO> searchBoard(String sql) {
		
		ArrayList<BoardDTO> searchList = new ArrayList();
		
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				BoardDTO dto = new BoardDTO();
				dto.setB_idx(rs.getInt("b_idx"));
				dto.setB_category(rs.getString("b_category"));
				dto.setB_title(rs.getString("b_title"));
				dto.setB_writer(rs.getString("b_writer"));
				dto.setB_content(rs.getString("b_content"));
				dto.setB_ref(rs.getInt("b_ref"));
				dto.setB_like(rs.getInt("b_like"));
				dto.setB_view(rs.getInt("b_view"));
				dto.setB_reg_date(rs.getDate("b_reg_date"));
				dto.setIp_addr(rs.getString("ip_addr"));
				dto.setB_file(rs.getString("b_file"));
				dto.setB_p_code(rs.getString("b_p_code"));
				
				searchList.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return searchList;
		
	}

	public ArrayList<BoardDTO> searchTitle(cSet cset, String search, Criteria cri) {		
		
		sql = "select * from team2_board where b_category='"+cset.getCategory()+"' and b_title like '%"+search+"%' order by b_idx desc limit "+cri.getPageStart()+","+cri.getPerpageNum()+"";
			
		System.out.println("searchTitle : "+sql);
		
		return searchBoard(sql);
		
	}

	public int serachCount(cSet cset, String search) {
		int total = 0;
		
		try {
			sql = "select count(*) from team2_board where b_category=? and b_title like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cset.getCategory());
			pstmt.setString(2, '%'+search+'%');
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				total = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return total;
	}
		
		
		
		
}
