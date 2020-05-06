package team2.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@ BoardNoticeAction_excute() 호출! @@@");
		
		BoardDAO bdao = new BoardDAO();
		
		//카테고리 분류 값
		int c = Integer.parseInt(request.getParameter("category"));
		String sub = request.getParameter("sub_category");
		
		int pc = 0;
		if(sub!=null){
			
			pc = Integer.parseInt(request.getParameter("sub_category"));
		}
		
		cSet cset = new cSet();
		
		cset.setC(c);
		cset.setPc(pc);
		
		System.out.println(cset);
		
		//total 게시판 글 수
		int total = bdao.getBoardCount(cset);
		
		//  ----페이징 처리-----
		
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
		pageMaker.setTotalCount(total);
		
		System.out.println(pageMaker.getStartPage());
		System.out.println(pageMaker.getEndPage());
		
		// ----페이징 처리-----

		ArrayList<BoardDTO> boardList = bdao.getBoardList(cset,cri);
		//bdao 자원 해제
		bdao.closeDB();
		
		System.out.println("cri : " +cri);
		System.out.println("pageMaker : " +pageMaker);
		System.out.println("pageNum : " +pageNum);
		
		//boardList + 페이징처리 값 전송
		request.setAttribute("boardList", boardList);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);
		
		//카테고리별 전송 값
		request.setAttribute("category", c);
		request.setAttribute("sub_category", sub);
		
		
		ActionForward forward = new ActionForward();
		
		//카테고리별 view 이동
		if(cset.getC()==0){
			forward.setPath("./board/board_notice.jsp");
		}else if(cset.getC()==1){
			forward.setPath("./board/board_review.jsp");
		}else if(cset.getC()==2){
			forward.setPath("./board/board_qna.jsp");	
		}
		forward.setRedirect(false);
		
		return forward;
	
	}

}
