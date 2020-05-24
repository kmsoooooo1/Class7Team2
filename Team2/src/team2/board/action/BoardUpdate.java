package team2.board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardUpdate implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		System.out.println("지금 접속 중인 회원은 " + id);
		
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
		
		
		int num = Integer.parseInt(request.getParameter("num"));
		String pageNum = request.getParameter("pageNum");
		
		BoardDAO bdao = new BoardDAO();
		
		int check = bdao.idCheck(num, id);
		
		//관리자거나 글 작성자가 아닐 때 뒤로가기
		if(!id.equals("admin") && check != 1){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('작성자가 다릅니다.');");
			out.print("location.href=history.back()");
			out.print("</script>");
			out.close();
			return null;
		}
		BoardDTO bdto = bdao.getBoard(num);
		
		bdao.closeDB();
		
		request.setAttribute("bdto", bdto);
		request.setAttribute("pageNum", pageNum);
		

		forward.setPath("./board/board_update.jsp");
		forward.setRedirect(false);	
		
		return forward;
	}

}
