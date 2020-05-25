package team2.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Vector;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import team2.order.db.OrderDTO;
import team2.product.db.ProductDTO;

public class MemberDAO {

	//아래는 싱글톤 클래스를 만들기 위한 코드이다.
	private static MemberDAO obj;
	public MemberDAO(){}
		
	public static MemberDAO getInstance(){
		if(obj == null)
			obj = new MemberDAO();
		return obj;
	}
	
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
	// 데이터 베이스에 접속하고 그 결과를 리턴한는 메서드
	// ID중복체크(리턴 메서드)
	public boolean connect(){
		try{
			Context init = new InitialContext();
			DataSource ds = 
					(DataSource)init.lookup("java:comp/env/jdbc/team2");
			con = ds.getConnection();
			return true;
		}catch(Exception e){
			return false;
		}
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
			con = getConnection();
			sql="insert into team2_member values(?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			pstmt.setString(2, mdto.getPass());
			pstmt.setString(3, mdto.getName());
			pstmt.setString(4, mdto.getPhone());
			pstmt.setString(5, mdto.getZipcode());
			pstmt.setString(6, mdto.getAddr1());
			pstmt.setString(7, mdto.getAddr2());
			pstmt.setString(8, mdto.getEmail());
			pstmt.setInt(9, 2000);
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
	}
	// insertMember(mdto)
	
