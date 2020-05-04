package team2.admin.goods.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class GoodsListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GoodsDAO gdao = new GoodsDAO();
		
		String category = request.getParameter("category");
		String sub_category = "";
		String sub_category_index = "";
		
		List<GoodsDTO> goodsList = gdao.getGoodsList(category, sub_category, sub_category_index);
		
		request.setAttribute("goodsList", goodsList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_goods_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

	
}