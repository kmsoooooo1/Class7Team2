package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import team2.member.db.MemberDAO;
import team2.member.db.MemberDTO;

public class MemberUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		request.setCharacterEncoding("UTF-8");
		
		MemberDTO mdto = new MemberDTO();
		
		mdto.setId(request.getParameter("id"));
		mdto.setPass(request.getParameter("pass"));
		mdto.setName(request.getParameter("name"));
		mdto.setPhone(request.getParameter("phone"));
		mdto.setZipcode(request.getParameter("zipcode"));
		mdto.setAddr1(request.getParameter("addr1"));
		mdto.setAddr2(request.getParameter("addr2"));
		mdto.setEmail(request.getParameter("email"));
		
		MemberDAO mdao = new MemberDAO();
		
		int check = mdao.updateMember(mdto);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check == 0){
			out.print("<script>");
			out.print("alert('비밀번호가 맞지 않습니다.');");
			out.print("history.back();");
			out.print("</script>");
			out.close();
			
			return null;
		}
		
		out.print("<script>");
		out.print("alert('회원정보 수정 완료');");
		out.print("location.href='./Main.me';");
		out.print("</script>");
		
		return null;
	}

}
