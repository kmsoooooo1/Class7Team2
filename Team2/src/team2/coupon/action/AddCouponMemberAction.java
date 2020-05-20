package team2.coupon.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import team2.coupon.db.CouponDAO;
import team2.couponMember.db.CouponMemberDTO;


public class AddCouponMemberAction  implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		// 로그인 정보 없을 시 로그인페이지로 이동
		HttpSession session = request.getSession();
		
		//id값
		String id = (String)session.getAttribute("id");
		
		CouponMemberDTO cmdto = new CouponMemberDTO();
		
		//넘어온 값 받기
		cmdto.setId(id);
		cmdto.setCo_num(Integer.parseInt(request.getParameter("c_num")));
	
		CouponDAO cdao = new CouponDAO();
		int check = cdao.insertCouponMember(cmdto);
		
		return null;
	}
	
}
