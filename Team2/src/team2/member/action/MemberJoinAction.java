package team2.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.member.db.MemberDAO;
import team2.member.db.MemberDTO;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		
		// 전달된 파라미터 값 저장
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
		mdao.insertMember(mdto); 
		
		ActionForward forward = new ActionForward();
		forward.setPath("./MemberLogin.me");
		forward.setRedirect(true);
		
		return forward;
	}

}
