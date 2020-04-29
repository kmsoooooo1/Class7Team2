package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.member.db.MemberDAO;

public class MemberDeleteAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		System.out.println("@@@ MemberDeleteAction_execute() ");
		// 세션 제어
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
				 
		ActionForward forward = new ActionForward();
			if(id == null){
				forward.setPath("./MemberLogin.me");
				forward.setRedirect(true);
				return forward;
			}
		// 파라미터값 저장(id,pass)
		String pass = request.getParameter("pass");
				
		// MemberDAO객체 생성후 이동
		MemberDAO mdao = new MemberDAO();		 

		// deleteMember(id,pass or mb);
		int check = mdao.deleteMember(id,pass);
				
		// update동작 처럼  0,1,-1 이동
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
				 
			if( check == 0 ){
				out.print("<script>");
				out.print(" alert('비밀번호 오류'); ");
				out.print(" history.back(); ");
				out.print("</script>");
				out.close();
				return null;
			}else if(check == -1){
				out.print("<script>");
				out.print(" alert('아이디 없음'); ");
				out.print(" history.back(); ");
				out.print("</script>"); 
				out.close();
				return null;
			}
			// check == 1;
		    // 세션값 초기화(id정보삭제)
			session.invalidate();
				 
				out.print("<script>");
				out.print(" alert('회원 탈퇴 성공'); ");
				out.print(" location.href='./Main.me'; ");
				out.print("</script>"); 
				out.close();
		return null;
	}

	
}
