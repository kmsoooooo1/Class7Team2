package team2.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class OrderStarSelectedAction implements Action {
	
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
		
		String jsonData = request.getParameter("jsonData");
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonData);
		
		System.out.println(jsonObject.get("b_code"));
		
		//장바구니 안에 있는 상품정보 가져오기 --------------------------------
		//BasketDAO bdao = new BasketDAO();
		
		//장바구니 리스트를 가져와서 저장
		//Vector vec = bdao.getBasketList(id);
		
		// 해당 정보를 request에 저장
		//ArrayList basketList = (ArrayList)vec.get(0);
		//ArrayList productInfoList = (ArrayList)vec.get(1); //상품(동물 + 물건)정보 저장
		
		//request.setAttribute("basketList", basketList);
		//request.setAttribute("productInfoList", productInfoList);
		
		//주문하는 사용자 정보 가져오기 ------------------------------------
		//MemberDAO mdao = new MemberDAO();
		
		//로그인 한 사용자의 정보
		//MemberDTO mdto = mdao.getMember(id);
		
		//request.setAttribute("memberDTO", mdto);
		
		//forward.setPath("./order/product_buy.jsp");
		//forward.setRedirect(false); //forwarding 해야한다.
		//return forward;
		
		return null;
	}

}
