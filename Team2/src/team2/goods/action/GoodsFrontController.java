package team2.goods.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class GoodsFrontController extends HttpServlet{

	protected void doProcess(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doProcess() 호출");
		
		///////////////////////////////////////////////////////////////////
		// 1. 가상주소 계산
		///////////////////////////////////////////////////////////////////
		
		String requestURI = request.getRequestURI();
		System.out.println("URI : " + requestURI);
		
		// 프로젝트명을 가져오기
		String contextPath = request.getContextPath();
		System.out.println("ContextPath(프로젝트명) : " + contextPath);
		
		// 실제 변경되는 가상주소
		String command = requestURI.substring(contextPath.length());
		System.out.println("command : " + command);
		
		// 어노테이션 (알아서 주소 찾아주는 형태) 나중에 배움
		
		System.out.println("-----------------페이지 주소 계산 완료-------------------");
		
		///////////////////////////////////////////////////////////////////
		// 2. 계산된 주소 사용해서 페이지 형태 구분(view / model)
		///////////////////////////////////////////////////////////////////
		System.out.println("-----------------페이지 구분 (view/model)------------------");
		
		// 이동정보 처리객체
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/GoodsList.go")){
			// 일반 사용자가 상품의 정보를 확인하는 리스트
			// GoodsListAction() 객체 생성
			
			System.out.println("/GoodsList.go 처리 model -> view");
			
			action =  new GoodsListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		///////////////////////////////////////////////////////////////////
		// 3. 실제 페이지 이동 동작 (redirect / forward)
		///////////////////////////////////////////////////////////////////
		
		System.out.println("-----------페이지 이동(redirect(true) / forward(false))------------");
		
		if(forward != null){
			//if(forward.isRedirect() == true){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis =
						request.getRequestDispatcher(forward.getPath());
				
				dis.forward(request, response);
			}
		}
		
		
		// 페이지 이동 정보가 있을 때 만, 페이지 이동
		
	}
	
	
	@Override
	protected void doGet(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost() 호출");
		doProcess(request, response);
	}

}
