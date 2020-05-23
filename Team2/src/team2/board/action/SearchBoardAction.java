package team2.board.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;

public class SearchBoardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("SearchBoardAction excute() 호출");
		
		request.setCharacterEncoding("UTF-8");
		
		BoardDAO bdao = new BoardDAO();
		
//		String category = (String)request.getParameter("b_category");

		int c = Integer.parseInt(request.getParameter("category"));
		
		String search = (String) request.getParameter("search");
		
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		cSet cset = new cSet();
		
		cset.setC(c);
		
		System.out.println("category : "+c+"/search : "+search);
		
		System.out.println("cset = "+cset);
		
		//total 게시판 글 수
		int total = bdao.serachCount(cset, search);
		
//		HttpSession session = request.getSession();
//		session.setAttribute("c", c);
//		session.setAttribute("search", search);
//		session.setAttribute("pageSize", pageSize);


		//  ----페이징 처리-----
		
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){
				pageNum = "1";
			}
			
			int currentPage = Integer.parseInt(pageNum);
						
			Criteria cri = new Criteria();
			
			cri.setPage(currentPage);
			cri.setPerpageNum(pageSize);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			pageMaker.setTotalCount(total);
			
			System.out.println(pageMaker.getStartPage());
			System.out.println(pageMaker.getEndPage());
			
		// ----페이징 처리-----
			
			
			ArrayList getList = bdao.searchTitle(cset, search, cri);

			bdao.closeDB();
			
			//boardList + 페이징처리 값 전송
			request.setAttribute("getList", getList);
			request.setAttribute("cri", cri);
			request.setAttribute("pageMaker", pageMaker);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("pageSize", pageSize);
		
			//카테고리별 전송 값
			request.setAttribute("c", cset.getC());	
			
			//검색 search 값
			request.setAttribute("search", search);
			request.setAttribute("category", cset.getCategory());
			
			ActionForward forward = new ActionForward();

			forward.setPath("./board/adminBoard.jsp");
			forward.setRedirect(false);

			return forward;
	}

}
