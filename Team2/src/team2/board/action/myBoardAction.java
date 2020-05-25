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
		
		String c_str = request.getParameter("category");
		
		
		//검색 + 페이지 크기 초기값설정
		int pageSize = 10;
		String search = "";
		try{
			 pageSize = Integer.parseInt(request.getParameter("pageSize"));
			 search = (String) request.getParameter("search");
		}catch(Exception e){
			System.out.println(e);
		}
		
		int c = 1;
		if(c_str!=null){
			c = Integer.parseInt(c_str);
		}
		
		cSet set = new cSet();
		set.setC(c);
		
		System.out.println("category : "+c+"/search : "+search);
		
		System.out.println("cset = "+set);
		
		String page_str = request.getParameter("page");
		int page = 1;
		if(page_str!=null){
			page=Integer.parseInt(page_str);
		}
		
		List<BoardDTO> list = dao.getMyBoard(id,c);
		Criteria cri = new Criteria();
		
		cri.setPage(page);		
		cri.setPerpageNum(pageSize);
		
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(dao.getWriterCount(id, c));
		
		request.setAttribute("list", list);
		request.setAttribute("cri", cri);
		request.setAttribute("pm", pm);
		request.setAttribute("page", page);
		request.setAttribute("c", c);
		
		dao.closeDB();
		forward.setPath("./board/myBoard.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
