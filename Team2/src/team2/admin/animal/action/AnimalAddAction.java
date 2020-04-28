package team2.admin.animal.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AnimalAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 1. 파일 업로드 (이미지 4개)
		
		// 파일 저장 위치
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload"); // '/' 폴더에 대한 정보를 저장
		
		//파일 크기 지정
		int maxSize = 10 * 1024 * 1024; //10MB
		
		//파일 업로드(cos.jar)
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// 2. AnimalDTO 객체 생성 (전달받은 정보를 저장)
		
		//gdto.setNum(Integer.parseInt(multi.getParameter("num"))); -> DB에서 입력할수 있게 처리(DAO)
		//gdto.setDate(date); -> DB에서 입력할수 있게 처리(DAO)
		
		//여러개 이미지 처리
		//여러 이미지 파일을 하나의 string 파일로 묶어버리기
		String image = multi.getFilesystemName("file1") + "," + multi.getFilesystemName("file2") + "," + multi.getFilesystemName("file3") + "," + multi.getFilesystemName("file4");
		
		// 3. AnimalDAO 객체를 생성해서 처리
		
		
		// 4. 페이지 이동(List 페이지)
		ActionForward forward = new ActionForward(); //2개의 정보만 저장하는데 
		forward.setPath("./GoodsList.ag"); //가상경로를 만들어서 이동시키기
		forward.setRedirect(true); //주소도 바뀌고 내용도 바뀌기 때문에 true	
		
		return forward;
	}
	
	

}
