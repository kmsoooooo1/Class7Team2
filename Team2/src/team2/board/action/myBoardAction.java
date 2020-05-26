package team2.board.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class myBoardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("myBoardAction 실행");
		
		ActionForward forward = new ActionForward();
		
		BoardDAO dao = new BoardDAO();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");

		//검색 + 페이지 크기 초기값설정
		int c = 3;
		int pageSize = 10;
		String search = "";
		
		try{
			 c = Integer.parseInt(request.getParameter("category"));
			 pageSize = Integer.parseInt(request.getParameter("pageSize"));
			 search = (String) request.getParameter("search");
		}catch(Exception e){
			System.out.println(e);
		}
		
		cSet set = new cSet();
		set.setC(c);
		
		System.out.println("category : "+c+"/search : "+search);
		
		System.out.println("cset = "+set);
		
		int total = dao.getWriterCount(id, set);
		
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
		
		List<BoardDTO> list = dao.getMyBoard(id,set,cri);

		request.setAttribute("list", list);
		request.setAttribute("cri", cri);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("pageNum", pageNum);		
		//카테고리별 전송 값
		request.setAttribute("c", set.getC());	
		
		//검색 search 값
		request.setAttribute("search", search);
		request.setAttribute("category", set.getCategory());

		
		dao.closeDB();
		forward.setPath("./board/myBoard.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
