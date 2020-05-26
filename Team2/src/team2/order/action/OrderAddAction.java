package team2.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.coupon.db.CouponDAO;
import team2.couponMember.db.CouponMemberDTO;
import team2.order.db.OrderDAO;
import team2.order.db.OrderDTO;

public class OrderAddAction implements Action{

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
		
		//한글처리
		request.setCharacterEncoding("UTF-8");
		
		//넘어온 코드들
		String selectedCodes = request.getParameter("selectedCodes");
		
		//넘오온 수량들
		String selectedAmounts = request.getParameter("selectedAmounts");
		
		//넘어온 옵션들
		String selectedOptions = request.getParameter("selectedOptions");
		if(selectedOptions == null){
			selectedOptions = "";
		}
		
		//넘어온 배송방법들
		String selectedDeliveryMethods = request.getParameter("selectedDeliveryMethods");
		
		String selected_co_num_list = request.getParameter("selected_co_num_list");
		
		// split()을 이용해 ','를 기준으로 문자열을 자른다.
        // split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
		String splitSeletedCodes[] = selectedCodes.split(",");
		String splitSelectedAmounts[] = selectedAmounts.split(",");
		String splitSelectedOptions[] = selectedOptions.split(",");
		String splitSelectedDeliveryMethods[] = selectedDeliveryMethods.split(",");
		String splitSelected_co_num_list[] = selected_co_num_list.split(",");

		//장바구니 안에 있는 상품정보 가져오기 --------------------------------
//		BasketDAO bdao = new BasketDAO();
//		
//		ArrayList basketList_temp = new ArrayList();
//		
//		for(int i=0; i<splitSeletedCodes.length-1; i++){
//			BasketDTO bdto = new BasketDTO();
//			bdto.setId(id);
//			bdto.setB_code(splitSeletedCodes[i].trim());
//			bdto.setB_option(splitSelectedOptions[i].trim());
//			bdto.setB_delivery_method(splitSelectedDeliveryMethods[i].trim());
//
//			basketList_temp.add(bdto);
//		}
//		
//		ArrayList all_list = bdao.getBasketList(id, basketList_temp);
//		
//		ArrayList basketList = (ArrayList) all_list.get(0);
//		ArrayList productInfoList = (ArrayList) all_list.get(1);
//
//		request.setAttribute("basketList", basketList);
//		request.setAttribute("productInfoList", productInfoList);
		
		
		//수령하는 자 정보 저장하기 --------------------------------
		OrderDTO odto = new OrderDTO();
		OrderDAO odao = new OrderDAO();
		
		String o_trade_num = "";
		
		int max_O_Num = odao.find_MaxO_num(id);
		
		//구매하고자 하는 물건들 코드, 옵션들 저장하기
		for(int i=0; i<splitSeletedCodes.length-1; i++){
			odto.setO_p_code(splitSeletedCodes[i].trim());
			odto.setO_p_amount(Integer.parseInt(splitSelectedAmounts[i].trim()));
			odto.setO_p_option(splitSelectedOptions[i].trim());
			odto.setO_p_delivery_method(splitSelectedDeliveryMethods[i].trim());
			
			//배송지 정보 저장
			odto.setO_m_id(id);
			
			odto.setO_receive_name(request.getParameter("rece_name"));
			odto.setO_receive_mobile(request.getParameter("rece_phone"));
			odto.setO_receive_phone(request.getParameter("rece_number"));
			odto.setO_receive_zipcode(request.getParameter("rece_zipcode"));
			odto.setO_receive_addr1(request.getParameter("rece_addr1"));
			odto.setO_receive_addr2(request.getParameter("rece_addr2"));
			odto.setO_memo(request.getParameter("o_memo"));
			odto.setO_sum_money(Integer.parseInt(request.getParameter("o_sum_money_input")));
			
			//결제 정보 저장
			odto.setO_trade_type(request.getParameter("payment"));
			odto.setO_trade_payer(request.getParameter("o_trade_payer"));
		
			o_trade_num = odao.addOrder(odto, max_O_Num);
		}
	
		//쿠폰
		String co_num = request.getParameter("co_num");
		if(co_num == null){
			co_num = "";
		}
		
		for(int i=0; i<splitSelected_co_num_list.length-1; i++){
			CouponMemberDTO cmdto = new CouponMemberDTO();
			CouponDAO cdao = new CouponDAO();
			
			cmdto.setId(id);
			System.out.println(splitSelected_co_num_list[i].trim());
			cmdto.setCo_num(splitSelected_co_num_list[i].trim());
			
			cdao.deleteMemberCoupon(cmdto);
		}

		
		//적립금
		int mileage = Integer.parseInt(request.getParameter("use_My_Mileage"));
		
		
		//페이지 이동
		forward.setPath("./OrderComplete.or?o_trade_num=" + o_trade_num);
		forward.setRedirect(true);
		return forward;
	}
	
}
