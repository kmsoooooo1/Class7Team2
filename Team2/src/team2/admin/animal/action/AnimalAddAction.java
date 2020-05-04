package team2.admin.animal.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 1. 파일 업로드 (이미지 4개)
		
		// 파일 저장 위치
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/multiupload"); // '/' 폴더에 대한 정보를 저장
		
		//파일 크기 지정
		int maxSize = 10 * 1024 * 1024; //10MB
		
		//파일 업로드(cos.jar)
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8");
		
		// 2. AnimalDTO & AniamlDAO 객체 생성
		AnimalDTO adto = new AnimalDTO();
		adto.setCategory(multi.getParameter("category"));
		adto.setSub_category(multi.getParameter("sub_category"));
		adto.setSub_category_index(multi.getParameter("sub_category_index"));
		adto.setA_morph(multi.getParameter("a_morph"));
		adto.setA_sex(multi.getParameter("a_sex"));
		adto.setA_status(multi.getParameter("a_status"));
		adto.setA_code(multi.getParameter("a_code"));
		adto.setA_thumbnail(multi.getFilesystemName("a_thumbnail"));
		adto.setA_amount(Integer.parseInt(multi.getParameter("a_amount")));
		adto.setA_price_origin(Integer.parseInt(multi.getParameter("a_price_origin")));
		adto.setA_discount_rate(Integer.parseInt(multi.getParameter("a_discount_rate")));
		adto.setA_price_sale(Integer.parseInt(multi.getParameter("a_price_sale")));
		adto.setA_mileage(Integer.parseInt(multi.getParameter("a_mileage")));
		adto.setContent(multi.getParameter("ir1"));
		
		AnimalDAO adao = new AnimalDAO();
		adao.insertAnimal(adto);
		
		// 4. 페이지 이동(List 페이지)
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.ad");
		forward.setRedirect(true); //주소도 바뀌고 내용도 바뀌기 때문에 true	
		
		return forward;
	}
	
	

}
