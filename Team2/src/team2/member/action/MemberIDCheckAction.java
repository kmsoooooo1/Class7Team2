package team2.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.member.db.MemberDAO;

public class MemberIDCheckAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("@@@ MemberIDCheckAction_execute() ");
		
		// 한글처리
		
		//앞 페이지에서 넘어온 데이터 가져오기
		String id = request.getParameter("MEMBER_ID");
		 
		MemberDAO dao = MemberDAO.getInstance();
		
		boolean check = dao.confirmId(id);
		
		//id와 check의 값을 request에 저장
		request.setAttribute("id", id);
		request.setAttribute("check", check);
		
		
		//이동할 페이지 설정 //★
		ActionForward forward = new ActionForward();
		forward.setPath("./member/member_idchk.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}
