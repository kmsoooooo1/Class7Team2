package team2.board.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartFilter;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class insertBoardAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		
		//	수정중
		//	멀티파일업로드기능
		
		
		System.out.println("InsertAction 실행");
		ActionForward forward = new ActionForward();

		//	ServletContext context = request.getServletContext();
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/board"); // '/' 폴더에 대한 정보를 저장
		
		//파일 크기 지정
		int maxSize = 10 * 1024 * 1024; //10MB
		
		File file;
		
		String b_file = "";
		
		//파일 업로드(cos.jar)
		MultipartRequest multi = new MultipartRequest(
				request,
				realPath,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy());
		
		
		
		Enumeration files = multi.getFileNames();
		
		while(files.hasMoreElements()) {
			String name = (String)files.nextElement();
			file = multi.getFile(name);
			String str = file.getName();
			b_file +="," + str;
		}
		
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		System.out.println("b_file : " +b_file);
		
		
		//	dto 생성 및 설정
		BoardDTO dto = new BoardDTO();
		dto.setB_category(multi.getParameter("b_category"));
		dto.setB_p_cate(multi.getParameter("b_p_cate"));
		dto.setB_title(multi.getParameter("b_title"));
		dto.setB_writer(multi.getParameter(id));
		dto.setB_content(multi.getParameter("ir1"));
		dto.setIp_addr(request.getRemoteAddr());
		dto.setB_file(b_file);
		
		BoardDAO dao = new BoardDAO();
		
		//	insert 동작 실행
		int chk = dao.insert(dto);
		
		//	dao 자원 해제
		dao.closeDB();
		if(chk >0){
			//	insert 성공
			System.out.println("글 등록 성공!");
			forward.setPath("./BoardMain.bo");
			forward.setRedirect(true);
		}else{
			//	insert 실패
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.print("<script>");
			out.print("alert('등록 실패..');");
			out.print("history.back();");
			out.print("</script>");
			
			out.close();
		}
		return forward;
	}

}
