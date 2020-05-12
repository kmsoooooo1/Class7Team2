package team2.goods.action;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class GoodsDetailAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 넘겨준 상품 코드 저장
		String g_code = request.getParameter("g_code");

		GoodsDAO gdao = new GoodsDAO();
		
		// 상품 페이지 조회수 1업하는 함수 호출
		gdao.updateGoodsViewCount(g_code);
		
		// 상품 세부정보 가져오기
		List<GoodsDTO> detailList = gdao.getGoodsDetailList(g_code);
		
		request.setAttribute("detailList", detailList);

		ActionForward forward = new ActionForward();
		forward.setPath("./goods/goods_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
		
		
	}

	
}
