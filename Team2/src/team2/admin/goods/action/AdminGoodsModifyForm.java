package team2.admin.goods.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class AdminGoodsModifyForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 전달인자(상품번호) 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		// goodsDAO 객체 생성
		GoodsDAO gdao = new GoodsDAO();
		
		// getGoods(상품번호) -> 특정상품 정보를 모두 가져오는 메서드
		GoodsDTO gdto = gdao.getGoods(num);
		
		// request 영역에 저장
		request.setAttribute("gdto", gdto);
		
		// 페이지 이동(./admin/admin_goods_modify.jsp)
		ActionForward forward = new ActionForward();
		
		forward.setPath("./admin/admin_goods_modify.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

	
}
