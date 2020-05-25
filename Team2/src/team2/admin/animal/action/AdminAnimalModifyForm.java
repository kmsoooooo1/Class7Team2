package team2.admin.animal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AdminAnimalModifyForm implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 전달인자(동물번호) 저장
		int num = Integer.parseInt(request.getParameter("num"));
		
		AnimalDAO adao = new AnimalDAO();
		
		//getAnimals(상품번호) -> 특정동물 정보 모두 가져오는 메서드
		AnimalDTO adto = adao.getAnimals(num);
		
		request.setAttribute("adto", adto);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_animal_modify.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}
