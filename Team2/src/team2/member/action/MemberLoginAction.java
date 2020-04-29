package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import team2.member.db.MemberDAO;

public class MemberLoginAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 전달받은 id,pass 저장
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		
		MemberDAO mdao = new MemberDAO();
		
		int check = mdao.idCheck(id,pass);
		
		if (check == 0) {
			
			// 응답정보의 타입을 html 형식으로 응답.
			response.setContentType("text/html; charset=UTF-8");

			// 출력객체를 생성(response객체의 정보를 가지고 생성)
			PrintWriter out = response.getWriter();

			out.print("<script>");
			out.print("  alert('비밀번호가 맞지 않습니다.'); ");
			out.print("  history.back(); ");
			out.print("</script>");
			// out 객체 자원 해제
			out.close();

			return null;

		} else if (check == -1) {
			// 응답정보의 타입을 html 형식으로 응답
			response.setContentType("text/html; charset=UTF-8");

			// 출력객체를 생성(response객체의 정보를 가지고 생성)
			PrintWriter out = response.getWriter();

			// 자바스크립트를 통한 페이지 이동은 컨트롤러 없이 바로 이동 
			out.print("<script>");
			out.print("  alert('아이디가 없습니다.'); ");
			//out.print("  history.back(); ");
			out.print(" location.href='./MemberLogin.me'; ");
			out.print("</script>");
			
			out.close();

			return null;

		}

		// 로그인 성공시 ID값을 세션객체에 저장해서 사용
		// session 내장객체는 JSP에서 제공되는 내장객체이다.
		
		// request 객체를 사용해서 세션 객체를 생성
		// check == 1
		HttpSession session = request.getSession();
		
		session.setAttribute("id", id);
		
		// 페이지 이동(메인페이지)
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.me");
		forward.setRedirect(true);
		return forward;
	}

}
