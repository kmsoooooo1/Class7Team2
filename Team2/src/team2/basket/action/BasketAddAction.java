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
		
		
//		bkdto.setId(id);
//		bkdto.setB_code(request.getParameter("product_code"));
//		bkdto.setB_amount(Integer.parseInt(request.getParameter("a_amount")));
//		bkdto.setB_option(request.getParameter("delivary_method"));
		
		BasketDAO bkdao = new BasketDAO();
		
		// 기존의 장바구니에 상품이 있는지 체크
		int check = bkdao.checkGoods(bkdto);
		
		// 없을 경우 바구니에 추가
		if(check !=1){
			bkdao.basketAdd(bkdto);
		}
		
		
		forward.setPath("./BasketList.ba");
		forward.setRedirect(true);
		return forward;
	}

}
