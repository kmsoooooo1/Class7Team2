package team2.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		
		int check = mdao.insertMemberPoint(mdto);
		
		if (check == 1) {
			// 응답정보의 타입을 html 형식으로 응답
			response.setContentType("text/html; charset=UTF-8");

			// 출력객체를 생성(response객체의 정보를 가지고 생성)
			PrintWriter out = response.getWriter();

			// 자바스크립트를 통한 페이지 이동은 컨트롤러 없이 바로 이동 
			out.print("<script>");
			out.print("  alert('회원가입을 축하드립니다. 적립금 2,000원이 추가되었습니다.'); ");
			out.print(" location.href='./MemberLogin.me'; ");
			out.print("</script>");
			
			out.close();

			return null;
		}
		
		ActionForward forward = new ActionForward();
		forward.setPath("./MemberLogin.me");
		forward.setRedirect(true);
		
		return forward;
	}

}
