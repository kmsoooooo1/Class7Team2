package team2.board.action;

import java.io.PrintWriter;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import team2.board.db.CommentDAO;
import team2.board.db.CommentDTO;

public class insertCommenctAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("Insert Comment Action 실행!");
		ActionForward forward = new ActionForward();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String num = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		String bdto = request.getParameter("bdto");
		
		System.out.println("CommentAction bdto : " + bdto);
		
		CommentDTO dto = new CommentDTO();
		
		request.setCharacterEncoding("UTF-8");
		
		System.out.println("comment : "+request.getParameter("comment"));
		System.out.println("ID : " + id);
		System.out.println("c_b_idx : " + request.getParameter("c_b_idx"));
		System.out.println("IP : " + request.getRemoteAddr());
		
		dto.setC_comment(request.getParameter("comment"));
		dto.setC_id(id);
		dto.setC_b_idx(Integer.parseInt(request.getParameter("c_b_idx")));
		dto.setIp_addr(request.getRemoteAddr());
		
		CommentDAO dao = new CommentDAO();
		
		int chk = dao.insertComment(dto);
		
		dao.closeDB();
		
		if(chk>0){
			// 	comment 등록 성공시
			request.setAttribute("bdto", bdto);
			request.setAttribute("pageNum", 1);
			request.setAttribute("num", dto.getC_b_idx());
			
			forward.setPath("./BoardContent.bo?num="+num+"&pageNum="+pageNum);
			forward.setRedirect(true);
			
		}else{
			//	comment 등록 실패시
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('등록실패..');");
			out.print("history.back();");
			out.print("<script>");
			
			out.close();
		}
		
		
		return forward;
	}

}
