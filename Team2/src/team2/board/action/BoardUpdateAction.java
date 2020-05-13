package team2.board.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import team2.board.db.BoardDAO;
import team2.board.db.BoardDTO;

public class BoardUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		System.out.println("BoardUpdateAction 실행");
		ActionForward forward = new ActionForward();
		
		//	ServletContext context = request.getServletContext();
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/board"); // '/' 폴더에 대한 정보를 저장

		//	DB업로드 할 파일명 변수
		String b_file = "";
		//	받아올 request 변수
		Map<String, String> board = new HashMap<>();

		System.out.println("realPath : "+realPath);
		
		System.out.println("before : " + request.getParameter("b_category"));
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		System.out.println("after : " + request.getParameter("b_category"));
		if(!isMultipart) {
		}else {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			List items = null;
			try {
				items = upload.parseRequest(request);
			}catch(Exception e){
				System.err.println("Item get Error : " + e.toString());
				e.printStackTrace();
			}
			
			Iterator itr = items.iterator();
			while(itr.hasNext()) {
				FileItem item = (FileItem)itr.next();
				if(item.isFormField()) {
					//	request
					//	! type="file"
					System.out.println("fieldName : "+item.getFieldName());
					System.out.println("value : " + item.getString("utf-8"));
					
					//	HashMap을 이용해 Collection에 항목 추가
					board.put(item.getFieldName(), item.getString("utf-8"));
					
				}else {
					//	  type="file"
					try {
						//	업로드한 파일 및 파일명 확인
						String itemName = item.getName();
						System.out.println("File name = " + itemName);
						
						//	파일명을 현재시간으로 변경 후 저장
						String fileExt = itemName.substring(itemName.lastIndexOf("."));
				        String uploadedFileName = System.currentTimeMillis() + fileExt; 
				        System.out.println(fileExt);
				        System.out.println(uploadedFileName);
						
						//	DB에 저장할 파일명 변수에 파일명 추가
				        // b_file 시작 시 ","가 나와 if문으로 첫번째 값 그대로 저장
				        if(b_file == ""){
				        	b_file = uploadedFileName;
						}else{
							b_file +="," + uploadedFileName;
						}
				        
						File savedFile = new File(uploadedFileName);
						
						//	파일이름 저장
						System.out.println(savedFile.getName());
						
						//	저장할 경로에 파일 객체 생성
						File upFile = new File(realPath + "/" +savedFile.getName());
						
						//	파일 저장
						item.write(upFile);
						
					}catch(Exception e) {
						System.err.println("Write : " + e.toString());
						e.printStackTrace();
					}
				}
			}
		}
		
		System.out.println(board.toString());
		
		//	dto 생성 및 설정
		BoardDTO dto = new BoardDTO();
		dto.setB_idx(Integer.parseInt(board.get("num")));
		dto.setB_category(board.get("b_category"));
		dto.setB_title(board.get("b_title"));
		dto.setB_writer(id);
		dto.setB_content(board.get("b_content"));
		dto.setIp_addr(request.getRemoteAddr());
		dto.setB_file(b_file);
		dto.setB_p_code(board.get("b_p_code"));
		
		BoardDAO dao = new BoardDAO();
		
		//	insert 동작 실행
		int chk = dao.updateBoard(dto);
		
		//	dao 자원 해제
		dao.closeDB();
		
		//작성 후 리스트 이동  문자열(category)을 숫자로 전환후 파라미터값 전달
		cSet cset = new cSet();
		String category = board.get("b_category");
		cset.setCategory(category);
		System.out.println("카테고리 넘버 :" + cset.getC());
		System.out.println("카테고리 넘버 :" + category);
		
		if(chk >0){
			//	insert 성공
			System.out.println("글 등록 성공!");
			forward.setPath("./BoardList.bo?category="+cset.getC());
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
