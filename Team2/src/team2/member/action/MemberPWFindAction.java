package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.member.db.MemberDAO;

public class MemberPWFindAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
	
		System.out.println("@@@ MemberPWFindAction_execute() ");
		
		String email=request.getParameter("email");
		String id = request.getParameter("id");
		MemberDAO mdao = new MemberDAO();
		int check=mdao.findPW(email,id);
		
		if(check==0){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('인증 메일이 일치하지 않습니다.');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}else if(check==-1){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('해당 정보의 유저는 존재하지 않습니다.');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out= response.getWriter();
		out.print("<script>");
		out.print("alert('인증메일이 발송되었습니다. 메일을 확인해주세요.');");
		out.print("location.href='./MemberLogin.me';");
		out.print("</script>");
		
		out.close();
		return null;
	}

}
