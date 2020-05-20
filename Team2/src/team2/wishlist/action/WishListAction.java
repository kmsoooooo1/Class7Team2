package team2.wishlist.action;

import java.util.ArrayList;
import java.util.Vector;

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
		Vector vec = wldao.getWishlist(id);
		
		// 해당 정보를 request에 저장
		ArrayList wishList = (ArrayList) vec.get(0);
		ArrayList productInfoList = (ArrayList) vec.get(1); // 상품(동물 + 물건) 정보 저장
		
		request.setAttribute("wishList", wishList);
		request.setAttribute("productInfoList", productInfoList);
		
		forward.setPath("./order/wish_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
