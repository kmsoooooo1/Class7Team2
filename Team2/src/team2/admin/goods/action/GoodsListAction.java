package team2.admin.goods.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.action.Criteria;
import team2.board.action.PageMaker;
import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class GoodsListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		GoodsDAO gdao = new GoodsDAO();
		
		// 총 게시글 수
		int total = gdao.getTotalCount();
		
		String page_str = request.getParameter("pageNum");
		int page = 1;
		if(page_str!=null) {
			page = Integer.parseInt(page_str);
		}
		
		
		//	페이지당 게시글 수
		Criteria cri = new Criteria();
		cri.setPerpageNum(15);
		cri.setPage(page);
		
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(total);
		
		System.out.println("cri : " +cri);
		System.out.println("pm : "+pm);
		
		List<GoodsDTO> goodsList = gdao.getGoodsList(cri);
		
		//	request add
		request.setAttribute("goodsList", goodsList);
		request.setAttribute("cri", cri);
		request.setAttribute("pm", pm);
		request.setAttribute("pageNum", page);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_goods_list.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

	
}
