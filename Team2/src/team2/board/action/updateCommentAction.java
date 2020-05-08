package team2.board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.board.db.CommentDAO;
import team2.board.db.CommentDTO;

public class updateCommentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		ActionForward forward = null;
		
		request.setCharacterEncoding("UTF-8");
		
		String num = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		int c_idx = Integer.parseInt(request.getParameter("cnum"));
		CommentDTO dto = new CommentDTO();
		dto.setC_idx(c_idx);
		dto.setC_comment(request.getParameter("comment"));
		
		CommentDAO dao = new CommentDAO();
		
		int chk = dao.updateComment(dto);
		
		dao.closeDB();
		
		if(chk>0){
			forward = new ActionForward();
			forward.setPath("./BoardContent.bo?num=" + num + "&pageNum="+pageNum);
			forward.setRedirect(true);
		}else{
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('삭제 실패..');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
		}
		
		return forward;
	}

}
