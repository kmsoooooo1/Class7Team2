package team2.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardContentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String num_str = request.getParameter("num");
		int num = -1;
		System.out.println("num_str : " + num_str);
		if(num_str!=null){
			num = Integer.parseInt(request.getParameter("num"));
		}else{
			num = Integer.parseInt((String)request.getAttribute("num"));
		}
		
		String pageNum = request.getParameter("pageNum");
		System.out.println("pageNum : " + pageNum);
		if(pageNum==null){
			pageNum = (String)request.getAttribute("pageNum");
		}
		BoardDAO bdao = new BoardDAO();
		
		bdao.updateView(num);
		BoardDTO bdto = bdao.getBoard(num);
		
		request.setAttribute("bdto", bdto);
		request.setAttribute("pageNum", pageNum);
		bdao.closeDB();
		ActionForward forward = new ActionForward();
		forward.setPath("/board/board_content.jsp");
		forward.setRedirect(false);
		return forward;
	}

}
