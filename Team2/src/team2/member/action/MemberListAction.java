package team2.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.member.db.MemberDAO;
import team2.member.db.MemberDTO;

public class MemberListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		
		System.out.println(" @@@ MemberListAction_execute()");
		
		// 세션값 처리
		// 로그인 여부, 관리자 여부
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if( id == null ||  !id.equals("admin") ){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		 
		// DB 처리객체  MemberDAO 생성
		MemberDAO mdao = new MemberDAO();
		// getMemberList() -> 회원 목록 List정보를 가져오기
		List<MemberDTO> memberList = mdao.getMemberList(); 
		
		// request 영역에 저장
		request.setAttribute("memberList", memberList);		
		
		// 페이지 이동 (./member/memberList.jsp)
		forward.setPath("./member/memberList.jsp");
		forward.setRedirect(false);		
		return forward;
	}

}
