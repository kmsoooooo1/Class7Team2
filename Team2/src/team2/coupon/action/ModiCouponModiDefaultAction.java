package team2.coupon.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.coupon.db.CouponDAO;

public class ModiCouponModiDefaultAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//넘어온 값 저장하기
		String id = request.getParameter("id");
		int co_num = Integer.parseInt(request.getParameter("co_num"));
		
		//장바구니 DB에 가서 임시로 used 해두기
		CouponDAO cdao = new CouponDAO();
		cdao.modiCo_num(id, co_num);
		
		return null;
	}

}
