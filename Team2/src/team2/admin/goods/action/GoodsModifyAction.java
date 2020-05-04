package team2.admin.goods.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class GoodsModifyAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println(" GoodsModifyAction_execute() 실행");
		
		
		
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
		// multipart 수정
		GoodsDTO gdto = new GoodsDTO();
		gdto.setNum(Integer.parseInt(multi.getParameter("num")));
		gdto.setCategory(multi.getParameter("category"));
		gdto.setSub_category(multi.getParameter("sub_category"));
		gdto.setSub_category_index(multi.getParameter("sub_category_index"));
		gdto.setG_name(multi.getParameter("g_name"));
		gdto.setG_code(multi.getParameter("g_code"));
		gdto.setG_thumbnail(multi.getFilesystemName("g_thumbnail"));
		gdto.setG_amount(Integer.parseInt(multi.getParameter("g_amount")));
		gdto.setG_price_origin(Integer.parseInt(multi.getParameter("g_price_origin")));
		gdto.setG_discount_rate(Integer.parseInt(multi.getParameter("g_discount_rate")));
		gdto.setG_price_sale(Integer.parseInt(multi.getParameter("g_price_sale")));
		gdto.setG_mileage(Integer.parseInt(multi.getParameter("g_mileage")));
		gdto.setContent(multi.getParameter("ir1"));
		System.out.println("수정할 상품 정보 : " + gdto);
		
		GoodsDAO gdao = new GoodsDAO();
		gdao.modifyGoods(gdto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./GoodsList.ag");
		forward.setRedirect(true);
		
		return forward;
	}
	
}
