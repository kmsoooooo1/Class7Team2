package team2.board.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class insertBoardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("InsertAction 실행");
		ActionForward forward = new ActionForward();

		//	request Encoding 설정
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		//	dto 생성 및 설정
		BoardDTO dto = new BoardDTO();
		dto.setB_category(request.getParameter("b_category"));
		dto.setB_p_cate(request.getParameter("b_p_cate"));
		dto.setB_title(request.getParameter("b_title"));
		dto.setB_writer(request.getParameter(id));
		dto.setB_content(request.getParameter("ir1"));
		dto.setIp_addr(request.getRemoteAddr());
		
		BoardDAO dao = new BoardDAO();
		
		//	insert 동작 실행
		int chk = dao.insert(dto);
		
		//	dao 자원 해제
		dao.closeDB();
		if(chk >0){
			//	insert 성공
			System.out.println("글 등록 성공!");
			forward.setPath("./List.bo");
			forward.setRedirect(true);
		}else{
			//	insert 실패
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('등록 실패..');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
		}
		return forward;
	}

}
