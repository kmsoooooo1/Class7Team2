package team2.basket.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.basket.db.BasketDAO;

public class BasketModiAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//넘어온 값 받기 
		int new_amount = Integer.parseInt(request.getParameter("b_amount"));
		String b_code = request.getParameter("b_code");
		String b_option = (String) request.getParameter("b_option");
		String b_delivery_method = (String) request.getParameter("b_delivery_method");
		
		ActionForward forward = new ActionForward();
		
		//BasketDAO() 객체 생성
		BasketDAO bdao = new BasketDAO();
		
		//수정할 메서드 불러오기
		bdao.modiAmount(b_code, b_option, b_delivery_method, new_amount);

		//페이지 이동
		forward.setPath("BasketList.ba");
		forward.setRedirect(false); //주소가 바뀌지 않고 리스트 정보는 바껴야 하기 때문에
		return forward;
	}
	
}
