package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.member.db.MemberDAO;

public class MemberIDFindAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		String email=request.getParameter("email");
		MemberDAO mdao = new MemberDAO();
		int check=mdao.findID(email);
		
		if(check == -1){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('회원 정보가 없습니다.');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out= response.getWriter();
		out.print("<script>");
		out.print("alert('인증 메일을 전송하였습니다. 메일함을 확인해주세요.');");
		out.print("location.href='./MemberLogin.me';");
		out.print("</script>");
		
		out.close();
		
		return null;
	}

}
