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
	
	// 로그인 되어 있지 않으면 MemberLogin.me로 이동
	HttpSession session = request.getSession();
	String id = (String)session.getAttribute("id");
				
	// 이동방법과 이동할 페이지를 저장할 객체 생성
	ActionForward forward = new ActionForward();
				
		if(id==null){
			forward.setRedirect(true);
			forward.setPath("./MemberLogin.me");
			return forward;
		}
				
	// 데이터베이스의 메서드를 이용해서 삭제하고 결과를 가져오기
	MemberDAO dao = MemberDAO.getInstance();
	String pass = request.getParameter("pass");
	 
	boolean check = dao.deleteMember(id, pass);
							
	if(check){ // 정상적으로 삭제되었다면
			   // 세션을 삭제 - 보통 로그아웃 처리할 때 주로 이용
		session.invalidate();
		forward.setPath("./member/delchk.jsp");
		}else{ // 삭제에 실패했을 때
		response.setContentType("text/html; charset=UTF-8");
		try{
			PrintWriter out = response.getWriter();
						out.println("<script>");
						out.println("alert('비밀번호가 틀렸습니다.')");
						out.println("history.back()");
						out.println("</script>");
						out.close();
						forward = null;
			}catch(Exception e){
						forward = null;
			}
		}
		return forward;
	}

}
