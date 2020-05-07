package team2.basket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.basket.db.BasketDAO;
import team2.basket.db.BasketDTO;

public class BasketAddAction implements Action {

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
		
		request.setCharacterEncoding("UTF-8");
		
		BasketDTO bkdto = new BasketDTO();
		BasketDAO bkdao = new BasketDAO();
		
		//동물 또는 상품 코드
		String b_code = request.getParameter("product_code");
		
		//할인율
		int a_discount_rate = Integer.parseInt(request.getParameter("a_discount_rate"));
		//만약 할인율이 0이 아니면
		if(a_discount_rate != 0){
			int a_price_sale = Integer.parseInt(request.getParameter("a_price_sale"));
		}
		//만약 할인율이 0이면
		else {
			int a_price_origin = Integer.parseInt(request.getParameter("a_price_origin"));
		}
		
		//사용자가 추가한 배송방법 리스트 가지고 오기
		String selectedValues = request.getParameter("selectedValues");
		
		//사용자가 추가한 배송방법들의 수량들 리스트 가지고 오기
		String selectedAmounts = request.getParameter("selectedAmounts");
		
		// split()을 이용해 ','를 기준으로 문자열을 자른다.
        // split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
		String splitSelectedValues[] = selectedValues.split(",");
		String splitSelectedAmounts[] = selectedAmounts.split(",");
		
		for(int i=0; i<splitSelectedValues.length; i++){
			bkdto.setId(id);
			bkdto.setB_code(b_code);
			bkdto.setB_amount(splitSelectedAmounts[i]);
			bkdto.setB_option(splitSelectedValues[i]);
			
			//추가하기
			bkdao.basketAdd(bkdto);
		}
		
		forward.setPath("./BasketList.ba");
		forward.setRedirect(true);
		return forward;
	}

}
