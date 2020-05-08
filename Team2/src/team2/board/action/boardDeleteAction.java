package team2.board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;

public class boardDeleteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		
		if(id==null){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('로그인이 필요합니다.');");
			out.print("location.href='./Main.me'");
			out.print("</script>");
			out.close();
			return null;
		}
		
		
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
		
		
		forward.setPath("./BoardList.bo?category="+cset.getC());
		forward.setRedirect(true);
				
		return forward;
	}

}
