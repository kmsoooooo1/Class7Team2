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
		
		
		BoardDAO bdao = new BoardDAO();
		
		cSet cset = new cSet();
		
		int check = 0;
		
		String [] chks = request.getParameterValues("chk");
		//관리자 복수 삭제
		if(id.equals("admin") && chks != null){
			for(int i=0; i<chks.length; i++){
				bdao.deleteBoard(chks[i]);
			}
		}else{
			
			//카테고리저장 해서 forward 처리
			String category = (String)request.getParameter("category");
			int num = Integer.parseInt(request.getParameter("num"));
			String pageNum = request.getParameter("pageNum");
			
			check = bdao.idCheck(num, id);
		
			if(check != 1 ){
				
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.print("<script>");
				out.print("alert('작성자가 다릅니다.');");
				out.print("location.href=history.back()");
				out.print("</script>");
				out.close();
				return null;
				
			}
			
			bdao.deleteBoard(num);
			
			cset.setCategory(category);
			System.out.println("c 값 @@@@@" +cset.getC());
			
		}
		
		
		bdao.closeDB();
		
		//게시판페이지 이동		
		if(id.equals("admin") && chks != null){
			
			forward.setPath("./AdminBoard.bo");
			forward.setRedirect(true);
			
		}else{
			
			forward.setPath("./BoardList.bo?category="+cset.getC());
			forward.setRedirect(true);
		
		}
				
		return forward;
	}

}
