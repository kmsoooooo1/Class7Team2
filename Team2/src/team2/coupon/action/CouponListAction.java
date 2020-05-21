package team2.coupon.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.coupon.db.CouponDAO;
import team2.coupon.db.CouponDTO;

public class CouponListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		CouponDAO cdao = new CouponDAO();
		
		List<CouponDTO> couponList = cdao.getCouponsList();

		request.setAttribute("couponList", couponList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./event/coupon_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
