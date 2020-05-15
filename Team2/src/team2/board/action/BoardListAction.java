package team2.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@ BoardListAction_excute() 호출! @@@");
		
		request.setCharacterEncoding("UTF-8");
		
		BoardDAO bdao = new BoardDAO();
		
		int c = Integer.parseInt(request.getParameter("category"));
		
		String search = (String) request.getParameter("search");
		
		System.out.println("category : "+c+"/search : "+search);
		
		cSet cset = new cSet();
		
		cset.setC(c);
		
		HttpSession session = request.getSession();
		session.setAttribute("cset", cset);
		
		System.out.println(cset);
		
		//total 게시판 글 수
		int total = 0;
		if(search == null){
			total = bdao.getBoardCount(cset);
			session.setAttribute("search", search);
		}else{
			total = bdao.serachCount(cset, search);
			session.setAttribute("search", search);
			request.setAttribute("search", search);
		}
		
		//  ----페이징 처리-----
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
		
		int currentPage = Integer.parseInt(pageNum);
		
		int pageSize = 10;
		if(c==1){
			pageSize = 8;
		}else{
			pageSize = 10;
		}
		
		Criteria cri = new Criteria();
		
		cri.setPage(currentPage);
		cri.setPerpageNum(pageSize);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(total);
		
		System.out.println(pageMaker.getStartPage());
		System.out.println(pageMaker.getEndPage());
		
		// ----페이징 처리-----
		
		ArrayList<BoardDTO> boardList = null;

		boardList = bdao.getBoardList(cset, cri);
		
		if(search!=null){
			boardList = bdao.searchTitle(cset, search, cri);
		}
		//bdao 자원 해제
		bdao.closeDB();

		//boardList + 페이징처리 값 전송
		request.setAttribute("boardList", boardList);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);
		
		//카테고리별 전송 값
		request.setAttribute("c", cset.getC());		
		
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
