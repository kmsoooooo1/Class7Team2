package team2.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.order.db.OrderDAO;

public class OrderModiStatusAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		//넘어온 값 받기
		
		String o_trade_num = request.getParameter("o_trade_num");

		OrderDAO odao = new OrderDAO();
		
		odao.modiStatus(o_trade_num);
		
		return null;
	}
	
}
