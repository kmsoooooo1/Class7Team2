package team2.order.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.order.action.Action;
import team2.order.action.ActionForward;

public class OrderFrontController extends HttpServlet{

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
		
		// 장바구니(모든상품) -> 구매하기 전 사용자 정보 입력 페이지로 이동
		if(command.equals("/OrderStar.or")){
			action = new OrderStarAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// 장바구니(사용자가 선택한 상품들) -> 구매하기 전 사용자 정보 입력 페이지로 이동
		else if(command.equals("/OrderStarSelected.or")){
			action = new OrderStarSelectedAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//구매 정보 입력 한 후 구매하기 버튼 눌렸을시(구매하기 처리)
		else if(command.equals("/OrderAdd.or")){
			action = new OrderAddAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//구매 완료된 페이지 
		else if(command.equals("/OrderComplete.or")){
			action = new OrderCompleteAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//구매내역(주문내역) 리스트 보여주는 페이지 처리 
		else if(command.equals("/OrderList.or")) {
			action = new OrderListAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//주문내역 상세페이지 처리
		else if(command.equals("/OrderDetail.or")){
			action = new OrderDetailAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//입금 확인해서 o_status 1로 바꾸는 함수 처리
		else if(command.equals("/OrderModiStatus.or")){
			action = new OrderModiStatusAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
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
