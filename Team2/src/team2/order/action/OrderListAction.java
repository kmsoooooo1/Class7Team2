package team2.order.action;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.order.db.OrderDAO;

public class OrderListAction implements Action{
	
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
		
		
		OrderDAO odao = new OrderDAO();
		
		Vector vec = odao.getOrderList(id);
		
		ArrayList orderList = (ArrayList) vec.get(0);
		ArrayList productInfoList = (ArrayList) vec.get(1);
		
		//request 영역에 저장
		request.setAttribute("orderList", orderList);
		request.setAttribute("productInfoList", productInfoList);
		
		forward.setPath("./order/order_list.jsp");
		forward.setRedirect(false); //forwarding 해야한다.
		return forward;
	}
		
	
	
}
