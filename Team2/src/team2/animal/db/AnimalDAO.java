package team2.animal.db;

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
import team2.admin.animal.action.AnimalListAction;

import team2.animal.action.aSet;
import team2.board.action.Criteria;
import team2.board.db.ProductDTO;

public class AnimalDAO {
	
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
			sql = "insert into team2_animals values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, adto.getCategory());
			pstmt.setString(3, adto.getSub_category());
			pstmt.setString(4, adto.getSub_category_index());
			pstmt.setString(5, adto.getA_morph());
			pstmt.setString(6, adto.getA_sex());
			pstmt.setString(7, adto.getA_status());
			pstmt.setString(8, adto.getA_code());
			pstmt.setString(9, adto.getA_thumbnail());
			pstmt.setInt(10, adto.getA_amount());
			pstmt.setInt(11, adto.getA_price_origin());
			pstmt.setInt(12, adto.getA_discount_rate());
			pstmt.setInt(13, adto.getA_price_sale());
			pstmt.setInt(14, adto.getA_mileage());
			pstmt.setString(15, adto.getContent());
			pstmt.setInt(16, 0);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	//동물 리스트 가져오는 함수 
	public List<AnimalDTO> getAnimalList(String category, String sub_category, String sub_category_index) {
		List<AnimalDTO> animalList = new ArrayList<AnimalDTO>();
		try {
			con = getConnection();
			
			//StringBuffer: 저장공간(메모리)
			StringBuffer SQL = new StringBuffer();
			
			//SQL buffer 안에 sql 구문 넣어주기
			
			//만약 category가 all이고 sub_category가 없고 sub_category_index도 없을때(관리자 페이지에서 모든 동물을 부를때)
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){
				SQL.append("select * from team2_animals order by num desc");
			}
			//만약 category가 파충류이면
			else if(category.equals("파충류")){
				SQL.append("select * from team2_animals where category = '파충류' ");
				//만약 sub_category가 없으면
				if(sub_category.equals("all")) {
					SQL.append("order by num desc");
				}
				//만약 sub_category가 있으면
				else {
					SQL.append("AND sub_category = ? ");
					//만약 sub_category_index가 없으면
					if(sub_category_index.equals("all")){
						SQL.append("order by num desc");
					}
					//만약 sub_category_index가 있으면
					else {
						SQL.append("AND sub_category_index = ? order by num desc");
					}
				}
			}else if(category.equals("양서류")){
				SQL.append("select * from team2_animals where category = '양서류'");
				//만약 sub_category가 없으면	
				if(sub_category.equals("all")) {
					SQL.append("order by num");
				}
				//만약 sub_category가 있으면
				else {
					SQL.append("AND sub_category = ? order by num desc");
				}
			}
			
			pstmt = con.prepareStatement(SQL.toString());
			
			//?에 값 지정하기
			if(category.equals("all") && sub_category.equals("") && sub_category_index.equals("")){
			}
			else if(category.equals("파충류")){
				if(sub_category.equals("all")) {
				}
				else {
					pstmt.setString(1, sub_category);
					if(sub_category_index.equals("all")){
					}
					else {
						pstmt.setString(2, sub_category_index);
					}
				}
			}else if(category.equals("양서류")){
				if(sub_category.equals("all")) {
				}
				else {
					pstmt.setString(1, sub_category);
				}
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//동물이 존재하면
				AnimalDTO adto = new AnimalDTO();
				adto.setNum(rs.getInt("num"));
				adto.setCategory(rs.getString("category"));
				adto.setSub_category(rs.getString("sub_category"));
				adto.setSub_category_index(rs.getString("sub_category_index"));
				adto.setA_morph(rs.getString("a_morph"));
				adto.setA_sex(rs.getString("a_sex"));
				adto.setA_status(rs.getString("a_status"));
				adto.setA_code(rs.getString("a_code"));
				adto.setA_thumbnail(rs.getString("a_thumbnail"));
				adto.setA_amount(rs.getInt("a_amount"));
				adto.setA_price_origin(rs.getInt("a_price_origin"));
				adto.setA_discount_rate(rs.getInt("a_discount_rate"));
				adto.setA_price_sale(rs.getInt("a_price_sale"));
				adto.setA_mileage(rs.getInt("a_mileage"));
				adto.setContent(rs.getString("content"));
				adto.setA_view_count(rs.getInt("a_view_count"));
				adto.setDate(rs.getDate("date"));
				animalList.add(adto);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return animalList;
	}
	
	//동물페이지 조회수 1업 시키는 함수
	public void updateAnimalViewCount(String a_code){    	
    	try {
			con = getConnection();
			sql = "update team2_animals set a_view_count = a_view_count + 1 where a_code=?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a_code);
			pstmt.executeUpdate();
		}
    	catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
    }
	
	//동물 상세 정보 가져오는 함수
	public AnimalDTO getAnimalDetail(String a_code) {
		AnimalDTO adto = null;
		try {
			con = getConnection();
			sql = "select * from team2_animals where a_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, a_code);
			rs = pstmt.executeQuery();	
			if(rs.next()) {
				adto = new AnimalDTO();
				//만약 동물이 DB에 있다면
				adto.setCategory(rs.getString("category"));
				adto.setSub_category(rs.getString("sub_category"));
				adto.setSub_category_index(rs.getString("sub_category_index"));
				adto.setA_morph(rs.getString("a_morph"));
				adto.setA_sex(rs.getString("a_sex"));
				adto.setA_status(rs.getString("a_status"));
				adto.setA_code(rs.getString("a_code"));
				adto.setA_thumbnail(rs.getString("a_thumbnail"));
				adto.setA_amount(rs.getInt("a_amount"));
				adto.setA_price_origin(rs.getInt("a_price_origin"));
				adto.setA_discount_rate(rs.getInt("a_discount_rate"));
				adto.setA_price_sale(rs.getInt("a_price_sale"));
				adto.setA_mileage(rs.getInt("a_mileage"));
				adto.setContent(rs.getString("content"));
				adto.setA_view_count(rs.getInt("a_view_count"));
				adto.setDate(rs.getDate("date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return adto;
	}

	public List<ProductDTO> searchKeyword(String keyword){
		
		List<ProductDTO> list = new ArrayList<>();
		String sql = "select * from team2_animals where a_morph like '%" + keyword +"%'";
		System.out.println(sql);
		try {
			con = getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				ProductDTO dto = new ProductDTO(rs.getString("a_code"));
				dto.setCategory(rs.getString("category"));
				dto.setSub_category(rs.getString("sub_category"));
				dto.setSub_category_idx(rs.getString("sub_category_index"));
				dto.setName(rs.getString("a_morph"));
				dto.setImg_src(rs.getString("a_thumbnail"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public List ImageNew (){
		
		List<AnimalDTO> animalList = new ArrayList<AnimalDTO>();
	
		String sql = "select * from team2_animals order by num desc limit 0,16";
		try {
			con = getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				//동물이 존재하면
				AnimalDTO adto = new AnimalDTO();
				adto.setNum(rs.getInt("num"));
				adto.setCategory(rs.getString("category"));
				adto.setSub_category(rs.getString("sub_category"));
				adto.setSub_category_index(rs.getString("sub_category_index"));
				adto.setA_morph(rs.getString("a_morph"));
				adto.setA_sex(rs.getString("a_sex"));
				adto.setA_status(rs.getString("a_status"));
				adto.setA_code(rs.getString("a_code"));
				adto.setA_thumbnail(rs.getString("a_thumbnail"));
				adto.setA_amount(rs.getInt("a_amount"));
				adto.setA_price_origin(rs.getInt("a_price_origin"));
				adto.setA_discount_rate(rs.getInt("a_discount_rate"));
				adto.setA_price_sale(rs.getInt("a_price_sale"));
				adto.setA_mileage(rs.getInt("a_mileage"));
				adto.setContent(rs.getString("content"));
				adto.setA_view_count(rs.getInt("a_view_count"));
				adto.setDate(rs.getDate("date"));
				animalList.add(adto);
			}	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		
		return animalList;
		
	}
	
	
	
	public int getAnimalCount(aSet aset){
		
		int total = 0;
		
		
		sql = "select count(*) from team2_animals where category like ? "
				+ "AND sub_category like ? AND sub_category_index like ?";
		
		try {

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, '%'+aset.getCategory());
			pstmt.setString(2, '%'+aset.getSub_category());
			pstmt.setString(3, '%'+aset.getSub_category_index());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				total = rs.getInt(1);
			}
			System.out.println("DB total : " + total);
					
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		
		return total;
		
	}
	
	
	public List<AnimalDTO> getAnimalPage(aSet aset, Criteria cri){
		
		List<AnimalDTO> animalList = new ArrayList<AnimalDTO>();
		try {
			
			sql = "select * from team2_animals where category like ? "
					+ "AND sub_category like ? AND sub_category_index like ? "
					+ "order by num desc limit ?,?";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, '%'+aset.getCategory());
			pstmt.setString(2, '%'+aset.getSub_category());
			pstmt.setString(3, '%'+aset.getSub_category_index());
			pstmt.setInt(4, cri.getPageStart());
			pstmt.setInt(5, cri.getPerpageNum());

			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				//동물이 존재하면
				AnimalDTO adto = new AnimalDTO();
				adto.setNum(rs.getInt("num"));
				adto.setCategory(rs.getString("category"));
				adto.setSub_category(rs.getString("sub_category"));
				adto.setSub_category_index(rs.getString("sub_category_index"));
				adto.setA_morph(rs.getString("a_morph"));
				adto.setA_sex(rs.getString("a_sex"));
				adto.setA_status(rs.getString("a_status"));
				adto.setA_code(rs.getString("a_code"));
				adto.setA_thumbnail(rs.getString("a_thumbnail"));
				adto.setA_amount(rs.getInt("a_amount"));
				adto.setA_price_origin(rs.getInt("a_price_origin"));
				adto.setA_discount_rate(rs.getInt("a_discount_rate"));
				adto.setA_price_sale(rs.getInt("a_price_sale"));
				adto.setA_mileage(rs.getInt("a_mileage"));
				adto.setContent(rs.getString("content"));
				adto.setA_view_count(rs.getInt("a_view_count"));
				adto.setDate(rs.getDate("date"));
				animalList.add(adto);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return animalList;
	}
	

}
