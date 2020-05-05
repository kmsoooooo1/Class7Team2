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
		String id = (String)session.getAttribute("id");
		ActionForward forward = new ActionForward();
		
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			return forward;
		}
		
		request.setCharacterEncoding("UTF-8");
		
		BasketDTO bkdto = new BasketDTO();
		
		bkdto.setB_code(request.getParameter("a_code"));
		bkdto.setId(id);
		bkdto.setB_amount(Integer.parseInt(request.getParameter("a_amount")));
		bkdto.setB_option(request.getParameter("delivery_method"));
		
		System.out.println("옵션 :"+ bkdto.getB_option());
		
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
