package team2.admin.animal.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.admin.animal.action.Action;
import team2.admin.animal.action.ActionForward;

public class AdminAnimalFrontController extends HttpServlet{

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
		
		//관리자 새로운 동물 추가하는 페이지로 가기
		if(command.equals("/AnimalAdd.aa")){
			forward = new ActionForward();
			forward.setPath("./admin/admin_animal_add.jsp");
			forward.setRedirect(false);
		}
		//새로운 동물 추가하는 페이지 처리
		else if(command.equals("/AnimalAddAction.aa")){
			action = new AnimalAddAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//모든동물 리스트 가져오는 페이지로 가기
		else if(command.equals("/AnimalList.aa")) {
			action = new AnimalListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/AnimalNew.aa")) {
			action = new AnimalNewAction();
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
