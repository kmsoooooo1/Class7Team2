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
		
		String c_str = request.getParameter("C");
		
		int c = 1;
		if(c_str!=null){
			c = Integer.parseInt(c_str);
		}
		
		cSet set = new cSet();
		set.setC(c);
		
		String page_str = request.getParameter("page");
		int page = 1;
		if(page_str!=null){
			page=Integer.parseInt(page_str);
		}
		
		List<BoardDTO> list = dao.getMyBoard(id,c);
		Criteria cri = new Criteria();
		cri.setPage(page);
		
		int pageSize = 20;
		if(c==1){
			pageSize = 8;
		}else{
			pageSize = 20;
		}
		
		cri.setPerpageNum(pageSize);
		
		PageMaker pm = new PageMaker();
		
		pm.setCri(cri);
		pm.setTotalCount(dao.getWriterCount(id, c));
		
		request.setAttribute("list", list);
		request.setAttribute("cri", cri);
		request.setAttribute("pm", pm);
		request.setAttribute("page", page);
		
		dao.closeDB();
		
		forward.setRedirect(false);
		
		return forward;
	}

}
