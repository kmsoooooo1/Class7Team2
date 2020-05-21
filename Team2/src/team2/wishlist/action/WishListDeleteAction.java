package team2.wishlist.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.wishlist.db.WishlistDAO;
import team2.wishlist.db.WishlistDTO;


public class WishListDeleteAction implements Action{

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
		
		//넘어온 값 WishlistDTO 객체에 저장
		WishlistDTO wldto = new WishlistDTO();
		
		wldto.setW_code(request.getParameter("w_code"));
		
		WishlistDAO wldao = new WishlistDAO();
		wldao.deleteWishList(wldto);
		
		
		return null;
	}
	
	
}
