package team2.animal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalListAction implements Action{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//AnimalDAO() 객체 생성
		AnimalDAO adao = new AnimalDAO();
		
		//구분짓기 위한 변수 받기
		String category = request.getParameter("category");
		String sub_category = request.getParameter("sub_category");
		String sub_category_index = request.getParameter("sub_category_index");
		if(sub_category == null) {
			//만약 유저가 '파충류'나 '양서류'만 선택했을시 sub_category에는 All을 넣어서 모든 파충류 또는 양서류를 가지고 온다.
			sub_category = "all"; 
		}
		if(sub_category_index == null) {
			sub_category_index = "all";
		}
		
		List<AnimalDTO> animalList = adao.getAnimalList(category, sub_category, sub_category_index); 
		
		//등록된 모든 상품의 정보를 가져와서 request 영역에 저장
		request.setAttribute("animalList", animalList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("./animals/animals_list.jsp");
		forward.setRedirect(false); //주소가 바뀌지 않고 리스트를 보여줘야 하기 때문에

		return forward;
	}

}
