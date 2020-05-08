package team2.board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.CommentDAO;

public class deleteCommentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ActionForward forward = new ActionForward();
		
		//	comment Idx
		String num = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		int c_idx = Integer.parseInt(request.getParameter("cnum"));
		
		//	Comment 삭제 실행
		CommentDAO dao = new CommentDAO();
		int chk = dao.deleteComment(c_idx);
		dao.closeDB();
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(chk>0){
			//	comment 삭제 성공
			out.print("<script>");
			out.print("location.href='./BoardContent.bo?num=" +num +"&pageNum="+pageNum+"'");
			out.print("</script>");
			
		}else{
			//	comment 삭제 실패..
			out.print("<script>");
			out.print("alert('삭제실패');");
			out.print("history.back();");
			out.print("</script>");
		}
		
		out.close();
		
		return null;
	}
}
