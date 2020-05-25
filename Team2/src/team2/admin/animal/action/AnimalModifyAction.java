package team2.admin.animal.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/multiupload");
		System.out.println("파일이 저장되는 곳(서버의 HDD) : " + realPath);
		
		int maxSize = 10 * 1024 * 1024;
		
		// 파일 업로드(cos.jar)
		MultipartRequest multi = 
				new MultipartRequest(
						request,
						realPath,
						maxSize,
						"UTF-8");
		
		// 전달된 정보(수정할 정보를 한번에 객체에 담아서 저장)
		AnimalDTO adto = new AnimalDTO();
		
		adto.setNum(Integer.parseInt(multi.getParameter("num")));
		adto.setCategory(multi.getParameter("category"));
		adto.setSub_category(multi.getParameter("sub_category"));
		adto.setSub_category_index(multi.getParameter("sub_category_index"));
		adto.setA_morph(multi.getParameter("a_morph"));
		adto.setA_sex(multi.getParameter("a_sex"));
		adto.setA_status(multi.getParameter("a_status"));
		adto.setA_code(multi.getParameter("a_code"));
		adto.setA_thumbnail(multi.getParameter("a_thumbnail"));
		adto.setA_amount(Integer.parseInt(multi.getParameter("a_amount")));
		adto.setA_price_origin(Integer.parseInt(multi.getParameter("a_price_origin")));
		adto.setA_discount_rate(Integer.parseInt(multi.getParameter("a_discount_rate")));
		adto.setA_price_sale(Integer.parseInt(multi.getParameter("a_price_sale")));
		adto.setA_mileage(Integer.parseInt(multi.getParameter("a_mileage")));
		adto.setContent(multi.getParameter("ir1"));
		System.out.println("수정할 동물 정보 :" +adto);
		
		AnimalDAO adao = new AnimalDAO();
		adao.modifyAnimals(adto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./AnimalList.aa");
		forward.setRedirect(true);
		
		return forward;
	}

}
