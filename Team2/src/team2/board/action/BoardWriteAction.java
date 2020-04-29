package team2.board.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;


public class BoardWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("@@@ BoardWriteAction_excute 호출! @@@");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload");
		System.out.println("파일이 저장되는 곳 : " + realPath);
		
		int maxSize = 10 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(
				request,
				realPath,
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		request.setCharacterEncoding("UTF-8");
		
		
		BoardDTO bdto = new BoardDTO();
		
		bdto.setB_writer(multi.getParameter("writer"));
		bdto.setB_title(multi.getParameter("title"));
		bdto.setB_content(multi.getParameter("content"));
		bdto.setB_category(multi.getParameter("category"));
		bdto.setIp_addr(request.getRemoteAddr());;
		
		String file = multi.getFilesystemName("file1")+","
				+ multi.getFilesystemName("file2")+","
				+ multi.getFilesystemName("file3");
		bdto.setB_file(file);
		
		System.out.println("이미지 파일 정보 : " + file);
		System.out.println("DB 저장 정보 : " +bdto.toString());
		
		BoardDAO bdao = new BoardDAO();
		
		bdao.insertBoard(bdto);
		//bdao 자원 해제
		bdao.closeDB();
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("./BoardMain.bo");
		forward.setRedirect(true);
		
		return forward;
	}

}