	// 회원가입시 +2000포인트 주는 함수
	public int insertMemberPoint(MemberDTO mdto){
		int check = 0;
		int num = 0;
		try {
			con = getConnection();
			sql="select * from team2_dailypointcheck where id = ? and point_description = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			pstmt.setString(2, "회원가입");
			
			rs = pstmt.executeQuery();
			
			//포인트 Table에 회원가입으로 포인트를 받은적이 있으면
			if(rs.next()){
				check = -1;
			}
			//포인트를 받은적이 없으면
			else{
				sql = "select max(num) from team2_dailypointcheck";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					num = rs.getInt(1) + 1;
				}
				
				sql = "insert into team2_dailypointcheck values(?, ?, ?, ?, now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, mdto.getId());
				pstmt.setInt(3, 2000);
				pstmt.setString(4, "회원가입");
				pstmt.executeUpdate();
				check = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		return check;
	}
	
	// idCheck(id,pass)
	public int idCheck(String id, String pass, String time_now){
		int mileage = 0;
		int check = -1;
		int num = 0;
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		String sql2 = "";
		
		try {
			con = getConnection();
			sql="select pass from team2_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			//Member DB에 아이디가 존재하면
			if(rs.next()){
				//아이디와 비밀번호가 같으면
				if(pass.equals(rs.getString("pass"))){
					
					sql = "select * from team2_dailypointcheck where id = ? and point_description = ? and date = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, "로그인");
					pstmt.setString(3, time_now);
					rs = pstmt.executeQuery();
					
					//team2_dailypointcheck DB에 같은날짜의 로그인 포인트가 있으면
					if(rs.next()){
						check = 2;
					}
					//team2_dailypointcheck DB에 같은날짜의 로그인 포인트가 없으면
					else{
						//team2_member 테이블에 mileage 추가
						sql = "select max(mileage) from team2_member where id = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						
						if(rs.next()){
							mileage = rs.getInt(1) + 100;
						}
						
						sql = "update team2_member set mileage = ? where id = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, mileage);
						pstmt.setString(2, id);
						pstmt.executeUpdate();
					
						//team2_dailypointcheck 테이블에 로그인 포인트 내용 추가
						sql2 = "select max(num) from team2_dailypointcheck";
						pstmt2 = con.prepareStatement(sql2);
						rs2 = pstmt2.executeQuery();
						
						if(rs2.next()){
							num = rs2.getInt(1) + 1;
						}
						
						sql2 = "insert into team2_dailypointcheck values(?, ?, ?, ?, now())";
						pstmt2 = con.prepareStatement(sql2);
						pstmt2.setInt(1, num);
						pstmt2.setString(2, id);
						pstmt2.setInt(3, 100);
						pstmt2.setString(4, "로그인");
						pstmt2.executeUpdate();
						
						check = 1;
					}
				}else{
					check = 0;
				}
			}
			//아이디가 존재하지 않으면
			else{			
				check = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return check;
	}
	// idCheck(id,pass)
	
	// confirmId(id)
	//아이디 중복 체크 해주는 메서드
		//중복되는 ID가 존재하는 경우 true
	public boolean confirmId(String id){
			
		String sql = null;
		boolean result = false;
			
		try{
			if(connect()){
				sql = "select id from team2_member where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
						
				if(rs.next()){
					result = true;  
				}
			}			
	 }catch(Exception e){
	System.out.println("아이디 가져오기 실패:" + e.getMessage());
	 }finally{
	  closeDB();
	 }
			
	 return result;
	   }
	// confirmId(id)
	
	// getMember(id)
	public MemberDTO getMember(String id){
		MemberDTO mdto = null;
		
		try {
			con = getConnection();
			sql = "select * from team2_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				mdto = new MemberDTO();
				mdto.setId(rs.getString("id"));
				mdto.setPass(rs.getString("pass"));
				mdto.setName(rs.getString("name"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setZipcode(rs.getString("zipcode"));
				mdto.setAddr1(rs.getString("addr1"));
				mdto.setAddr2(rs.getString("addr2"));
				mdto.setEmail(rs.getString("email"));
				mdto.setMileage(rs.getInt("mileage"));
				mdto.setReg_date(rs.getDate("reg_date"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return mdto;
	}
	// getMember(id)
	
	// updateMember(mdto)
	public int updateMember(MemberDTO mdto){
		int check = -1;
		
		try {
			con = getConnection();
			sql ="select pass from team2_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mdto.getId());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(mdto.getPass().equals(rs.getString("pass"))){
					sql ="update team2_member set name=?,phone=?,zipcode=?,addr1=?,addr2=?,email=? where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, mdto.getName());
					pstmt.setString(2, mdto.getPhone());
					pstmt.setString(3, mdto.getZipcode());
					pstmt.setString(4, mdto.getAddr1());
					pstmt.setString(5, mdto.getAddr2());
					pstmt.setString(6, mdto.getEmail());
					pstmt.setString(7, mdto.getId());
					
					pstmt.executeUpdate();
					
					check = 1;
					
					
					
				}else{
					check = 0;
				}
			}else{
				check = -1;
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeDB();
		}
		
		return check;
	}
	// updateMember(mdto)
	
	// deleteMember(id,pass)
	public int deleteMember(String id,String pass){
		int check = -1;
		
		try {
			// 1,2
			con = getConnection();
			// 3 sql
			sql = "select pass from team2_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			// 4 실행
			rs = pstmt.executeQuery();
			
			// 5 rs 비교 처리
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 3 sql
					sql="delete from team2_member where id=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					
					// 4 실행
					pstmt.executeUpdate();
					
					check = 1;					
				}else{
				   check = 0;	
				}				
			}else{
				check = -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}		
		return check;
	}
	// deleteMember(id,pass)
	
	// getMemberList()
	public List<MemberDTO> getMemberList(){
		
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try {
			// 1,2
			con = getConnection();
			// 3 sql
			sql = "select * from team2_member";
			pstmt = con.prepareStatement(sql);
			
			// 4 실행 
			rs = pstmt.executeQuery();
			
			// 5  rs 값 비교
		    while(rs.next()){
		    	
		    	MemberDTO mdto = new MemberDTO();
		    	
				mdto.setId(rs.getString("id"));
				mdto.setPass(rs.getString("pass"));
				mdto.setName(rs.getString("name"));
				mdto.setPhone(rs.getString("phone"));
				mdto.setZipcode(rs.getString("zipcode"));
				mdto.setAddr1(rs.getString("addr1"));
				mdto.setAddr2(rs.getString("addr2"));
				mdto.setEmail(rs.getString("email"));
				mdto.setReg_date(rs.getDate("reg_date"));
		    	
		    	//  한사람의 정보를  memberList배열에 한칸으로 저저장
		    	memberList.add(mdto);
		    }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return memberList;
	}
	// getMemberList()
	
	// findID(email)
	public int findID(String email){
		int check = -1;
		
		try {
			con = getConnection();
			sql = "select id from team2_member where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				String id = rs.getString("id");
				Thread t1 = new Thread(new Runnable(){

					@Override
					public void run() {
						String host = "smtp.gmail.com";
						final String user = "wjdckdgus500";
						final String password = "eksxp200";
						
						// 세션
						Properties props = new Properties();
						props.put("mail.smtp.host", host);
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.starttls.enable", "true");
						
						Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(user, password);
							}
						});
					try{
						MimeMessage message = new MimeMessage(session);
						message.setFrom(new InternetAddress(user));
						message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
						
						// Subject
						message.setSubject("[Subject] 회원 정보 확인 메일입니다.");

						// Text
						message.setText("회원님의 아이디는 "+id+"입니다.\n 갈라파고스 페이지 이동.\n http://localhost:8088/Team2/MemberLogin.me");

						// send the message
						Transport.send(message);
						System.out.println("message sent successfully...");
					} catch (MessagingException e) {
						e.printStackTrace();
					}
				}
			});
			
			check=1;
			t1.start();
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return check;
	}
	// findID(email)
	
	// findPW(email,id)
	public int findPW(String email,String id){
		int check = -1;
		
		try {
			con = getConnection();
			sql="select id from team2_member where email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()){
				if(id.equals(rs.getString("id"))){
					//ID 정보 확인 완료
					Thread t1 = new Thread(new Runnable() {
						
						@Override
						public void run() {
							String host = "smtp.gmail.com";
							final String user = "wjdckdgus500";
							final String password = "eksxp200";


							// Get the session object
							Properties props = new Properties();
							props.put("mail.smtp.host", host);
							props.put("mail.smtp.auth", "true");
							props.put("mail.smtp.starttls.enable","true");

							Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
								protected PasswordAuthentication getPasswordAuthentication() {
									return new PasswordAuthentication(user, password);
								}
							});

							// Compose the message
							try {
								MimeMessage message = new MimeMessage(session);
								message.setFrom(new InternetAddress(user));
								message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

								// Subject
								message.setSubject("[Subject] 회원 정보 확인 메일입니다.");

								// Text
								message.setText(id+"회원님의 패스워드 변경 페이지로 이동합니다.\n 해당 링크를 클릭하여 비밀번호 변경페이지로 이동해 주세요.\n http://localhost:8088/Team2/ChangePass.me?id="+id);

								// send the message
								Transport.send(message);
								System.out.println("message sent successfully...");
							} catch (MessagingException e) {
								e.printStackTrace();
							}
						}
					});
					
					check=1;
					t1.start();
				}else{
					//유효한 정보가 아님
					check=0;
				}
			}else{
				//정보가 존재하지 않습니다.
				check=-1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}	
	// findPW(email,id)
	
	// changePass(id,pass)
	public void changePass(String id,String pass){
		try {
			con=getConnection();
			sql="update team2_member set pass=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pass);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			System.out.println("비밀번호 변경 완료!");
		} catch (Exception e) {
			System.out.println("비밀번호 변경 실패!");
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	// changePass(id,pass)
	
	
	
	// 주문 정보 모두 가져오는 함수 
	// (orderListAction getOrderList 사용)
	public Vector getMemberOrderList(String o_m_id) {
		
		Vector vec = new Vector();
		
		ArrayList orderList = new ArrayList();
		
		//상품(동물 + 물건)정보 저장
		ArrayList productInfoList = new ArrayList();
		
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			con = getConnection();
			// 본인의 정보만 가지고이동, o_trade_num기준으로 내림차순 정렬
			sql = "select * from team2_order where o_m_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_m_id);
			rs = pstmt.executeQuery();

			while(rs.next()) {
				OrderDTO odto = new OrderDTO();
				odto.setO_trade_num(rs.getString("o_trade_num"));
				odto.setO_p_code(rs.getString("o_p_code"));
				odto.setO_p_amount(rs.getInt("o_p_amount"));
				odto.setO_p_option(rs.getString("o_p_option"));
				odto.setO_p_delivery_method(rs.getString("o_p_delivery_method"));
				
				odto.setO_receive_name(rs.getString("o_receive_name"));
				odto.setO_receive_zipcode(rs.getString("o_receive_zipcode"));
				odto.setO_receive_addr1(rs.getString("o_receive_addr1"));
				odto.setO_receive_addr2(rs.getString("o_receive_addr2"));
				odto.setO_receive_mobile(rs.getString("o_receive_mobile"));
				odto.setO_receive_phone(rs.getString("o_receive_phone"));
				odto.setO_memo(rs.getString("o_memo"));
				
				odto.setO_sum_money(rs.getInt("o_sum_money"));
				odto.setO_trade_type(rs.getString("o_trade_type"));
				odto.setO_trade_payer(rs.getString("o_trade_payer"));
				odto.setO_trade_date(rs.getDate("o_trade_date"));
				
				odto.setO_trans_num(rs.getString("o_trans_num"));
				odto.setO_date(rs.getDate("o_date"));
				odto.setO_status(rs.getInt("o_status"));
				orderList.add(odto);
	
				//b_code 값들 중에 맨 앞글자 따오기
				char first_letter = rs.getString("o_p_code").charAt(0);
				
				//만약 b_code의 앞에 한글자가 a이면 동물 DB로 들어가기
				if(first_letter == 'a'){
					// 각각의 장바구니에 해당하는 상품 정보 저장
					sql ="select * from team2_animals where a_code = ?";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("a_thumbnail"));	
						pdto.setProduct_name(rs2.getString("a_morph"));
						pdto.setProduct_price_sale(rs2.getInt("a_price_sale"));
						pdto.setProduct_mileage(rs2.getInt("a_mileage"));
						pdto.setProduct_discount_rate(rs2.getInt("a_discount_rate"));
						pdto.setProduct_price_origin(rs2.getInt("a_price_origin"));
						pdto.setProduct_amount(rs2.getInt("a_amount"));
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
				//만약 b_code의 앞에 한글자가 g이면 상품 DB로 들어가기
				else if(first_letter == 'g'){
					// 각각의 장바구니에 해당하는 상품 정보 저장	
					sql ="select * from team2_goods where g_code = ? and g_option = ?";	
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setString(1, odto.getO_p_code());
					pstmt2.setString(2, odto.getO_p_option());
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()){	
						ProductDTO pdto = new ProductDTO();
						pdto.setProduct_thumbnail(rs2.getString("g_thumbnail"));
						pdto.setProduct_name(rs2.getString("g_name"));
						pdto.setProduct_price_sale(rs2.getInt("g_price_sale"));
						pdto.setProduct_mileage(rs2.getInt("g_mileage"));
						pdto.setProduct_discount_rate(rs2.getInt("g_discount_rate"));
						pdto.setProduct_price_origin(rs2.getInt("g_price_origin"));
						pdto.setProduct_amount(rs2.getInt("g_amount"));
						pdto.setProduct_option_price(rs2.getInt("g_option_price"));
						pdto.setCategory(rs2.getString("category"));
						productInfoList.add(pdto); // 상품정보 하나를 리스트 한칸에 저장
					}
				}
			}
			vec.add(0, orderList);
			vec.add(1, productInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		return vec;
	}
	
	//주문 상태 확인
	public List getStatusMember(String o_m_id){
		ArrayList checkList = new ArrayList();
		
		try {
			con = getConnection();
			
			sql = "select o_status from team2_order where o_m_id = ? group by o_trade_num";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_m_id);

			rs = pstmt.executeQuery();
			
			while(rs.next()){
				OrderDTO odto = new OrderDTO();				
				odto.setO_status(rs.getInt("o_status"));
				checkList.add(odto);
			}
			
			System.out.println("checkList = " +checkList);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return checkList;
	}
	
	public int getStatusMember(String o_m_id, String o_trade_num){
		int check = 0;
		
		try {
			con = getConnection();
			
			sql = "select o_status from team2_order where o_m_id = ? AND o_trade_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, o_m_id);
			pstmt.setString(2, o_trade_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				check = rs.getInt(1);
			}
			
			System.out.println("check = " +check);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return check;
	}
	
	public int countCoupons(String id){
		int countCouponNum = 0;
		
		try {
			con = getConnection();
			
			sql = "SELECT count(co_num) FROM team2_project.team2_coupon_member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				countCouponNum = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return countCouponNum;

	}

	
	public List<MemberPointDTO> getMileage(String id){
		List<MemberPointDTO> pointList = new ArrayList<MemberPointDTO>();
		
		try {
			con = getConnection();
			sql = "select * from team2_dailypointcheck where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberPointDTO mpdto = new MemberPointDTO();
				mpdto.setId(rs.getString("id"));
				mpdto.setPoint(rs.getInt("point"));
				mpdto.setPoint_description(rs.getString("point_description"));
				mpdto.setDate(rs.getDate("date"));
				
				pointList.add(mpdto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
		
		return pointList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
		
}
