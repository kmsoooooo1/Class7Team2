package team2.basket.action;

import java.io.PrintWriter;

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

		//넘어온 값들의 수량들(b_amount)
		//사용자가 추가한 배송방법들의 수량들 리스트 가지고 오기
		String selectedAmounts = request.getParameter("selectedAmounts");
		
		//옵션(b_option)
		String selectedOptions = request.getParameter("selectedOptions");
		//동물페이지에서는 옵션이 없기 때문에 상품페이지에서 관리하면된다. 여기서는 DB에 임의적으로 넣어야 하기 때문에 적는거다.
		if(request.getParameter("selectedOptions") == null){
			selectedOptions = ""; //빈 공백 값을 넣는다.
		}
	
		//배송방법(b_delivery_method)
		//사용자가 추가한 배송방법 리스트 가지고 오기
		String selectedValues = request.getParameter("selectedValues");

		System.out.println(b_code);
		System.out.println(selectedAmounts);
		System.out.println(selectedOptions);
		System.out.println(selectedValues);
		
		// split()을 이용해 ','를 기준으로 문자열을 자른다.
        // split()은 지정한 문자를 기준으로 문자열을 잘라 배열로 반환한다.
		String splitSelectedValues[] = selectedValues.split(",");
		String splitSelectedAmounts[] = selectedAmounts.split(",");
		String splitSelectedOptions[] = selectedOptions.split(",");
		
		for(int i=0; i<splitSelectedAmounts.length-1; i++){
			bkdto.setId(id);
			bkdto.setB_code(b_code);
			bkdto.setB_amount(Integer.parseInt(splitSelectedAmounts[i].trim()));
			bkdto.setB_option(splitSelectedOptions[i].trim());
			bkdto.setB_delivery_method(splitSelectedValues[i].trim());
			
			//추가하기
			bkdao.basketAdd(bkdto);
		}
		
//		forward.setPath("./BasketList.ba");
//		forward.setRedirect(true);
//		return forward;
		
		return null;
	}

}
