package team2.admin.coupon.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import team2.coupon.db.CouponDAO;
import team2.coupon.db.CouponDTO;

public class CouponAddAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		// 파일 저장 위치
		ServletContext context = request.getServletContext();
		String realPath = context.getRealPath("/upload/event"); // '/' 폴더에 대한 정보를 저장
		
		//파일 크기 지정
		int maxSize = 10 * 1024 * 1024; //10MB
		
		//파일 업로드(cos.jar)
		MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8");
		
		CouponDTO cdto = new CouponDTO();
		
		//넘어온 값 받기
		cdto.setCo_target(multi.getParameter("co_target"));
		cdto.setCo_name(multi.getParameter("co_name"));
		cdto.setCo_rate(multi.getParameter("co_rate"));
		cdto.setCo_startDate(multi.getParameter("co_startDate"));
		cdto.setCo_endDate(multi.getParameter("co_endDate"));
		cdto.setCo_status(multi.getParameter("co_status"));
		cdto.setCo_image(multi.getFilesystemName("co_image"));
		
		CouponDAO cdao = new CouponDAO();
		cdao.insertCoupon(cdto);
		
		// 4. 페이지 이동(List 페이지)
		ActionForward forward = new ActionForward();
		forward.setPath("./Main.ad");
		forward.setRedirect(true); //주소도 바뀌고 내용도 바뀌기 때문에 true	
		
		return forward;
	}
	
}
