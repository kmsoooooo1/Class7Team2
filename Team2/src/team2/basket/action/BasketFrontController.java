package team2.basket.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BasketFrontController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		////////////////////////////////////////////////////////////
		// 1. 가상주소 계산
		////////////////////////////////////////////////////////////

		String requestURI = request.getRequestURI();
		// System.out.println("URI : " + requestURI);

		String contextPath = request.getContextPath();
		// System.out.println("ContextPath(프로젝트명) : " + contextPath);

		String command = requestURI.substring(contextPath.length());
		// System.out.println("command : " + command);

		// System.out.println("----------페이지 주소 계산 완료----------------------");

		////////////////////////////////////////////////////////////
		// 2. 계산된 주소를 사용해서 페이지 형태구분(View/Model)
		////////////////////////////////////////////////////////////

		// 이동정보 처리객체
		ActionForward forward = null;
		Action action = null;
		
		// 장바구니 페이지 이동
		if (command.equals("/BasketAdd.ba")) {
			action = new BasketAddAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		// 장바구니 리스트 페이지로 이동
		else if(command.equals("/BasketList.ba")){
			action = new BasketListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//장바구니에서 수량을 수정했을시(Ajax)
		else if(command.equals("/BasketModify.ba")) {
			action = new BasketModiAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}

		
		// 페이지 이동 처리
		if (forward != null) {
			
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());

				dis.forward(request, response);
			}
		}

	}

	

}
