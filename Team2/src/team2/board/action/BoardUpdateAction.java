package team2.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		//String pageNum = request.getParameter("pageNum");
		
		BoardDTO bdto = new BoardDTO();
		
		bdto.setB_category(request.getParameter("category"));;
		bdto.setB_title(request.getParameter("title"));
		bdto.setB_content(request.getParameter("content"));
		bdto.setB_idx(Integer.parseInt(request.getParameter("num")));
		
		BoardDAO bdao = new BoardDAO();
		
		System.out.println("bdto 값 : " +bdto);
		
		bdao.updateBoard(bdto);
		
		bdao.closeDB();
		
		ActionForward forward = new ActionForward();
		forward.setPath("./BoardMain.bo");
		forward.setRedirect(true);
		
		return forward;
	}

}
