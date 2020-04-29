package team2.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.member.db.MemberDAO;
import team2.member.db.MemberDTO;

public class MemberInfoAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@ MemberInfoAction_execute() ");
		
		// 세션정보가 있을때만 진행
		// 없으면 로그인 페이지로 이동
		HttpSession session = request.getSession();
				
		String id = (String) session.getAttribute("id");
				
		ActionForward forward = new ActionForward();
			if(id == null){
			//response.sendRedirect("./MemberLogin.me");
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
					
			return forward;
		}
				
		// MemberDAO 객체 생성
		MemberDAO mdao = new MemberDAO();
		// getMember(id); 
		// => id에 해당하는 회원정보 모두를 가져오기
		MemberDTO mdto = mdao.getMember(id);
				
		// 회원정보를 request 영역에 저장
		request.setAttribute("mdto", mdto);
				
		// 페이지 이동  ./memeber/memberInfo.jsp
		forward.setPath("./member/memberInfo.jsp");
		forward.setRedirect(false);		
		return forward;
	}

}
