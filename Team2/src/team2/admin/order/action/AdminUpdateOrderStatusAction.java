package team2.admin.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.order.db.OrderDAO;

public class AdminUpdateOrderStatusAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 정보 없을 시 로그인페이지로 이동
		HttpSession session = request.getSession();
		
		//id값
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		//넘어온 값 가져오기
		String o_trade_num = request.getParameter("o_trade_num");
		String o_trans_num = request.getParameter("o_trans_num"); //운송장 번호

		OrderDAO adao = new OrderDAO();
		
		adao.updateOrderStatus(o_trade_num, o_trans_num);
		
		
		return null;
	}
	
}
