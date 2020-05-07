package team2.member.action;

import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.member.db.MemberDAO;

public class MemberChangePassAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String pass=request.getParameter("pass");
		String passc=request.getParameter("passc");
		String id=request.getParameter("id");
		
		if(pass.equals("")){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('패스워드를 입력해주세요.');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}
		
		String passc2="[a-zA-Z0-9~`!@#$%\\^&*()-+=]{8,}";
		String engPass="[a-zA-Z]";
		String numPass="[0-9]";
		String specPass="[~`!@#$%\\^&*()-+=]";
		int result=0;
		boolean resultPass=Pattern.matches(passc2, pass);
		MemberDAO mdao= new MemberDAO();
		
		if(resultPass){
			result+=Pattern.compile(engPass).matcher(pass).find()?1:0;
			result+=Pattern.compile(numPass).matcher(pass).find()?1:0;
			result+=Pattern.compile(specPass).matcher(pass).find()?1:0;
			if(result<2){
				System.out.println("영문 숫자 특문 두가지 조합 하세요.");
				response.setContentType("text/html;charset=UTF-8");
				PrintWriter out= response.getWriter();
				out.print("<script>");
				out.print("alert('비밀번호는 숫자나 특수문자를 포함해야 합니다.(~`!@#$%\\^&*()-+=)');");
				out.print("history.back();");
				out.print("</script>");
				
				out.close();
				return null;
			}
		}else{
			//영문 숫자 특문으로 8자 이상
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('비밀번호는 숫자,특문 포함 최소 8자 입니다.(~`!@#$%\\^&*()-+=)');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}
		
		
		if(pass.equals(passc)){
			mdao.changePass(id,pass);
			
		}else{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out= response.getWriter();
			out.print("<script>");
			out.print("alert('비밀번호가 일치하지 않습니다. 똑같은 값을 정확히 한번 더 입력해주세요.');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
			return null;
		}
		ActionForward forward=new ActionForward();
		forward.setPath("./member/changePassOk.jsp");
		forward.setRedirect(false);
		return forward;
	}
}
