package team2.animal.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.action.Action;
import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalDetailAction implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//넘겨준 동물의 코드 값 저장하기
		String a_code = request.getParameter("a_code");
		
		AnimalDAO adao = new AnimalDAO();
		//먼저 이 동물 페이지의 조회수 1업 하는 함수 호출해서 1업 시키기
		adao.updateAnimalViewCount(a_code);
		//동물의 세부정보 가져오기
		AnimalDTO adto = adao.getAnimalDetail(a_code);
		
		request.setAttribute("animalDetail", adto);
		
		//페이지 이동
		ActionForward forward = new ActionForward();
		forward.setPath("./animals/animals_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
