package team2.board.action;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class downloadAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("downloadAction 호출!!");
		ServletContext context = request.getServletContext();
		
		String fileName = request.getParameter("file");
		
		//파일 실제 경로
		String realPath = context.getRealPath("/upload/board");
		
		File file = new File(realPath + "/" + fileName);
		
		String mimeType = context.getMimeType(file.toString());
		if (mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		
		String downloadName = null;
		
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downloadName = new String(fileName.getBytes("UTF-8"), "8859_1");
		}else {

			downloadName = new String(fileName.getBytes("EUC-KR"), "8859_1");
		}
		
		response.setHeader("Content-Disposition", "attachment;filename=\""
				+ downloadName + "\";");
	
		FileInputStream fileInputStream = new FileInputStream(file);
		
		ServletOutputStream servletOutputStream = response.getOutputStream();
		
		byte b[] = new byte[1024];
		int data = 0;
		
		while ((data = (fileInputStream.read(b, 0, b.length)))!= -1) {
			servletOutputStream.write(b, 0, data);
		}
		
		servletOutputStream.flush();
		servletOutputStream.close();
		fileInputStream.close();
		
		return null;
	}

}
