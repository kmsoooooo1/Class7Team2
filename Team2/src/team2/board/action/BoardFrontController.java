package team2.board.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class BoardFrontController extends HttpServlet {

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String requestURI = request.getRequestURI();
		String context = request.getContextPath();
		String command = requestURI.substring(context.length());
		
		HttpSession session = request.getSession();
		cSet cset = (cSet) session.getAttribute("cset");
		if(cset==null) {
			cset = new cSet();
		}
		
		System.out.println("Command : " + command);
		
		ActionForward forward = null;
		Action action = null;
		
		if(command.equals("/Insert.bo")){
			
			//	글 작성 Form으로 이동
			
			forward = new ActionForward();
			forward.setPath("./board/insert.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/InsertAction.bo")){
			
			//	글 작성 Action 동작 실행
			
			action = new insertBoardAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			};
		}else if(command.equals("/BoardMain.bo")) {
			
			//	Board Main_page로 이동
			
			forward = new ActionForward();
			forward.setPath("./board/main_page.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/BoardContent.bo")) {
			
			//	board 글 내용 보기 페이지로 이동
			//	선택한 글 b_idx를 가지고 페이지 이동
			//	board_content.jsp
			
			System.out.println("/BoardContent.bo 주소 처리");
			
			action = new BoardContentAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/BoardUpdate.bo")) {
			
			//	board 글 수정 페이지로 이동
			//	선택한 글 b_idx를 가지고 페이지 이동
			//	 board_update.jsp
			
			System.out.println("/BoardUpdate.bo 주소 처리");
			
			action = new BoardUpdate();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/BoardUpdateAction.bo")) {
			
			//	board 글 수정 action 동작 처리
			
			System.out.println("/BoardUpdateAction.bo 주소 처리");
			
			action = new BoardUpdateAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/aHospital.bo")) {
			
			//	동물병원 정보 페이지로 이동
			
			forward = new ActionForward();
			forward.setPath("./board/hospital.jsp");
			forward.setRedirect(false);
		}else if(command.equals("/ParentTip.bo")) {
			
			//	양육 팁 동영상 페이지로 이동
			
			forward = new ActionForward();
			forward.setPath("./board/video.jsp");
			forward.setRedirect(false);

		}else if(command.equals("/BoardList.bo")){
			
			System.out.println("/BoardList.bo 주소 처리");
			
			// 카테고리 별 게시판 뷰 페이지로 이동
			
			action = new BoardListAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/InsertCommentAction.bo")) {
			
			//	board 답글 insert Action 실행
			
			action = new insertCommenctAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if(command.equals("/downloadAction.bo")){
			
			System.out.println("/downloadAction.bo 주소 처리");
			
			// 파일 다운로드
			action = new downloadAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/BoardDelete.bo")){
			
			System.out.println("/BoardDelete.bo 주소 처리");
			
			// 파일 다운로드
			action = new boardDeleteAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//action
		
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
