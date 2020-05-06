package team2.basket.action;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.basket.db.BasketDAO;

public class BasketListAction implements Action {

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
		
		// BasketDAO 객체 생성
		BasketDAO bkdao = new BasketDAO();
		
		// 장바구니 리스트를 가져와서 저장
		Vector vec = bkdao.getBasketList(id);
		
		// 해당 정보를 request에 저장
		ArrayList basketList = (ArrayList)vec.get(0);
		ArrayList animalList = (ArrayList)vec.get(1);
		
		request.setAttribute("basketList", basketList);
		request.setAttribute("animalList", animalList);
		
		forward.setPath("./order/animal_basket.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
