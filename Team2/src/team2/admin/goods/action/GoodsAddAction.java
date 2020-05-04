package team2.admin.goods.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import team2.goods.db.GoodsDAO;
import team2.goods.db.GoodsDTO;

public class GoodsAddAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 1. 파일 업로드(이미지 5개)
		// 파일 저장 위치
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/multiupload");
		System.out.println("파일이 저장되는 곳(서버의 HDD) : " + realPath);
		
		// 파일의 크기 지정
		int maxSize = 10 * 1024 * 1024;
		
		// 파일 업로드(cos.jar)
		MultipartRequest multi = 
				new MultipartRequest(
						request,
						realPath,
						maxSize,
						"UTF-8");
		
		
		// 2-0. 디비테이블 생성 : team2_goods
		
		// 2. GoodsDTO 객체 생성(전달받은 정보를 저장)
		GoodsDTO gdto = new GoodsDTO();
		//gdto.setNum(Integer.parseInt(multi.getParameter("num"))); -> 디비에서 입력
		gdto.setCategory(multi.getParameter("category"));
		gdto.setSub_category(multi.getParameter("sub_category"));
		gdto.setSub_category_index(multi.getParameter("sub_category_index"));
		gdto.setG_name(multi.getParameter("g_name"));
		gdto.setG_code(multi.getParameter("g_code"));
		
		String image = multi.getFilesystemName("file1")+","
				+ multi.getFilesystemName("file2")+","
				+ multi.getFilesystemName("file3")+","
				+ multi.getFilesystemName("file4")+","
				+ multi.getFilesystemName("file5");
		gdto.setG_image(image);
		gdto.setG_amount(Integer.parseInt(multi.getParameter("g_amount")));
		gdto.setG_price(Integer.parseInt(multi.getParameter("g_price")));
		gdto.setContent(multi.getParameter("content"));
		//gdto.setDate(multi.getParameter("date"));  -> 디비에서 입력
		
		System.out.println("이미지 파일정보 : " + image);
		System.out.println("GoodsDTO 저장완료 : " + gdto.toString());
		
		// 3. AdminGoodsDAO 객체를 생성해서 처리
		// -> insertGoods(dto)
		GoodsDAO gdao = new GoodsDAO();
		
		gdao.insertGoods(gdto);
		
		ActionForward forward = new ActionForward();
		
		forward.setPath("./Main.ad");
		forward.setRedirect(true);
		
		return forward;
	}
	
	
	

	
}
