package team2.board.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.BoardDAO;

public class boardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		//카테고리저장 해서 forward 처리
		String category = (String)request.getParameter("category");
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		BoardDAO bdao = new BoardDAO();
		
		bdao.deleteBoard(num);
		
		bdao.closeDB();
		
		//게시판페이지 이동
		cSet cset = new cSet();
		
		cset.setCategory(category);
		System.out.println("c 값 @@@@@" +cset.getC());
		
		ActionForward forward = new ActionForward();
		forward.setPath("./BoardList.bo?category="+cset.getC());
		forward.setRedirect(true);
		
		return forward;
	}

}
