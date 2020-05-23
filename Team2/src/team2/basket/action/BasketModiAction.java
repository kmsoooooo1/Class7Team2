package team2.basket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.basket.db.BasketDAO;
import team2.basket.db.BasketDTO;

public class BasketModiAction implements Action{

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
		
		//넘어온 값 BasketDTO 객체에 저장하기
		BasketDTO bdto = new BasketDTO();
		
		bdto.setB_amount(Integer.parseInt(request.getParameter("b_amount")));
		bdto.setB_code(request.getParameter("b_code"));
		bdto.setB_option(request.getParameter("b_option"));
		bdto.setB_delivery_method(request.getParameter("b_delivery_method"));
		
		//BasketDAO() 객체 생성
		BasketDAO bdao = new BasketDAO();
		
		//수정할 메서드 불러오기
		bdao.modiAmount(bdto);
		
		return null;
	}
	
}
