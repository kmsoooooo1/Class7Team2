package team2.board.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class BoardFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String requestURI = request.getRequestURI();
		String context = request.getContextPath();
		String command = requestURI.substring(context.length());
		
		System.out.println("Command : " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/Insert.bo")){
			forward = new ActionForward();
			forward.setPath("./board/insert.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/InsertAction.bo")){
			action = new insertBoardAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};
		}else if(command.equals("/BoardMain.bo")) {
			forward = new ActionForward();
			forward.setPath("./board/main_page.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/BoardWrite.bo")) {
			System.out.println("/BoardWrite.bo 주소 처리");
      
			forward = new ActionForward();
			forward.setPath("./board/board_insert.jsp");
			forward.setRedirect(false);			
		}else if(command.equals("/BoardWriteAction.bo")) {
			System.out.println("/BoardWriteAction.bo 주소 처리");
			
			action = new BoardWriteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/notice.bo")) {
			System.out.println("/notice.bo 주소 처리");

			String category = request.getParameter("category");
			request.setAttribute("category", category);
			action = new BoardNoticeAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
      }
		}else if(command.equals("/review.bo")) {
			System.out.println("/review.bo 주소 처리");
			
			String category = request.getParameter("category");
			request.setAttribute("category", category);
			
			action = new BoardReviewAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(forward!=null){
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dis = request.getRequestDispatcher(forward.getPath());
				dis.forward(request, response);
			}
		}
		
	}
	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	
	
}
