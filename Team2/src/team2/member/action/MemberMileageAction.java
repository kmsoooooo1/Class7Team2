package team2.member.action;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.member.db.MemberDAO;
import team2.member.db.MemberPointDTO;

public class MemberMileageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		String id = (String) session.getAttribute("id");
		
		ActionForward forward = new ActionForward();
		if(id == null){
			forward.setPath("./MemberLogin.me");
			forward.setRedirect(true);
			
			return forward;
		}
		
		MemberDAO mdao = new MemberDAO();
		
		List<MemberPointDTO> pointList = mdao.getMileage(id);
		
		request.setAttribute("pointList", pointList);
		
		forward.setPath("./member/mileage.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
