package team2.admin.animal.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import team2.animal.db.AnimalDAO;
import team2.animal.db.AnimalDTO;

public class AnimalListAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		AnimalDAO adao = new AnimalDAO();
		
		String category = request.getParameter("category");
		String sub_category = "";
		
		List<AnimalDTO> admin_animalList = adao.getAnimalList(category, sub_category);
		
		request.setAttribute("admin_animalList", admin_animalList); 
		
		ActionForward forward = new ActionForward();
		forward.setPath("./admin/admin_animal_list.jsp");
		forward.setRedirect(false);
		return forward;
	}
	
}
