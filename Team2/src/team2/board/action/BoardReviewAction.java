package team2.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.BoardDAO;

public class BoardReviewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@ BoardReviewAction_excute() 호출! @@@");
		
		BoardDAO bdao = new BoardDAO();
		
		String category = ((String)request.getAttribute("category"));
			
		int check = bdao.getBoardCount(category);
		
		// 페이징 처리
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		
		int pageSize = 5;
		
		Criteria cri = new Criteria();
		
		cri.setPage(currentPage);
		cri.setPerpageNum(pageSize);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(bdao.getBoardCount(category));
		
		System.out.println(pageMaker.getStartPage());
		System.out.println(pageMaker.getEndPage());
		
		// 페이징 처리
	
		ArrayList boardList = bdao.getBoardList(category,cri);
		//bdao 자원 해제
		bdao.closeDB();
				
		System.out.println("boardList : " + boardList);
		
		request.setAttribute("boardList", boardList);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./board/board_review.jsp");
		forward.setRedirect(false);	
		
		return forward;
	}

}
