package team2.wishlist.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.wishlist.db.WishlistDAO;
import team2.wishlist.db.WishlistDTO;


public class WishListAction implements Action{

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
		
		WishlistDAO wldao = new WishlistDAO();
		WishlistDTO wldto = new WishlistDTO();
		
		// 선택한 관심상품 가져와서 저장
		wldao.getWishlist(id);
		
		
		return null;
	}
	
}
