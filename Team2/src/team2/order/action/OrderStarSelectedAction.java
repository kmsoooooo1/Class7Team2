package team2.order.action;

import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.basket.db.BasketDAO;
import team2.basket.db.BasketDTO;
import team2.member.db.MemberDAO;
import team2.member.db.MemberDTO;

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
		
		request.setCharacterEncoding("UTF-8");
		
		//넘어온 코드들
		String selectedCodes = request.getParameter("seletedCodes");
		
		//넘어온 옵션들
		String selectedOptions = request.getParameter("selectedOptions");
		if(selectedOptions == null){
			selectedOptions = "";
		}
		
		//넘어온 배송방법들
		String selectedDeliveryMethods = request.getParameter("selectedDeliveryMethods");
		
		// split()을 이용해 ','를 기준으로 문자열을 자른다.
        // split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
		String splitSeletedCodes[] = selectedCodes.split(",");
		String splitSelectedOptions[] = selectedOptions.split(",");
		String splitSelectedDeliveryMethods[] = selectedDeliveryMethods.split(",");
		
		BasketDTO bdto = new BasketDTO();
		
		//장바구니 안에 있는 상품정보 가져오기 --------------------------------
		BasketDAO bdao = new BasketDAO();
		
		Vector temp_array = new Vector();
		
		Vector vec = new Vector();
		
		for(int i=0; i<splitSeletedCodes.length-1; i++){
			bdto.setB_code(splitSeletedCodes[i].trim());
			bdto.setB_option(splitSelectedOptions[i].trim());
			bdto.setB_delivery_method(splitSelectedDeliveryMethods[i].trim());

			temp_array = bdao.getBasketList(id, bdto);
			vec.add(temp_array);
		}
		
		Vector basketInfoList = new Vector();
		
		ArrayList basketList = new ArrayList();
		ArrayList productInfoList = new ArrayList();
		
		for(int i=0; i<splitSeletedCodes.length-1; i++){
			basketInfoList = (Vector) vec.get(i);
			
			basketList.add(basketInfoList.get(0));
			productInfoList.add(basketInfoList.get(1));
		}
		
		System.out.println(basketList);
		System.out.println(productInfoList);
		
		request.setAttribute("basketList", basketList);
		request.setAttribute("productInfoList", productInfoList);
		
		//주문하는 사용자 정보 가져오기 ------------------------------------
		MemberDAO mdao = new MemberDAO();
		
		//로그인 한 사용자의 정보
		MemberDTO mdto = mdao.getMember(id);
		
		request.setAttribute("memberDTO", mdto);
		
		forward.setPath("./order/product_buy.jsp");
		forward.setRedirect(false); //forwarding 해야한다.
		return forward;	
	}

}
