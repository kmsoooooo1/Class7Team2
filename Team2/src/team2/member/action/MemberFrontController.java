package team2.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemberFrontController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 가상주소를 비교해서 처리 

		// 가상주소의 정보를 가져오기
		String requestURI = request.getRequestURI();
		//System.out.println("URI : "+requestURI);
		
		//String requestURL = request.getRequestURL().toString();
		//System.out.println("URL : "+requestURL);
		
		// 프로젝트명을 가져오기 
		String contextPath = request.getContextPath();
		//System.out.println("ContextPath : "+contextPath);
		
		// 실제 변경되는 가상주소
		String command = requestURI.substring(contextPath.length());
		//System.out.println("Command : "+command);
		//System.out.println("----------주소계산 완료-------------------");
		
		//////////////////////////////////////////////////////////////////
		// 계산한 가상주소와  특정페이지가 같으면 
		// 페이지의 동작에 따라서 이동 
		
		Action action = null; // 처리 페이지정보 객체 (인터페이스-execute())
		ActionForward forward = null; // 페이지 이동정보 저장 객체 
		
		// 메인페이지 이동
		if(command.equals("/Main.me")){
			forward = new ActionForward();
			forward.setPath("./board/main_page.jsp");
			forward.setRedirect(false);
		// 회원 가입페이지 이동
		}else if(command.equals("/MemberJoin.me")){
			forward = new ActionForward();
			forward.setPath("./member/insertForm.jsp");
			forward.setRedirect(false);
		// MemberJoinAction.me로 이동	
		}else if(command.equals("/MemberJoinAction.me")){
			action = new MemberJoinAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 로그인페이지 이동			
		}else if(command.equals("/MemberLogin.me")){
			forward = new ActionForward();
			forward.setPath("./member/loginForm.jsp");
			forward.setRedirect(false);
		// MemberLoginAction.me로 이동	
		}else if(command.equals("/MemberLoginAction.me")){
			action = new MemberLoginAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 아이디 중복체크 페이지 이동	
		}else if(command.equals("/MemberIDCheckAction.me")){
			System.out.println("/MemberIDCheckActon.me 주소 요청");
			action = new MemberIDCheckAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 회원 수정 페이지 이동	
		}else if(command.equals("/MemberUpdate.me")){
			action = new MemberUpdate();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// MemberUpdateAction.me로 이동	
		}else if(command.equals("/MemberUpdateAction.me")){
			action = new MemberUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 회원 탈퇴 페이지 이동	
		}else if(command.equals("/MemberDelete.me")){
			forward = new ActionForward();
			forward.setPath("./member/deleteForm.jsp");
			forward.setRedirect(false);
		// MemberDeleteAction.me로 이동	
		}else if(command.equals("/MemberDeleteAction.me")){
			action = new MemberDeleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 로그아웃 동작 
		}else if(command.equals("/MemberLogout.me")){
			action = new MemberLogoutAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 마이 페이지 이동	
		}else if(command.equals("/MemberPage.me")){
			action = new MemberOrderListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 회원 목록페이지 이동	
		}else if(command.equals("/MemberList.me")){
			System.out.println("/MemberList.me 주소 호출");
			action = new MemberListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 회원 정보 페이지 이동	
		}else if(command.equals("/MemberInfo.me")){ 
			System.out.println("/MemberInfo.me 주소 요청");
			action = new MemberInfoAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 아이디 찾기 페이지 이동	
		}else if(command.equals("/MemberIDFind.me")){
			forward = new ActionForward();
			forward.setPath("./member/idFind.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberIDFindAction.me")){
			action = new MemberIDFindAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 비밀번호 찾기 페이지 이동	
		}else if(command.equals("/MemberPWFind.me")){
			forward = new ActionForward();
			forward.setPath("./member/pwFind.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberPWFindAction.me")){
			action = new MemberPWFindAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		// 비밀번호 변경 페이지 이동	
		}else if(command.equals("/ChangePass.me")){
			forward = new ActionForward();
			forward.setPath("./member/changePass.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/MemberChangePassAction.me")){
			action = new MemberChangePassAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 최근 본 상품 페이지
		else if(command.equals("/recentView.me")){
			forward = new ActionForward();
			forward.setPath("./member/recentView.jsp");
			forward.setRedirect(false);
		}
		// 회사 소개 페이지
		else if(command.equals("/Company.me")){
			forward = new ActionForward();
			forward.setPath("./company/company.jsp");
			forward.setRedirect(false);
		}
		// 이용약관 페이지
		else if(command.equals("/Agreement.me")){
			forward =new ActionForward();
			forward.setPath("./company/agreement.jsp");
			forward.setRedirect(false);
		}
		// 개인정보 취급 방침 페이지
		else if(command.equals("/Privacy.me")){
			forward = new ActionForward();
			forward.setPath("./company/privacy.jsp");
			forward.setRedirect(false);
		}
		// 적립금 확인페이지
		else if(command.equals("/Mileage.me")){
			action = new MemberMileageAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
	
		
		// 페이지 이동처리 
		if(forward != null){ // 페이지 이동정보가 있을때 
			// 페이지 이동  sendRedirect/forward
			if(forward.isRedirect()){ // true
				response.sendRedirect(forward.getPath());
			}else{ // false
			   RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
			   dis.forward(request,response);				
			}		
		}
		
		
		
	}
	
	
}
