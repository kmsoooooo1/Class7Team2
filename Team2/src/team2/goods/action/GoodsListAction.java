package team2.goods.action;

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
		
		//구분짓기 위한 변수 받기
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		String sub_category_index = request.getParameter("sub_category_index");
	
		if(sub_category == null){
			// 유저가 먹이나 사육용품만 선택했을 시 sub_category에는 all을 넣어서 모든 먹이 또는 사육용품을 가지고 온다
//			sub_category = "all";
			sub_category = "";
		}
		if(sub_category_index == null){
//			sub_category_index = "all";
			sub_category_index = "";
		}
		//total 게시판 글 수
			int total = 0;
			total = gdao.getGoodsCount(category, sub_category, sub_category_index);
			
			System.out.println("total :  " + total);
	//  ----페이징 처리-----
		
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
		
			int pageSize = 8;
			
			Criteria cri = new Criteria();
			
			cri.setPage(currentPage);
			cri.setPerpageNum(pageSize);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(total);
			
			System.out.println(pageMaker.getStartPage());
			System.out.println(pageMaker.getEndPage());
			
			// ----페이징 처리-----
		
		
		
//		List<GoodsDTO> goodsList = gdao.GoodsList(category, sub_category, sub_category_index);
		List<GoodsDTO> goodsList = gdao.GoodsPage(category, sub_category, sub_category_index, cri);
		
		
		// 등록된 모든 상품의 정보를 가져와서 request영역에 저장
		request.setAttribute("goodsList", goodsList);
		
		//pageing
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./goods/goods_list.jsp");
		forward.setRedirect(false);
	
		return forward;
	}

	
}
